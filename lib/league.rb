require_relative './line_parser'
require_relative './matchday'

class League
  def initialize(abs_file_path)
    @file_path = abs_file_path
    @teams_points = Hash.new(0)
    @matchday_count = 1
  end

  def run
    matchday = Matchday.new
    begin
      stream = STDIN
      if @file_path
        stream = File.open(@file_path)
      end
      stream.each_line do |line|
        line = LineParser.parse(line)
        if line
          team_one_name = line[:team_one][:name]
          team_two_name = line[:team_two][:name]
          if matchday.update_matchday(team_one_name, team_two_name)
            self.print_matchday_results
            @matchday_count += 1
            matchday = Matchday.new
            matchday.update_matchday(team_one_name, team_two_name)
          else
            matchday.update_matchday(team_one_name, team_two_name)
          end
          @teams_points[team_one_name.to_sym] += line[:team_one][:points]
          @teams_points[team_two_name.to_sym] += line[:team_two][:points]
        end
      end
      self.print_matchday_results
    rescue Interrupt => e
      self.print_matchday_results
    end
  end

  def print_matchday_results
    teams_points_desc = @teams_points.sort_by { |x, y| [ -Integer(y), x ] }
    puts "Matchday #{@matchday_count}"
    if teams_points_desc.size >= 3
      puts "#{teams_points_desc[0][0]}, #{teams_points_desc[0][1]} #{teams_points_desc[0][1] == 1 ? "pt" : "pts"}"
      puts "#{teams_points_desc[1][0]}, #{teams_points_desc[1][1]} #{teams_points_desc[1][1] == 1 ? "pt" : "pts"}"
      puts "#{teams_points_desc[2][0]}, #{teams_points_desc[2][1]} #{teams_points_desc[2][1] == 1 ? "pt" : "pts"}"
      puts
    end
  end
end