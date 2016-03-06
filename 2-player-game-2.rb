require 'colorize'
require 'pry'

class Question

  attr_reader :num1, :num2, :answer
  
  def initialize
    @num1 = rand(1..20)
    @num2 = rand(1..20)
    @operator = rand(1..4)
    @answer 

    case @operator
    when 1
      @answer = @num1 + @num2
      @op = '+'
    when 2
      @answer = @num1 - @num2
      @op = '-'
    when 3
      @answer = @num1 * @num2
      @op = '*'
    when 4
      @answer = @num1 / @num2
      @op = '/'
    end
  end

  def ask_question(player)
    puts "\nYour turn, #{player.name}. What is #{@num1} #{@op} #{@num2}?"
    answer = gets.chomp.to_i
    if answer == @answer
      player.add_point
      puts "\nCORRECT! Well done, #{player.name}! You have #{player.points} points!".colorize(:green)
    else
      player.lose_life
      puts "\nNope, that's wrong. NO DICE FOR YOU, #{player.name.upcase}.".colorize(:red)
    end 
      puts "You have #{player.lives} lives remaining.\n".colorize(:light_blue)
  end
end 

class Player

  attr_reader :name, :lives, :points

  def initialize(name)
    @name = name
    @lives = 3
    @points = 0
  end 

  def reset
    @lives = 3
  end

  def is_alive?
    @lives > 0
  end

  def lose_life
    @lives -= 1
  end

  def add_point
    @points += 1
  end
end

def select_players
puts "\nWelcome to the coolest Math game in Canada!".colorize(:color => :white, :background => :red)

puts "\nPlayer 1, what's your name?"
p1 = $stdin.gets.chomp
@player1 = Player.new(p1)
p "\nCool! Nice to have ya on board, #{@player1.name}!"

puts "\nYour turn, player 2. What shall I call you?"
p2 = $stdin.gets.chomp
@player2 = Player.new(p2)
puts "\nAwesome! Thanks for coming to play #{@player2.name}."
puts "Now.....\n"
puts "LET'S\nGET\nSTARTED!\n"
end

def play_the_game

  while @players[0].is_alive? && @players[1].is_alive? do 
    question = Question.new
    question.ask_question(@players[@current_player])  
    @current_player = (@current_player + 1) % @players.length
    puts "The current score is..."
    puts "#{@players[0].name} has #{@players[0].lives} lives left and #{@players[0].points} points."
    puts "#{@players[1].name} has #{@players[1].lives} lives left and #{@players[1].points} points.\n"
    if @players[0].lives <= 0 
      puts "WHICH MEANS, YOU LOSE #{@players[0].name.upcase}!".colorize(:color => :black, :background => :red).underline
      puts "#{@players[1].name} has #{@players[1].lives} lives left AND #{@players[1].points} points!\n".colorize(:color => :black, :background => :green)
    elsif @players[1].lives <= 0
      puts "WHICH MEANS, YOU LOSE #{@players[1].name.upcase}!".colorize(:color => :black, :background => :red).underline
      puts "#{@players[0].name} has #{@players[0].lives} lives left AND #{@players[0].points} points!".colorize(:color => :black, :background => :green)
      puts "\n"  
    end
  end
end

def ask_to_play_again

  puts "That was fun. Do you want to play again? (Yes/No?)" 
  play = $stdin.gets.chomp
  
  if play == "Yes"
    @players[0].reset
    @players[1].reset
    return true
  elsif play == "No"
    exit(1)
  else
    puts "Please enter 'Yes' or 'No'."
    ask_to_play_again
  end
end

select_players

@players = [@player1, @player2]
@current_player = 0

playing = true

while playing 
  play_the_game
  ask_to_play_again
end






