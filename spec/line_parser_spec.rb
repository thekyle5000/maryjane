require_relative '../lib/line_parser'

describe LineParser do
  describe '.parse' do 
    context 'given an invalid line' do
      it 'returns false' do
        expect(LineParser.parse('')).to eq(false)
        expect(LineParser.parse('Team One 3 Team Two 4')).to eq(false)
        expect(LineParser.parse('Team One $ 3 Team Two 4')).to eq(false)
        expect(LineParser.parse('Team One 3, ^ Team Two 4')).to eq(false)
        expect(LineParser.parse('Team One3, ^ Team Two 4')).to eq(false)
      end
    end
  end
  describe '.parse' do 
    context 'given a valid line' do
      it 'returns game result object with pts according to rules' do
        expect(LineParser.parse('Teamone 2, Team Two 1')).to eq({team_one: {name: 'Teamone', points: 3}, team_two: {name: 'Team Two', points: 0}})
      end
    end
  end
end