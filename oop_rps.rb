class Hand
  include Comparable

  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def <=>(another_hand)
    if @value == another_hand.value
      0
    elsif (@value == "r" && another_hand.value == "s") || (@value == "p" && another_hand.value == "r") ||(@value == "s" && another_hand.value == "p")
      1
    else
      -1
    end  
  end

  def display_winning_message
    case value
    when "r" 
      puts "Rock smashes Scissors!"
    when "p" 
      puts "Paper covers Rock!"
    when "s" 
      puts "Scissors cuts Paper!"
    end
  end

  def to_s
    case value
    when "r" 
      "Rock"
    when "p" 
      "Paper"
    when "s" 
      "Scissors"
    end
  end
end

class Player
  attr_accessor :hand
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Human < Player
  attr_accessor :name

  def set_name
    system "clear"
    puts "Get ready to play Rock, Paper, Scissors!"  
    puts
    puts "Please enter your name."
    puts 
    self.name = gets.chomp
  end

  def pick_hand
    begin
      system "clear"
      puts "Please choose: ( r, p, s )"
      choice = gets.chomp.downcase
    end until Game::CHOICES.keys.include?(choice)

    self.hand = Hand.new(choice)
  end
end

class Computer < Player
  def pick_hand
    self.hand = Hand.new(Game::CHOICES.keys.sample)
  end
end

class Game
  CHOICES = { "r" => "Rock", "p" => "Paper", "s" => "Scissors" }

  attr_reader :player, :computer
  attr_accessor :wins, :losses, :draws

  def initialize
    @player = Human.new(" ")
    @computer = Computer.new("Computer")

    @wins = 0
    @losses = 0
    @draws = 0
  end 

  def show_choices
    puts
    puts "#{player.name} chooses #{player.hand}"
    puts
    puts "#{computer.name} chooses #{computer.hand}"
    puts
  end

  def compare_hands
    if player.hand == computer.hand
      puts
      puts "It's a draw."
      @draws += 1
    elsif player.hand > computer.hand
      player.hand.display_winning_message
      puts
      puts "#{player.name} won!"
      @wins += 1
    else
      computer.hand.display_winning_message
      puts
      puts "#{computer.name} won!"
      @losses += 1
    end
  end

  def display_score
    puts
    puts "Score // Player: #{wins} / Computer: #{losses} / Draws: #{draws}"
    puts
  end

  def play
      player.set_name

    begin
      player.pick_hand
      computer.pick_hand
      show_choices
      compare_hands
      display_score
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
    end until answer != "y"

    system "clear"
    puts "Thanks for playing!"
    display_score
  end
end

Game.new.play
