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
    color = prompt.ask('Введите цвет', default: 'silver') do |q|
      q.modify :strip, :collapse
    end
    puts triangles.filter_by_field_color(color)
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

  def self.ch_5(triangles, prompt); end

  def self.ch_6(triangles, prompt); end

  def self.ch_7(triangles, _prompt)
    puts triangles.sort_by_area
  end

  def self.ch_8(triangles, _prompt); end

  def self.ch_9(triangles, prompt); end

  def self.ch_10(triangles, prompt); end
end
