module Validator
	
  # the application should discard all commands in the sequence until a valid PLACE command has been executed.
  def check_first_command_is_place(commands)
    new_arr = []
    has_place = false
    if commands[0].split(' ')[0] != 'PLACE'
      commands.each_with_index do |command, index|
        if command.split(' ')[0] == 'PLACE'
          length = commands.length
          new_arr = commands[index..length]
          has_place = true
        end
      end
      commands = new_arr
    else
      has_place = true
    end
    commands = nil if has_place == false
    commands
  end

  # The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot.
  def validate_place_command(commands)
    arr = commands[0].split(' ')[1].split(',')
    if arr[0].to_i > 4 || arr[1].to_i > 4
      commands.delete(commands[0])
      check_first_command_is_place(commands)
    end
  end
end