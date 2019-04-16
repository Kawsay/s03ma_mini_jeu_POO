require 'pry'
require_relative 'player'
require_relative 'human_player'

class Game
  attr_accessor :human_player, :enemies

  def initialize(game_name)
    @game_name = game_name
    @enemies = [
      Player.new("Gégé Darmanin"),
      Player.new("Chrichri Castaner"),
      Player.new("Brubru Le Maire"),
      Player.new("Marlène Schiappa")
    ]
    @human_player = HumanPlayer.new('Philippe Poutou')
  end

  def kill_player
    @enemies.each { |enemy| (@enemies.delete(enemy)) if enemy.is_dead?}
  end

  def is_stil_ongoing?
    (@human_player.is_alive? || @enemies.empty?) ? true : false
  end

  def show_players
    puts "#{@human_player.name.upcase} : #{@human_player.life_points}/#{@human_player.max_life_points} Weapon level: #{@human_player.weapon_level}"
    @enemies.each do |enemy|
      puts "   -> #{enemy.name.upcase} (#{enemy.life_points}/#{enemy.max_life_points})"
    end
  end

  def menu
    kill_player
    puts "What do you wanna do ?\n\n"
    puts "S - Search for a new weapon"
    puts "H - Search for heal pack\n\n"
    @enemies.each_with_index do |enemy, index|
      puts "#{index} - Attack #{enemy.name} (#{enemy.life_points}/#{enemy.max_life_points})"
    end
  end

  def menu_choice
    user_input = gets.chomp.downcase
    case
    when user_input == "s"
      @human_player.search_weapon
    when user_input =="h"
      @human_player.search_health_pack
    when user_input.match?(/[0-9]/)
      @human_player.attacks(@enemies[user_input.to_i])
    else
      puts "Error"
      menu
    end
  end

  def enemies_attack
    @enemies.each { |enemy| enemy.attacks(@human_player) if enemy.is_alive?}
  end

  def ggwp
    puts "GGWP"
  end
end

# Willkommen !
puts <<EOF
\n
    +--------------------------+
    |      Golden ballz        |
    |           VS             |
    |      Steel daggerz       |
    +--------------------------+
\n\n
EOF


# User name the game and select Philippe Poutou <3
puts "Name your incoming adventure :"
game_name = gets.chomp
puts "\n\n"

# Generate game
game = Game.new(game_name)

# Loop & play !
while game.is_stil_ongoing?
  game.show_players
  game.menu
  game.menu_choice
  game.enemies_attack
  game.ggwp if game.enemies.empty?
end

