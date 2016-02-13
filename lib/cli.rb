require 'fileutils'

module Rambo
  class CLI
    attr_accessor :file, :stdout

    def initialize(stdout=STDOUT)
      @stdout = stdout
      @file = ARGV[0]
      run!
    end

    def validate!
      if !file
        exit_missing_file
      elsif !file.match(/\.raml$/)
        exit_invalid_file_format
      end
    end

    def run!
      validate!

      basename = file.gsub(/\.raml$/, '')

      FileUtils.mkdir_p "spec/contract"
      FileUtils.touch "spec/contract/#{basename}_spec.rb"
    end

    protected
      def exit_missing_file
        stdout.puts "USAGE: rambo [FILE]"
        exit 1
      end

      def exit_invalid_file_format
        stdout.puts "Unsupported file format. Please choose a RAML file."
        exit 1
      end
  end
end