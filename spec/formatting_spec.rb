# frozen_string_literal: true

require "spec_helper"

RSpec.describe "formatting" do
  context "bracket array that is made of strings" do
    it "ignores when the array has only one element" do
      source = "[\"foo\"]\n"
      formatted = SyntaxTree::Formatter.format(source, SyntaxTree.parse(source))

      expect(formatted).to eq source
    end

    it "ignores when the array has two or more elements" do
      source = "[\"foo\", \"bar\"]\n"
      formatted = SyntaxTree::Formatter.format(source, SyntaxTree.parse(source))

      expect(formatted).to eq source
    end
  end

  context "bracket array that is made of symbols" do
    it "ignores when the array has only one element" do
      source = "[:foo]\n"
      formatted = SyntaxTree::Formatter.format(source, SyntaxTree.parse(source))

      expect(formatted).to eq source
    end

    it "ignores when the array has two or more elements" do
      source = "[:foo, :bar]\n"
      formatted = SyntaxTree::Formatter.format(source, SyntaxTree.parse(source))

      expect(formatted).to eq source
    end
  end

  context "bracket array that is made of numbers" do
    it "ignores when the array has only one element" do
      source = "[1]\n"
      formatted = SyntaxTree::Formatter.format(source, SyntaxTree.parse(source))

      expect(formatted).to eq source
    end

    it "ignores when the array has two or more elements" do
      source = "[1, 2]\n"
      formatted = SyntaxTree::Formatter.format(source, SyntaxTree.parse(source))

      expect(formatted).to eq source
    end
  end

  context "qwords" do
    it "formats to bracket array when the array has only one element" do
      source = "%w[foo]\n"
      expected = "[\"foo\"]\n"
      formatted = SyntaxTree::Formatter.format(source, SyntaxTree.parse(source))

      expect(formatted).to eq expected
    end

    it "formats to bracket array when qwords has two or more elements" do
      source = "%w[foo bar]\n"
      expected = "[\"foo\", \"bar\"]\n"
      formatted = SyntaxTree::Formatter.format(source, SyntaxTree.parse(source))

      expect(formatted).to eq expected
    end
  end

  context "words" do
    it "ignores `%W` literal when there is only one element" do
      source = "%W[foo]\n"
      formatted = SyntaxTree::Formatter.format(source, SyntaxTree.parse(source))

      expect(formatted).to eq source
    end

    it "formats `%W` literal when there are two or more elements" do
      source = '%W[foo #{bar}-baz]' + "\n"
      formatted = SyntaxTree::Formatter.format(source, SyntaxTree.parse(source))

      expect(formatted).to eq source
    end

    it "formats to multiline bracket array when qsymbols has a lot elements" do
      source =
        "%w[foo bar baz quux foo bar baz quux foo bar baz quux foo bar baz quux]\n"
      expected =
        "[\n  \"foo\",\n  \"bar\",\n  \"baz\",\n  \"quux\",\n  \"foo\",\n  \"bar\",\n  \"baz\",\n  \"quux\",\n  \"foo\",\n  \"bar\",\n  \"baz\",\n  \"quux\",\n  \"foo\",\n  \"bar\",\n  \"baz\",\n  \"quux\"\n]\n"
      formatted = SyntaxTree::Formatter.format(source, SyntaxTree.parse(source))

      expect(formatted).to eq expected
    end
  end

  context "qsymbols" do
    it "formats to bracket array when the array has only one element" do
      source = "%i[foo]\n"
      expected = "[:foo]\n"
      formatted = SyntaxTree::Formatter.format(source, SyntaxTree.parse(source))

      expect(formatted).to eq expected
    end

    it "formats to bracket array when qsymbols has two or more elements" do
      source = "%i[foo bar]\n"
      expected = "[:foo, :bar]\n"
      formatted = SyntaxTree::Formatter.format(source, SyntaxTree.parse(source))

      expect(formatted).to eq expected
    end

    it "formats to multiline bracket array when qsymbols has a lot elements" do
      source =
        "%i[foo bar baz quux foo bar baz quux foo bar baz quux foo bar baz quux]\n"
      expected =
        "[\n  :foo,\n  :bar,\n  :baz,\n  :quux,\n  :foo,\n  :bar,\n  :baz,\n  :quux,\n  :foo,\n  :bar,\n  :baz,\n  :quux,\n  :foo,\n  :bar,\n  :baz,\n  :quux\n]\n"
      formatted = SyntaxTree::Formatter.format(source, SyntaxTree.parse(source))

      expect(formatted).to eq expected
    end
  end

  context "symbols" do
    it "ignores `%W` literal when there is only one element" do
      source = "%I[foo]\n"
      formatted = SyntaxTree::Formatter.format(source, SyntaxTree.parse(source))

      expect(formatted).to eq source
    end

    it "formats `%W` literal when there are two or more elements" do
      source = '%I[foo #{bar}-baz]' + "\n"
      formatted = SyntaxTree::Formatter.format(source, SyntaxTree.parse(source))

      expect(formatted).to eq source
    end
  end
end
