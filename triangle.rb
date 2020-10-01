# frozen_string_literal: true

require_relative 'point'

# Class describing the triangle
class Triangle
  attr_reader :border_color
  attr_reader :field_color
  attr_reader :points

  def initialize(border_color, field_color)
    @border_color = border_color
    @field_color = field_color
    @points = []
  end

  def add_points(my_points)
    my_points.each do |point|
      @points.append(Point.new(point['color'], point['coordinates']))
    end
  end

  def print_points
    str = ''
    @points.each_with_index do |point, index|
      str = "#{str} [Точка #{index + 1} - color: #{point.color}, coordinates: #{point.coordinates}]"
    end
    str
  end

  def to_s
    "Border-color: #{@border_color}, Field-color: #{@field_color}, points: {#{print_points}}"
  end
end
