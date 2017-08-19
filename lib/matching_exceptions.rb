require "matching_exceptions/version"

module MatchingExceptions
  attr_accessor :klass

  def self.extended(base)
    define_method :=== do |other|
      return false unless other.respond_to?(@method)
      return other.send(@method).include?(@matching) if @matching.is_a?(String)
      return other.send(@method) =~ @matching if @matching.is_a?(Regexp)
      false
    end
  end

  extend self

  def matches(matching, on: 'message')
    self.instance_variable_set(:@matching, matching)
    self.instance_variable_set(:@method, on)
    self
  end
end

ME = MatchingExceptions
