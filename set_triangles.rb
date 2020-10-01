# frozen_string_literal: true

require 'json'
require_relative 'triangle'

# Class describing the set of triangles
class SetTriangles
  def initialize
    @triangles = []
  end

  def load_from_file(file_name)
    json_data = File.read(file_name, encoding: 'utf-8')
    ruby_objects = JSON.parse(json_data)
    ruby_objects.each do |shape|
      triangle = Triangle.new(shape['border-color'], shape['field-color'])
      triangle.add_points(shape['points'])
      @triangles.append(triangle)
    end
  end

  def print_triangles
    str = ''
    @triangles.each_with_index do |tr, index|
      str = "#{str} [Треугольник #{index + 1}: #{tr}]"
    end
    str
  end

  def to_s
    "Список треугольников: #{print_triangles}"
  end

  def filter_by_border_color(color)
    @triangles.select { |tr| tr.border_color.downcase == color.downcase }
  end

  def filter_by_field_color(color)
    @triangles.select { |tr| tr.field_color.downcase == color.downcase }
  end

  def perimeter_filter(up_s, down_s); end

  def triangle_filter(color); end

  def number_of_triangles_inside_rect; end

  def sort_by_area
    @triangles.sort { |tr| area(tr) }
  end

  def sort_by_bottom_left_top
    @triangles.sort { |tr| bottom_left_top(tr.points) }
  end

  def search_for_pairs_with_common_vertex; end

  def color_statistics; end

  private

  def side(point1, point2)
    Math.sqrt((point1[0] - point2[0])**2 + (point1[1] - point2[1])**2)
  end

  def perimeter(points)
    a = side(points[0].coordinates, points[1].coordinates)
    b = side(points[1].coordinates, points[2].coordinates)
    c = side(points[2].coordinates, points[0].coordinates)
    (a + b + c) / 2
  end

  def area(trian)
    a = side(trian.points[0].coordinates, trian.points[1].coordinates)
    b = side(trian.points[1].coordinates, trian.points[2].coordinates)
    c = side(trian.points[2].coordinates, trian.points[0].coordinates)
    p = perimeter(trian.points)
    Math.sqrt(p * (p - a) * (p - b) * (p - c))
  end
end
