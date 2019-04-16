require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/human_player'

player1 = Player.new('josie')
player2 = Player.new('josé')
me = HumanPlayer.new('clément')
binding.pry

def round(player1, player2)
  Player.list_players
  i = 1

  puts "F I G H T !"

  until (player1.is_dead? || player2.is_dead?)
    puts "      ========ROUND #{i}========"
    player1.attacks(player2) if player2.is_alive?
    player2.attacks(player1) unless (player1.is_dead? || player2.is_dead?)
    i += 1
    puts "\n"
  end
end

round(player1, player2)