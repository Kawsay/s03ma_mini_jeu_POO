require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/human_player'

potential_enemies = [
  Player.new("Claire O'Petit"),
  Player.new("François de Rugy"),
  Player.new("Manue Wargon"),
  Player.new("Nico Belloubet"),
  Player.new("Jean-Yves Le Drian"),
  Player.new("Mumu Pénicaud"),
  Player.new("Gégé Darmanin"),
  Player.new("Chrichri Castaner"),
  Player.new("Brubru Le Maire"),
  Player.new("Marlène Schiappa")
]
enemies = []

puts <<EOF
\n
    +--------------------------+
    |      Golden ballz        |
    |           VS             |
    |      Steel daggerz       |
    +--------------------------+
\n\n
EOF

# User choose the name 'Philippe Poutou'
puts "Type your hero name :"
i_dont_care_about_your_choice = gets.chomp
hero = HumanPlayer.new("Philippe Poutou")
puts "Thanks. 'Philippe Poutou' is a nice sounding name !\n\n"

# Generate enemies
puts "2 enemies appears..."
2.times { |t| enemies << potential_enemies.sample }
enemies.each { |enemy| puts "  > #{enemy.name} - #{enemy.life_points}/#{enemy.max_life_points}HP " }
puts "\n\n"

# Menu
def menu(enemies, hero)
  puts "What do you wanna do ?\n\n"
  puts "S - Search for a new weapon"
  puts "H - Search for heal pack\n\n"
  puts "0 - Attack #{enemies.first.name} (#{enemies.first.life_points}/#{enemies.first.max_life_points})"
  puts "1 - Attack #{enemies.last.name} (#{enemies.last.life_points}/#{enemies.last.max_life_points})"
  user_input = gets.chomp
  case user_input
  when "S" || "s"
    hero.search_weapon
  when ("H" || "h")
    hero.search_health_pack
  when "0"
    hero.attacks(enemies.first)
  when "1"
    hero.attacks(enemies.last)
  end
end


# F I G H T !
until (hero.is_dead? || (enemies.first.is_dead? && enemies.last.is_dead?))
  round = 1
  puts "\n\n\n"
  puts "      ========ROUND #{round}========\n"
  puts hero.show_state
  menu(enemies, hero)
  enemies.first.attacks(hero)
  enemies.last.attacks(hero)
end
