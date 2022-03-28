class Matchday
  def initialize
    @matchday_names = []
  end

  def update_matchday(team_one_name, team_two_name)
    if @matchday_names.include?(team_one_name) || @matchday_names.include?(team_two_name)
      true
    else
      @matchday_names.append(team_one_name, team_two_name)
      false
    end
  end
end