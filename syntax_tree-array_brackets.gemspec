# frozen_string_literal: true

require_relative "lib/syntax_tree/array_brackets/version"

Gem::Specification.new do |spec|
  spec.name = "syntax_tree-array_brackets"
  spec.version = SyntaxTree::ArrayBrackets::VERSION
  spec.authors = ["Nobuo Takizawa"]
  spec.email = ["longzechangsheng@gmail.com"]

  spec.summary =
    "A syntax_tree plugin for force syntax_tree to using bracket array"
  spec.homepage = "https://github.com/nobuyo/syntax_tree-array_brackets"

  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.license = "MIT"
  spec.metadata = { "rubygems_mfa_required" => "true" }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files =
    Dir.chdir(__dir__) do
      `git ls-files -z`.split("\x0")
        .reject do |f|
          (File.expand_path(f) == __FILE__) ||
            f.start_with?(
              "bin/",
              "test/",
              "sig/",
              "spec/",
              "features/",
              ".git",
              ".circleci",
              "appveyor"
            )
        end
    end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "syntax_tree", ">= 2.0.1"
end
