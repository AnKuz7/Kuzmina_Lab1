# frozen_string_literal: true

# Class describing the point
class Point
  attr_reader :color
  attr_reader :coordinates

  def initialize(color, coordinates)
    @color = color
    @coordinates = coordinates
  end

  def to_s
    "цвет: #{@color}, координаты: #{@coordinates}"
  end
end
