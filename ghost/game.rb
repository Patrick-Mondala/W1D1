require 'set'

class Game
  attr_reader :previous_player, :losses

  def initialize(*players)
    @players = players
    @losses = Hash.new(0)
    @fragment = ""
    @dictionary = Set.new
    File.foreach("dictionary.txt") do |line|
        @dictionary << line.chomp
    end
    
    @current_player = players[0]
    @previous_player = players[-1]

    @ai_players = players.select {|player| player.is_a? AiPlayer}
  end

  def play_round
    while !complete_word?
      system "clear"
      puts "Current fragment: #{@fragment}"
      puts "Turn: #{@current_player.name}, #{@current_player.letters}"
      take_turn(@current_player)
      puts "\n"
      next_player!
    end
    #reset_options for all ai players
    @ai_players.each {|player| player.reset_options}
    @losses[@previous_player] += 1
    @previous_player.give_letter
    puts @fragment
    @fragment = ""
  end

  def run
    while @players.length > 1
      while @losses.values.none? {|losses| losses >= 5}
        play_round
      end

      puts "#{@previous_player.name} has been eliminated"
      @players.delete(@previous_player)
      @losses.delete(@previous_player)      
    end

    puts "#{@players[0].name} has won!"
  end

  def complete_word?
    @dictionary.include?(@fragment)
  end

  def next_player!
    i = @players.index(@current_player)
    @previous_player = @current_player
    @current_player = @players[(i + 1) % @players.length]
  end

  def take_turn(player)
    response = player.guess(@fragment)
    while !valid_play?(@fragment + response)
      puts "Invalid character."
      response = player.guess(@fragment)
    end

    @fragment += response
  end

  def valid_play?(string)
    return false if !(string.split("").all? { |char| char =~ /[a-zA-Z]/}) && string.length != 1

    @dictionary.any? {|word| word[0..string.length - 1].include? string}
  end

end