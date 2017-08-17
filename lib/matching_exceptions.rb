require "matching_exceptions/version"

module MatchingExceptions
  extend self

  def matches(matching)
    klass = Class.new do
      def self.===(other)
        return other.message.include?(@matching) if @matching.is_a?(String)
        return other.message =~ @matching if @matching.is_a?(Regexp)
        false
      end
    end

    klass.instance_variable_set(:@matching, matching)
    klass
  end
end

ME = MatchingExceptions
