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
              StringContent.new(parts: [element], location: nil)
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
          str_contents =
            elements.map do |element|
              SymbolLiteral.new(value: element, location: nil)
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
end
