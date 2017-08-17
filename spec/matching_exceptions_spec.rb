require "spec_helper"

RSpec.describe MatchingExceptions do
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
end
