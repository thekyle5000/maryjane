require_relative '../lib/matchday'

describe Matchday do
  let(:matchday) { Matchday.new }
  describe '#update_matchday' do 
    context 'given name already included in array' do
      before { matchday.instance_variable_set(:@matchday_names, ['A', 'B'])}
      it 'returns true' do
        expect(matchday.update_matchday('A', 'B')).to eq(true)
      end
    end
    context 'given name not included in array' do
      it 'returns true' do
        expect(matchday.update_matchday('A', 'B')).to eq(false)
      end
    end
  end
end