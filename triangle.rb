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

  def color_point?(color)
    @points.each do |point|
      return true if point.color.downcase == color.downcase
    end
    false
  end

  def triangle_type
    cos_tr = cos_angles
    cos_tr.each do |cos|
      return 'точки на прямой' if cos == -1
      return 'прямоугольный' if cos.zero?
      return 'тупоугольный' if cos.negative?
    end
    'остроугольный'
  end

  def bottom_left_point
    sort_y = @points.sort_by { |point| point.coordinates[1] }
    sort_x = sort_y.sort_by { |point| point.coordinates[0] }
    puts sort_x[0]
    sort_x[0].coordinates
  end

  def inside_rect?(b_l_point, t_r_point)
    xl = b_l_point[0]
    yl = b_l_point[1]
    xr = t_r_point[0]
    yr = t_r_point[1]
    @points.each do |point|
      return false if (point.coordinates[0] < xl) || (point.coordinates[0] > xr) ||
                      (point.coordinates[1] < yl) || (point.coordinates[1] > yr)
    end
    true
  end

  def all_colors_tr
    colors = []
    colors.append(@border_color, @field_color)
    @points.each do |point|
      colors.append(point.color)
    end
    colors
  end

  private

  def cos_angles
    tr_sides = sides
    a = tr_sides[0]
    b = tr_sides[1]
    c = tr_sides[2]
    res_cos = []
    res_cos.append(Float((b**2 + c**2 - a**2) / (2 * b * c)))
    res_cos.append(Float((a**2 + c**2 - b**2) / (2 * a * c)))
    res_cos.append(Float((a**2 + c**2 - c**2) / (2 * a * b)))
    res_cos
  end

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
