require 'pry'
require_relative 'player'
require_relative 'human_player'
require 'colorize'

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

  def hero_info
    puts "#{@human_player.name.upcase} :            #{@human_player.life_points}/#{@human_player.max_life_points}".colorize(:red).on_black
    puts "                      " + "Weapon lvl: #{@human_player.weapon_level}\n\n\n".colorize(:red).on_black
  end

  def menu
    kill_player
    hero_info
    puts "   " + "What do you wanna do ?\n\n".colorize(:black).on_white
    puts "S -" + " Search for a new weapon"
    puts "H -" + " Search for heal pack\n".colorize(:green)
    @enemies_in_sight.each_with_index do |enemy, index|
      puts "#{index} -" + " Attack #{enemy.name.upcase} (#{enemy.life_points}/#{enemy.max_life_points})".colorize(:red)
    end
    puts "\n\n"
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
    system("clear")
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
    puts "          " + "ENEMIS IN SIGHT :".colorize(:red).on_black
    @enemies_in_sight.each do |enemy|
      puts "   -> " + "#{enemy.name.upcase}".colorize(:red) + " (#{enemy.life_points}/#{enemy.max_life_points})"
    end
    sleep(5)
    system("clear")
  end

  def new_enemies_in_sight
    @enemies_left >= 10 ? invoke_new_enemies : "So many bourgeois !".colorize(:yellow).on_black
  end

  def invoke_new_enemies
    case throw_dice
    when 1
      puts "          " + "All bourgeois are in sight !".colorize(:cyan).on_black
    when 2..4
      n_enemies_arrive(1)
      puts "          " + "\nOne more is incoming...\n".colorize(:cyan).on_black
    when 5..6
      n_enemies_arrive(2)
      puts "          " + "Careful ! Two enemies are coming !".colorize(:cyan).on_black
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
system("clear")
puts <<EOF
    +--------------------------+
    |      Golden ballz        |
    |           VS             |
    |      Steel daggerz       |
    +--------------------------+
\n\n
EOF

# User name the game and select Philippe Poutou <3
print "Name your hero :".colorize(:black).on_white + "  > "
game_name = gets.chomp
system("clear")
puts "/!\\Miswriting detected /!\\".colorize(:yellow)
sleep(0.5)
puts "> Correcting errors..."
sleep(0.2)
puts "."
sleep(0.15)
puts "."
sleep(0.30)
puts "."
sleep(0.05)
puts "."
sleep(0.40)
puts "."
sleep(0.25)
puts "."
sleep(0.25)
puts "."
sleep(0.75)
puts "."
sleep(1)
print "Hero name : > "
sleep(1)
system("clear")
puts "\n\n\n                " + "Philippe POUTOU".colorize(:magenta).on_black
sleep(3)
system("clear")
puts "fullscreen maggle"
sleep(0.75)
system("clear")

# Generate game
game = Game.new(game_name)
# binding.pry

# Loop & play !
while game.is_stil_ongoing?
  game.show_players
  game.menu
  game.menu_choice
  # sleep(3)
  # system("clear")
  puts "         " + "ENEMIS ARE HITING BACK !\n".colorize(:red).on_black
  game.enemies_attack
  game.new_enemies_in_sight
end
game.ggwp
