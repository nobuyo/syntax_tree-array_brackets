# SyntaxTree::ArrayBrackets

A plugin for force syntax_tree to using bracket array.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add syntax_tree-array_brackets

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install syntax_tree-array_brackets

## Usage

### CLI

Pass a plugin option to syntax_tree cli:

```
--plugin=array_brackets
```

### Library

Add `require` to your code:

```ruby
require "syntax_tree/array_brackets"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/nobuyo/syntax_tree-array_brackets](https://github.com/nobuyo/syntax_tree-array_brackets).
