# Matches CLI App Overview
* input: stream of game results whereby each line contains the result of two teams (names and scores)
* output: top three teams ordered by accumulated points (loss = 0, draw = 1, win = 3)
* account for streaming interruption- results in matchday ending
* if two or more teams in top three have same amount of accumulated points- order these teams  
 alphabetically while still only printing top 3
* invalid lines (e.g. no delimiter or there are non word characters)

## Running The App
* input via stdin or absolute file path (-f)
* bin/footy -f abs file path
* bin/footy

## Run Tests
* bundle install
* run bundle exec rspec to run tests

## Design Considerations
### bin/footy
* executable file where I create an instance of the League class
* League class is initialized with one argument- here I'm determining whether file path was given or not

### LineParser
* this static, helper class validates line content
* wrote regex to spot invalid lines
* returns a hash with team names and calculated points (points awarded for that game  
according to rules provided in prompt)

### League
* we are going to keep track of all the teams and corresponding accumulated points in @teams_points
* @matchday_count keeps track of what matchday we are on
* Steping through the run method
  - create an instance of Matchday (Matchday objects represent a single matchday)
  - dynamically set stream varaible to capture file or stdin input
  - send line to LineParser.parse method to validate and get game result hash back
  - call update_matchday(team_one, team_two) method on matchday object to see if either of  
  these teams are included in @matchday_names- attribute on matchday object, which is an array of team names.
  - update_matchday will return true if either team is included in @matchday_names  
  (i.e. these teams already played in this matchday object and therefore we are beginning a new matchday).
  the update_matchday method will return false if these teams are not found in @matchday_names
  - if matchday.update_matchday returns true (matchday finished)- call print_matchday_results, which is  
  an instance method on the league class. We will also create a new instance of Matchday and call update_matchday again
  - print_matchday_results sorts the teams in @teams_points and outputs the top 3
  - if matchday.update_matchday returns false- that means these teams will be added to @matchday_names on the  
  matchday object and the matchday has not finished
  - after calling the update_matchday method we will update @teams_points
  - after looping through lines we call print_matchday_results to handle the last line of input

### Matchday
* matchday objects represent a single matchday
* we keep track of team names an array that we check to see if one matchday has  
finished and another one is about to begin

### Rspec Tests
* league tests will check to see if we are printing the top three teams  
accodign to points
* league tests will also test the case where we have two teams with same points in top  
 three teams and need to print those in alphabetical order
* matchday tests are making sure we get false if teams have not played that matchday  
and true if either of those teams did indeed play that matchday
* lineparser tests are checking that our regex will validate the lines appropriately

### my assumptions...
* team names do not include numbers
* if there are not at least three teams in top three teams- do not print teams

## Articles & Resources
### articles and resources I found to be helpful along the way
* https://rubular.com/
* https://github.com/airbnb/ruby#avoid-class-variables
* http://www.compciv.org/topics/bash/pipes-and-redirection/
* https://rspec.rubystyle.guide/
* https://github.com/rubocop/rspec-style-guide
