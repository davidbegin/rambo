require 'fileutils'
require 'raml-rb'

require_relative './rspec/spec_file'

module Rambo
  class DocumentGenerator
    attr_accessor :file, :raml

    def initialize(file)
      @file = file
      @raml = Raml::Parser.parse_file(file)
    end

    def generate_spec_dir!
      FileUtils.mkdir_p('spec/contract')
    end

    def generate_spec_file!
      spec_file_name = file.match(/[^\/]*\.raml$/).to_s.gsub(/\.raml$/, '_spec.rb')
      contents       = Rambo::RSpec::SpecFile.new(raml: raml).render
      File.open("spec/contract/#{spec_file_name}", "w+") do |file|
        file.puts contents
      end
    end

    def generate_spec_helper!
      unless File.exist?("spec/spec_helper.rb")
        File.open("spec/spec_helper.rb", "a+") do |file|
          file.puts "\nrequire 'rack/test'\nrequire 'json'"
        end
      end
    end
  end
end
