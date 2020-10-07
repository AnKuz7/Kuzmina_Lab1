# frozen_string_literal: true

require 'tty-prompt'
require_relative 'set_triangles'

# Dialogue witha a user
module DialogueUser
  def self.dialogue(triangles)
    prompt = TTY::Prompt.new(interrupt: :exit)
    loop do
      choices = [{ key: 1, name: 'Список треугольников', value: 1 },
                 { key: 2, name: 'Фильтр по цвету границы', value: 2 },
                 { key: 3, name: 'Фильтр по цвету вершин', value: 3 },
                 { key: 4, name: 'Фильтр по периметру треугольника', value: 4 },
                 { key: 5, name: 'Фильтр по типу треугольника', value: 5 },
                 { key: 6, name: 'Количество треугольников внутри прямоугольника', value: 6 },
                 { key: 7, name: 'Сортировка по площади треугольника', value: 7 },
                 { key: 8, name: 'Сортировка по нижней левой вершине', value: 8 },
                 { key: 9, name: 'Поиск пар треугольников с общей вершиной', value: 9 },
                 { key: 10, name: 'Статистика по цветам', value: 10 },
                 { key: 11, name: 'Выход', value: 11 }]
      choice = prompt.enum_select('Выберите пункт из меню', choices)
      DialogueUser.user_choice(choice, triangles, prompt)
    end
  end

  def self.user_choice(u_choice, triangles, prompt)
    case u_choice
    when 1
      puts triangles
    when 2
      DialogueUser.ch_2(triangles, prompt)
    when 3
      DialogueUser.ch_3(triangles, prompt)
    when 4
      DialogueUser.ch_4(triangles, prompt)
    when 5
      DialogueUser.ch_5(triangles, prompt)
    when 6
      DialogueUser.ch_6(triangles, prompt)
    when 7
      DialogueUser.ch_7(triangles, prompt)
    when 8
      DialogueUser.ch_8(triangles, prompt)
    when 9
      DialogueUser.ch_9(triangles, prompt)
    when 10
      DialogueUser.ch_10(triangles, prompt)
    when 11
      prompt.warn('Вы завершили выполнение программы')
      abort
    end
  end

  def self.ch_2(triangles, prompt)
    color = prompt.ask('Введите цвет', default: 'brown') do |q|
      q.modify :strip, :collapse
    end
    puts triangles.filter_by_border_color(color)
  end

  def self.ch_3(triangles, prompt)
    color = prompt.ask('Введите цвет', default: 'black') do |q|
      q.modify :strip, :collapse
    end
    puts triangles.filter_by_point_color(color)
  end

  def self.ch_4(triangles, prompt)
    up = prompt.ask('Введите верхюю груницу периметра', default: '20.6', convert: :float) do |q|
      q.convert(:float, 'Вы ввели не вещественное число!')
    end
    down = prompt.ask('Введите нижнюю груницу периметра', default: '5.0', convert: :float) do |q|
      q.convert(:float, 'Вы ввели не вещественное число!')
    end
    puts triangles.perimeter_filter(up, down)
  end

  def self.ch_5(triangles, prompt)
    choices = ['точки на прямой', 'прямоугольный', 'тупоугольный', 'остроугольный']
    choice = prompt.enum_select('Выберете тип треугольника', choices)
    puts triangles.triangle_filter(choice)
  end

  def self.ch_6(triangles, prompt)
    rect_x = prompt.ask('Введите координату x нижней левой вершины прямоугольника',
                        default: '0', convert: :int) do |q|
      q.convert(:int, 'Вы ввели не целое число!')
    end
    rect_y = prompt.ask('Введите координату y нижней левой вершины прямоугольника',
                        default: '0', convert: :int) do |q|
      q.convert(:int, 'Вы ввели не целое число!')
    end
    width = prompt.ask('Введите ширину прямоугольника', default: '5', convert: :int) do |q|
      q.convert(:int, 'Вы ввели не целое число!')
    end
    height = prompt.ask('Введите высоту прямоугольника', default: '5', convert: :int) do |q|
      q.convert(:int, 'Вы ввели не целое число!')
    end
    puts "Кол-во: #{triangles.number_of_triangles_inside_rect([rect_x, rect_y], width, height)}"
  end

  def self.ch_7(triangles, _prompt)
    puts triangles.sort_by_area
  end

  def self.ch_8(triangles, _prompt)
    puts triangles.sort_by_bottom_left_point
  end

  def self.ch_9(triangles, _prompt)
    all_pairs = triangles.search_for_pairs_with_common_point
    all_pairs.each_with_index do |pair, ind|
      puts "Пара №#{ind + 1}: #{pair[0]}, #{pair[1]}"
      puts ''
    end
  end

  def self.ch_10(triangles, _prompt)
    statistics = triangles.color_statistics
    statistics.each do |st|
      puts "Цвет: #{st[:color]}, цвет границы: #{st[:border_color]}," \
        "цвет заливки: #{st[:field_color]}, цвет вершин #{st[:point_color]}"
    end
  end
end
