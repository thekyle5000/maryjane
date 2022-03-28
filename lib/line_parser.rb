class LineParser
  def self.parse(line)
    result = false
    chomp_line = line.chomp
    if /^([[a-zA-Z]+\s]+\s\d+),\s([[a-zA-Z]+\s]+\s\d+)/.match?(chomp_line)
      capture_teams = /^([[a-zA-Z]+\s]+)\s(\d+),\s([[a-zA-Z]+\s]+)\s(\d+)/.match(chomp_line)
      team_one_name = capture_teams[1]
      team_one_score = capture_teams[2].to_i
      team_two_name = capture_teams[3]
      team_two_score = capture_teams[4].to_i

      team_one_points = self.calc_my_points(team_one_score, team_two_score)
      team_two_points = self.calc_my_points(team_two_score, team_one_score)
      result = {
        team_one: { name: team_one_name, points: team_one_points },
        team_two: { name: team_two_name, points: team_two_points }
      }
    end
    result
  end

  def self.calc_my_points(my_score, other_score)
    if my_score > other_score
      3
    elsif my_score == other_score
      1
    else
      0
    end
  end
end