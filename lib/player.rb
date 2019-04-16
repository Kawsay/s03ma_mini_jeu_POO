require 'colorize'

class Player
  attr_accessor :name, :life_points, :max_life_points, :all_players
  @@all_players = []

  def initialize(name)
    @name = name.capitalize
    @max_life_points = 10
    @life_points = 10
    @@all_players << self
  end

  def self.list_players
    @@all_players.each { |player| player.show_state }
  end

  def show_state
    puts self.is_a?(HumanPlayer) ? "#{@name}: #{@life_points}HP. Weapon level: #{weapon_level}" : "#{@name}: #{@life_points}HP" 
  end

  def gets_damage(dmg)
    (@life_points - dmg) < 0 ? @life_points = 0 : @life_points -= dmg
    puts @life_points <= 0 ? "#{@name} is dead.".colorize(:red) : "#{@name} take #{dmg} damage. HP left : #{@life_points}/#{@max_life_points}"
  end

  def is_dead?
    @life_points <= 0
  end

  def is_alive?
    @life_points > 0
  end

  def attacks(player_to_attack)
    damage = compute_damage
    puts player_to_attack.is_dead? ? "Stay cool with corpses man" : "#{self.name} attacks #{player_to_attack.name}. " + "#{damage} damage inflicted".colorize(:red)
    player_to_attack.gets_damage(damage)
    sleep(3)
  end

  def compute_damage
    rand(1..6)
  end
end