require_relative '../lib/league'
describe League do
  let(:league) { League.new(nil) }

  describe '.print_matchday_results' do 
    context 'given hash of teams and points' do
      before { league.instance_variable_set(:@teams_points, { A: 2, B: 3, C: 1 }) }
      it 'outputs top three teams by points' do
        expect { league.print_matchday_results }.to output(
          "Matchday 1\nB, 3 pts\nA, 2 pts\nC, 1 pt\n\n"
        ).to_stdout
      end
    end
    context 'given hash of teams and points where 2+ teams have same points' do
      before { league.instance_variable_set(:@teams_points, { A: 3, B: 3, C: 7 }) }
      it 'outputs top teams by points and tied teams in alphabetical order' do
        expect { league.print_matchday_results }.to output(
          "Matchday 1\nC, 7 pts\nA, 3 pts\nB, 3 pts\n\n"
        ).to_stdout
      end
    end
  end
end