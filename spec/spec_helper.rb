require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start if ENV['COVERAGE']

require 'rspec'
require 'rspec/core'
require 'rspec/matchers'
require 'rspec/expectations'

require_relative '../lib/cli'