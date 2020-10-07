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
      str = "#{str} [Точка #{index + 1} - #{point}]"
    end
    str
  end

  def to_s
    "{ Цвет границы: #{@border_color}, Цвет заливки: #{@field_color}, точки: #{print_points} }"
  end

  def perimeter
    tr_sides = sides
    a = tr_sides[0]
    b = tr_sides[1]
    c = tr_sides[2]
    (a + b + c) / 2
  end

  def area
    tr_sides = sides
    a = tr_sides[0]
    b = tr_sides[1]
    c = tr_sides[2]
    p = (a + b + c) / 2
    Math.sqrt(p * (p - a) * (p - b) * (p - c))
  end

  def is_color_point(color)
    @points.each do |point|
      if point.color.downcase == color.downcase
        return true
      end
    end
    false
  end

  private

  def sides
    res_sides = []
    res_sides.append(side(@points[0].coordinates, @points[1].coordinates))
    res_sides.append(side(@points[1].coordinates, @points[2].coordinates))
    res_sides.append(side(@points[2].coordinates, @points[0].coordinates))
    res_sides
  end

  def side(point1, point2)
    x = (point1[0] - point2[0])**2
    y = (point1[1] - point2[1])**2
    Math.sqrt(x + y)
  end
end
