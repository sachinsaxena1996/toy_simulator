# frozen_string_literal: true

require './robot'

RSpec.describe Robot do 

	describe "execute_commands" do		
		let(:commands_with_place) { ["PLACE 1,2,EAST\n", "MOVE\n", "MOVE\n", "LEFT\n", "MOVE\n", "REPORT"] }
		let(:commands_with_no_place) { ["MOVE\n", "MOVE\n", "LEFT\n", "MOVE\n", "REPORT"] }
		context 'commands which have a PLACE' do
			it 'returns correct output' do
				output = Robot.new.execute_commands(commands_with_place)
				expect(output).to eq('X, Y coordinate of robot are: 3, 3 and facing is NORTH')
			end
		end

		context 'commands which have no PLACE command' do
			it 'returns correct output' do
				output = Robot.new.execute_commands(commands_with_no_place)
				expect(output).to eq("Your commands do not have any command to place the robot on the table")
			end
		end
	end
end