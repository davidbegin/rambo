require "spec_helper"

describe Rambo::RSpec::Examples do
  let(:raml_file) { File.expand_path("../../support/foobar.raml", __FILE__) }
  let(:raml) { Raml::Parser.parse(File.read(raml_file)) }

  subject { Rambo::RSpec::Examples.new(raml: raml) }

  describe "#generate!" do
    it "calls render on each group" do
      expect_any_instance_of(Rambo::RSpec::ExampleGroup).to receive(:render)
      subject.generate!
    end

    it "returns an array of strings" do
      aggregate_failures do
        expect(subject.generate!).to be_a(Array)
        expect(subject.generate!.first).to be_a(String)
      end
    end
  end

  describe "#compose" do
    before(:each) { subject.generate! }

    it "returns a string" do
      expect(subject.compose).to be_a(String)
    end
  end
end
