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

  def triangle_filter(type)
    @triangles.select { |tr| tr.triangle_type == type }
  end

  def number_of_triangles_inside_rect(b_l_point, width, height)
    t_r_point = [b_l_point[0] + width, b_l_point[1] + height]
    count = 0
    @triangles.each do |tr|
      count += 1 if tr.inside_rect?(b_l_point, t_r_point)
    end
    count
  end

  def sort_by_area
    @triangles.sort_by { |tr| tr.area }
  end

  def sort_by_bottom_left_point
    @triangles.sort_by { |tr| [tr.bottom_left_point[0], tr.bottom_left_point[1]] }
  end

  def search_for_pairs_with_common_point
    all_pairs = []
    all_triangles = @triangles
    @triangles.each do |tr1|
      all_triangles.each do |tr2|
        unless tr1 == tr2
          all_pairs.append([tr1, tr2]) if common_points?(tr1, tr2)
        end
      end
    end
    all_pairs
  end

  def color_statistics
    colors = all_colors
    statistics = []
    colors.each do |color|
      st_color = { color: color, border_color: 0, field_color: 0, point_color: 0 }
      @triangles.each do |tr|
        st_color[:border_color] += 1 if color == tr.border_color
        st_color[:field_color] += 1 if color == tr.field_color
        st_color[:point_color] += 1 if tr.color_point?(color)
      end
      statistics.append(st_color)
    end
    statistics
  end

  private

  def all_colors
    colors = []
    @triangles.each do |tr|
      tr_colors = tr.all_colors_tr
      tr_colors.each do |tr_c|
        colors.append(tr_c)
      end
    end
    colors = colors.uniq
  end

  def common_points?(tr1, tr2)
    points_tr1 = tr1.points
    points_tr2 = tr2.points
    points_tr1.each do |p_tr1|
      return true if common_point?(p_tr1.coordinates, points_tr2)
    end
    false
  end

  def common_point?(point, tr_points)
    tr_points.each do |tr_p|
      return true if points_equal?(point, tr_p.coordinates)
    end
    false
  end

  def points_equal?(point1, point2)
    return true if (point1[0] == point2[0]) && (point1[1] == point2[1])

    false
  end
end
