require "matching_exceptions/version"

module MatchingExceptions

  def self.extended(base)
    define_method :=== do |error_message|
      error_message.respond_to?(@method) && 
        (matches_string(error_message) || matches_regex(error_message))
    end

    define_method :matches_string do |error_message|
      @matching.is_a?(String) && error_message.send(@method).include?(@matching)
    end

    define_method :matches_regex do |error_message|
      @matching.is_a?(Regexp) && error_message.send(@method) =~ @matching
    end

    private :===, :matches_string, :matches_regex
  end

  extend self

  def matches(matching, on: 'message')
    tap do
      instance_variable_set(:@matching, matching)
      instance_variable_set(:@method, on)
    end
  end
end

ME = MatchingExceptions
