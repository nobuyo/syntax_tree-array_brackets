# frozen_string_literal: true

module SyntaxTree
  class ArrayLiteral
    def format(q)
      lbracket = self.lbracket
      contents = self.contents

      # deleted formatting bracket array to percent array

      if empty_with_comments?
        EmptyWithCommentsFormatter.new(lbracket).format(q)
        return
      end

      q.group do
        q.format(lbracket)

        if contents
          q.indent do
            q.breakable_empty
            q.format(contents)
            q.if_break { q.text(",") } if q.trailing_comma?
          end
        end

        q.breakable_empty
        q.text("]")
      end
    end
  end

  class QWords
    def format(q)
      opening, closing = "[", "]"

      q.group do
        q.text(opening)

        unless elements.empty?
          loc = elements.first.location.to(elements.last.location)
          str_contents =
            elements.map do |element|
              copy =
                element.copy(
                  value: element.value.gsub(/([^\\])\\ /, "\\1 "),
                  location: element.location
                )
              StringContent.new(parts: [copy], location: nil)
            end
          contents = Args.new(parts: str_contents, location: loc)

          q.indent do
            q.breakable_empty
            q.format(contents)
            q.if_break { q.text(",") } if q.trailing_comma?
          end
        end

        q.breakable_empty
        q.text(closing)
      end
    end
  end

  class QSymbols
    def format(q)
      opening, closing = "[", "]"

      q.group do
        q.text(opening)

        unless elements.empty?
          loc = elements.first.location.to(elements.last.location)
          literals = convert_to_literals(q, elements)
          contents = Args.new(parts: literals, location: loc)

          q.indent do
            q.breakable_empty
            q.format(contents)
            q.if_break { q.text(",") } if q.trailing_comma?
          end
        end

        q.breakable_empty
        q.text(closing)
      end
    end

    private

    def convert_to_literals(q, elements)
      elements.map do |element|
        value =
          if element.value.intern.inspect.include?("\"") # consider symbols like :"foo:bar", :"?"
            get_intern_representation(q, element.value)
          else
            element.value
          end
        copy =
          element.copy(
            value: value.gsub(/([^\\])\\ /, "\\1 "),
            location: element.location
          )

        SymbolLiteral.new(value: copy, location: nil)
      end
    end

    def get_intern_representation(q, value)
      if value == q.quote
        return "\"\\\"\"" if q.quote == "\""
        return "\'\\\'\'" if q.quote == "'" # rubocop:disable Style/RedundantStringEscape
      end

      "#{q.quote}#{value}#{q.quote}"
    end
  end
end
