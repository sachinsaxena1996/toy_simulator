# frozen_string_literal: true

require_relative '../robot'

RSpec.describe Robot do
  describe 'execute_commands' do
    let(:commands_with_place) do
      ["PLACE 1,2,EAST\n", "MOVE\n", "MOVE\n",
       "LEFT\n", "MOVE\n", 'REPORT']
    end
    let(:commands_with_no_place) { %W[MOVE\n MOVE\n LEFT\n MOVE\n REPORT] }
    context 'commands which have a PLACE' do
      it 'returns correct output' do
        op = Robot.new.execute_commands(commands_with_place)
        expect(op).to eq('X, Y coordinate of robot are: 3, 3, facing is NORTH')
      end
    end

    context 'commands which have no PLACE command' do
      it 'returns correct output' do
        output = Robot.new.execute_commands(commands_with_no_place)
        expect(output).to eq('Your commands do not have any PLACE command')
      end
    end
  end
end
