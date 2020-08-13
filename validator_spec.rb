# frozen_string_literal: true

require './robot'

RSpec.describe Validator do 

	describe "check_first_command_is_place" do
		let(:commands_with_no_place) { ["MOVE\n", "MOVE\n", "LEFT\n", "MOVE\n", "REPORT"] }
		let(:commands_with_place) { ["PLACE 1,2,EAST\n", "MOVE\n", "MOVE\n", "LEFT\n", "MOVE\n", "REPORT"] }
		let(:commands_with_no_first_place) { ["MOVE\n", "MOVE\n", "PLACE 1,2,EAST\n", "MOVE\n", "MOVE\n", "LEFT\n", "MOVE\n", "REPORT"] }
		context 'commands do not have PLACE' do
			it 'returns nil value for commands' do
				commands = 	Robot.new.check_first_command_is_place(commands_with_no_place)
				expect(commands).to be_nil
			end
		end

		context 'commands have PLACE' do
			it 'returns value of the commands' do
				commands = 	Robot.new.check_first_command_is_place(commands_with_place)
				expect(commands).to eq(commands_with_place)
			end
		end

		context 'first command is not PLACE' do
			it 'ignores all commands that are before a valid PLACE command' do
				commands = 	Robot.new.check_first_command_is_place(commands_with_no_first_place)
				expect(commands).to eq(commands_with_place)
			end
		end
	end

	describe 'validate_place_command' do
		let(:commands_with_invalid_x_place) { ["PLACE 10,2,EAST\n", "PLACE 1,2,EAST\n", "MOVE\n", "REPORT"] }
		let(:commands_with_invalid_y_place) { ["PLACE 1,20,EAST\n","PLACE 1,2,EAST\n" ,"MOVE\n", "REPORT"] }
		let(:commands_with_invalid_x_and_y_place) { ["PLACE 10,26,EAST\n","PLACE 1,2,EAST\n", "MOVE\n", "REPORT"] }
		context 'invalid PLACE command' do
			context 'invalid X coordinate in PLACE command' do
				it 'removes invalid PLACE from commands' do
					commands = 	Robot.new.validate_place_command(commands_with_invalid_x_place)
					expect(commands).to eq(["PLACE 1,2,EAST\n", "MOVE\n", "REPORT"])
				end
			end

			context 'invalid Y coordinate in PLACE command' do
				it 'removes invalid PLACE from commands' do
					commands = 	Robot.new.validate_place_command(commands_with_invalid_y_place)
					expect(commands).to eq(["PLACE 1,2,EAST\n", "MOVE\n", "REPORT"])
				end
			end

			context 'invalid X and Y coordinates in PLACE command' do
				it 'removes invalid PLACE from commands' do
					commands = 	Robot.new.validate_place_command(commands_with_invalid_x_and_y_place)
					expect(commands).to eq(["PLACE 1,2,EAST\n", "MOVE\n", "REPORT"])
				end
			end
		end
	end

end