# Thanks to

  class String
  def black;          "\e[30m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def gray;           "\e[37m#{self}\e[0m" end

  def bg_black;       "\e[40m#{self}\e[0m" end
  def bg_red;         "\e[41m#{self}\e[0m" end
  def bg_green;       "\e[42m#{self}\e[0m" end
  def bg_brown;       "\e[43m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end
  def bg_magenta;     "\e[45m#{self}\e[0m" end
  def bg_cyan;        "\e[46m#{self}\e[0m" end
  def bg_gray;        "\e[47m#{self}\e[0m" end

  def bold;           "\e[1m#{self}\e[22m" end
  def italic;         "\e[3m#{self}\e[23m" end
  def underline;      "\e[4m#{self}\e[24m" end
  def blink;          "\e[5m#{self}\e[25m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
  end

# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.


class Gameplay

  def self.introduction
    puts "################".red
    puts "Welcome to #{@@game.class}".blue
    puts "################".green
  end

  def self.enter_player_names
    puts "How many players are there?".red
    num_of_players = gets.chomp
    puts "Please enter the name of each player:".green
    players = []
    (1..num_of_players.to_i).each do
      player = gets.chomp
      player = Player.new(player.to_sym)
      players << player
    end
    players
  end

  def self.turn_number(turn)
    puts "#################".cyan
    puts "#### ROUND #{turn} ####".cyan
    puts "#################".cyan
  end

  def self.last_round
    puts "#################".magenta
    puts "### LASTROUND ###".magenta
    puts "#################".magenta
  end
end


class DiceSet
  attr_reader :score, :items

  def initialize(dice_qty)
    @dice_qty = dice_qty
  end

  def roll
    @score = 0

    # Roll, separate by roll value + count
    @items = Hash.new(0)
    @dice_qty.times do
      roll = rand(1..6)
      @items[roll] += 1
    end

    # Calculate score
    @items.each do |num, times|
      if times >= 3
        @score += 1000 if num == 1
        @score += (num * 100) if num != 1
        times -= 3
      end

      if num == 1
        @score += 100 * times
      end

      if num == 5
        @score += 50 * times
      end
    end
  end

end


class Player
  attr_reader :name, :score, :finished
  def initialize(name)
    @name = name
    @score = 0
    @finished = false
  end

  def turn
    turnscore = 0
    dice_qty = Greed::NO_OF_DICE
    beat300 = Greed::SCORE_TO_START

    dice = DiceSet.new(dice_qty)
    dice.roll
    turnscore += dice.score

    if @score >= beat300
      @score += turnscore
    else
      if turnscore >= beat300
        @score += turnscore
      end
    end

    if @score >= Greed::SCORE_TO_END
      @finished = true
    end

    turnscore
  end
end



class Greed
  NO_OF_DICE = 5
  SCORE_TO_START = 300
  SCORE_TO_END = 3000

  def initialize
    @players = []
    @turn = 1
    @last_round = false
  end

  def start
    Gameplay.introduction
    @players = Gameplay.enter_player_names

    until @last_round
      Gameplay.turn_number(@turn)

      @players.each do |player|
        player.turn
        puts "#{player.name} scored a total of #{player.score}".gray
        if player.score >= SCORE_TO_END
          @last_round = true
          break
        end
      end
      @turn += 1
    end

    if @last_round
      Gameplay.last_round
      puts "CAN THEY CATCH UP...?"
      @players.each do |player|
        unless player.finished
          puts "#{player.name} scored a total of #{player.score}".gray
        end
      end
    end
  end
end

@@game = Greed.new
@@game.start
