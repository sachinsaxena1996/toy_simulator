class Robot

  def initialize
    @x = 0
    @y = 0
    @face = ""
  end

  def execute_commands(commands)
    commands = check_firt_command_is_place(commands)
    validate_place_command(commands)
    perform(commands)
  end

  def perform(commands)
    arr = commands[0].split(' ')[1].split(',')
    @x = arr[0].to_i
    @y = arr[1].to_i
    @face = arr[2]    
    face_change_for_left = {"NORTH" => "WEST", "WEST" => "SOUTH", "SOUTH" => "EAST", "EAST" => "NORTH"}
    face_change_for_right = {"NORTH" => "EAST", "WEST" => "NORTH", "SOUTH" => "WEST", "EAST" => "SOUTH"}
    commands.shift
    commands.each do |command|            
        command = command.strip       
      if command == 'LEFT'
        @face = face_change_for_left[@face]
      elsif command == 'RIGHT'
        @face = face_change_for_right[@face]
      elsif command == 'MOVE'
        if @face == 'NORTH'         
          @y = @y + 1
        elsif @face == 'SOUTH'
          @y = @y - 1
        elsif @face == 'WEST'
          @x = @x - 1
        elsif @face == 'EAST'
          @x = @x + 1
        end       
      elsif command == 'REPORT'
        puts "X, Y coordinate of robot are: #{@x}, #{@y} and facing is #{@face}"
      end
    end
  end

  #x <= 4 y <= 4
  # the application should discard all commands in the sequence until a valid PLACE command has been executed.
  def check_firt_command_is_place(commands)
    new_arr = []
    if commands[0].split(' ')[0] != 'PLACE'
      commands.each_with_index do |command, index|
        if command.split(' ')[0] == 'PLACE'
          length = commands.length
          new_arr = commands[index..length]
        end
      end
      commands = new_arr
    end
    commands
  end

  # The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot.
  def validate_place_command(commands)
    arr = commands[0].split(' ')[1].split(',')
    if arr[0].to_i > 4 || arr[1].to_i > 4
      commands.delete(commands[0])
      check_firt_command_is_place(commands)
    end
  end
end

commands = IO.readlines("input.txt")
Robot.new.execute_commands(commands)