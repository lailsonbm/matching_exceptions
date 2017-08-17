require "matching_exceptions/version"

module MatchingExceptions
  extend self

  def matches(matching, attribute: 'message')
    klass = Class.new do
      def self.===(other)
        return false unless other.respond_to?(@attribute)
        return other.send(@attribute).include?(@matching) if @matching.is_a?(String)
        return other.send(@attribute) =~ @matching if @matching.is_a?(Regexp)
        false
      end
    end

    klass.instance_variable_set(:@matching, matching)
    klass.instance_variable_set(:@attribute, attribute)
    klass
  end
end

ME = MatchingExceptions
