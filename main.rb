# frozen_string_literal: true

require_relative 'set_triangles'
require_relative 'dialogue_user'

def main
  triangles = SetTriangles.new
  begin
    triangles.load_from_file(File.expand_path('triangles.json', __dir__))
  rescue StandardError
    abort 'Не был найден файл triangles.json'
  end
  DialogueUser.dialogue(triangles)
end

main if __FILE__ == $PROGRAM_NAME
