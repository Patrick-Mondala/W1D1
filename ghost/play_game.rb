require_relative 'game'
require_relative 'player'

player1 = Player.new("Raymond")
player2 = Player.new("Patrick")
# player3 = Player.new("Austin")
# player4 = Player.new("Feeby")

game = Game.new(player1,player2)
game.run

# move towards having only one word that can be completed with given fragment
# list of char options
# compare list of word possibilities per char use lowest word possibilites count
