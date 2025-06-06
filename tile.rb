# frozen_string_literal: true

require 'colorize'
# Tile class
class Tile
  attr_reader :value

  def initialize(value)
    @value = value
    @given = value.zero? ? false : true
  end

  def given?
    @given
  end

  def color
    given? ? :red : :blue
  end

  def to_s
    @value.zero? ? ' ' : @value.to_s.colorize(color)
  end

  def value=(val)
    if given?
      puts 'You cant make changes to a already given value'
    else
      @value = val
    end
  end
end
