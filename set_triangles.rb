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
      str = "#{str} \n Треугольник #{index + 1}: #{tr}"
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

  def filter_by_point_color(color)
    @triangles.select { |tr| tr.color_point?(color) }
  end

  def perimeter_filter(up_s, down_s)
    @triangles.select { |tr| tr.perimeter > down_s and tr.perimeter < up_s }
  end

  def triangle_filter; end

  def number_of_triangles_inside_rect; end

  def sort_by_area
    @triangles.sort { |tr| tr.area }
  end

  def sort_by_bottom_left_top; end

  def search_for_pairs_with_common_vertex; end

  def color_statistics; end
end
