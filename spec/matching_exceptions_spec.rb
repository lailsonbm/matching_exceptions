require "spec_helper"

RSpec.describe MatchingExceptions do
  class CustomError < StandardError
    attr_reader :custom_attribute

    def initialize(message, custom_attribute)
      @custom_attribute = custom_attribute
      super(message)
    end
  end

  it "has a version number" do
    expect(MatchingExceptions::VERSION).not_to be nil
  end

  it "allows exceptions to be rescued by message" do
    rescued = false

    begin
      raise StandardError.new("error message")
    rescue ME.matches("message")
      rescued = true
    end

    expect(rescued).to be_truthy
  end

  it "allows exceptions to be rescued by regular expressions" do
    rescued = false

    begin
      raise StandardError.new("error message")
    rescue ME.matches(/MESSAGE/i)
      rescued = true
    end

    expect(rescued).to be_truthy
  end

  it "rescues by specified attribute" do
    rescued = false

    begin
      raise CustomError.new("blabla", "custom message")
    rescue ME.matches(/message/, on: :custom_attribute)
      rescued = true
    end

    expect(rescued).to be_truthy
  end

  it "ignores non existing attributes" do
    rescued = false

    begin
      raise CustomError.new("blabla", "custom message")
    rescue ME.matches(/message/, on: :foo)
      rescued = true
    rescue
    end

    expect(rescued).to be_falsy
  end

  context 'when there are multiple rescues' do
    it 'rescues the correct error' do
      rescued = false

      begin
        raise StandardError.new("rescue me!")
      rescue ME.matches(/not me/)
        rescued = false
      rescue ME.matches(/me!/)
        rescued = true
      end

      expect(rescued).to be_truthy
    end
  end
end
