require "matching_exceptions/version"

module MatchingExceptions
  extend self

  def matches(matching, on: 'message')
    klass = Class.new do
      def self.===(other)
        return false unless other.respond_to?(@method)
        return other.send(@method).include?(@matching) if @matching.is_a?(String)
        return other.send(@method) =~ @matching if @matching.is_a?(Regexp)
        false
      end
    end

    klass.instance_variable_set(:@matching, matching)
    klass.instance_variable_set(:@method, on)
    klass
  end
end

ME = MatchingExceptions
