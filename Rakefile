# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"
require "syntax_tree/rake_tasks"

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new
SyntaxTree::Rake::CheckTask.new()

task default: [:spec, :rubocop, :"stree:check"]
