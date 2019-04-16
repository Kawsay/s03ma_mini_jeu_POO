require 'pry'
require_relative 'player'
require_relative 'human_player'

class Game
  attr_accessor :human_player, :enemies_in_sight, :enemies_left
  # attr_reader :namelist

  def initialize(game_name)
    @game_name = game_name
    @enemies_left = 10
    @enemies_in_sight = [
      Player.new("Gégé Darmanin"),
      Player.new("Chrichri Castaner"),
      Player.new("Brubru Le Maire"),
      Player.new("Marlène Schiappa")
    ]
    @names_list = ["Claire O'Petit", "François de Rugy", "Manue Wargon",
      "Nico Belloubet", "Jean-Yves Le Drian", "Mumu Pénicaud", "Gégé Darmanin",
      "Chrichri Castaner", "Brubru Le Maire", "Marlène Schiappa"]
    @human_player = HumanPlayer.new('Philippe Poutou')
  end

  def menu
    kill_player
    puts "What do you wanna do ?\n\n"
    puts "S - Search for a new weapon"
    puts "H - Search for heal pack\n\n"
    @enemies_in_sight.each_with_index do |enemy, index|
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
      @human_player.attacks(@enemies_in_sight[user_input.to_i])
    else
      puts "Error"
      menu
    end
  end

  def throw_dice
    rand(1..6)
  end

  def is_stil_ongoing?
    (@human_player.is_alive? || @enemies_in_sight.empty?) ? true : false
  end

  def ggwp
    puts "GGWP"
  end

  def show_players
    puts "#{@human_player.name.upcase} : #{@human_player.life_points}/#{@human_player.max_life_points} Weapon level: #{@human_player.weapon_level}"
    @enemies_in_sight.each do |enemy|
      puts "   -> #{enemy.name.upcase} (#{enemy.life_points}/#{enemy.max_life_points})"
    end
  end

  def new_enemies_in_sight
    @enemies_left >= 10 ? invoke_new_enemies : "So many bourgeois !"
  end

  def invoke_new_enemies
    case throw_dice
    when 1
      puts "All bourgeois are in sight !"
    when 2..4
      n_enemies_arrive(1)
      puts "One more is incoming..."
    when 5..6
      n_enemies_arrive(2)
      puts "Careful ! Two enemies are coming !"
    end
  end

  def n_enemies_arrive(n)
    n.times { an_enemy_arrives }
  end

  def an_enemy_arrives
    @enemies_in_sight << Player.new(random_name)
  end

  def random_name
    @names_list.sample
  end

  def enemies_attack
    @enemies_in_sight.each { |enemy| enemy.attacks(@human_player) if enemy.is_alive?}
  end

  def kill_player
    @enemies_in_sight.each { |enemy| (@enemies_in_sight.delete(enemy)) if enemy.is_dead?}
  end
end


##############
#    GAME    #
##############

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
puts "Name your hero :"
game_name = gets.chomp
system("clear")
puts "Philippe POUTOU <3"
sleep(3)
system("clear")

# Generate game
game = Game.new(game_name)
# binding.pry

# Loop & play !
while game.is_stil_ongoing?
  game.show_players
  game.menu
  game.menu_choice
  game.enemies_attack
  game.new_enemies_in_sight
end
game.ggwp
