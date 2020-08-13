# frozen_string_literal: true

require_relative 'validator'

# The Robot class
class Robot
  include Validator

  def initialize
    @x = 0
    @y = 0
    @face = ''
  end

  def execute_commands(commands)
    commands = check_first_command_is_place(commands)
    if commands.nil?
      'Your commands do not have any PLACE command'
    else
      validate_place_command(commands)
      perform(commands)
    end
  end

  private

  def initial_position(commands)
    arr = commands[0].split(' ')[1].split(',')
    @x = arr[0].to_i
    @y = arr[1].to_i
    @face = arr[2]
  end

  def perform(commands)
    initial_position(commands)
    commands.shift
    perform_command(commands)
  end

  # rubocop:disable Metrics/MethodLength
  def perform_command(commands)
    face_change_for_left = { 'NORTH' => 'WEST', 'WEST' => 'SOUTH',
                             'SOUTH' => 'EAST', 'EAST' => 'NORTH' }
    face_change_for_right = { 'NORTH' => 'EAST', 'WEST' => 'NORTH',
                              'SOUTH' => 'WEST', 'EAST' => 'SOUTH' }
    commands.each do |command|
      command = command.strip
      if command == 'LEFT'
        @face = face_change_for_left[@face]
      elsif command == 'RIGHT'
        @face = face_change_for_right[@face]
      elsif command == 'MOVE'
        perform_move
      elsif command == 'REPORT'
        return "X, Y coordinate of robot are: #{@x}, #{@y}, facing is #{@face}"
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  def perform_move
    case @face
    when 'NORTH'
      @y += 1
    when 'SOUTH'
      @y -= 1
    when 'WEST'
      @x -= 1
    when 'EAST'
      @x += 1
    end
  end
end

commands = IO.readlines(ARGV[0])
p Robot.new.execute_commands(commands)
