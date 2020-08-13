# frozen_string_literal: true

# Validator module
module Validator
  # rubocop:disable Metrics/MethodLength
  def check_first_command_is_place(commands)
    new_arr = []
    has_place = false
    if commands[0].split(' ')[0] != 'PLACE'
      commands.each_with_index do |command, index|
        next unless command.split(' ')[0] == 'PLACE'

        length = commands.length
        new_arr = commands[index..length]
        has_place = true
      end
      commands = new_arr
    else
      has_place = true
    end
    commands = nil if has_place == false
    commands
  end
  # rubocop:enable Metrics/MethodLength

  def validate_place_command(commands)
    arr = commands[0].split(' ')[1].split(',')
    return unless arr[0].to_i > 4 || arr[1].to_i > 4

    commands.delete(commands[0])
    check_first_command_is_place(commands)
  end
end
