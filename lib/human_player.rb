class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    super(name)
    @life_points = 100
    @max_life_points = 100
    @weapon_level = 1
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    weapon_found_level = rand(1..6)
    puts (@weapon_level < weapon_found_level) ?
      "You find a level #{weapon_found_level} weapon. Grab it ? [Y/n]" :
      "You find a level #{weapon_found_level} weapon. Keep fighting !" 
    grab_weapon(weapon_found_level) if ((@weapon_level < weapon_found_level) && (gets.chomp == ("" || "y" || "Y" || "yes" || "Yes")))
  end

  def grab_weapon(weapon_found_level)
    @weapon_level = weapon_found_level
    puts "Weapon grabbed. You now have a level #{@weapon_level} weapon !"
  end

  ##################
  ##     HEAL     ##
  ##################

  def search_health_pack
    healpack = rand(1..6)
    case healpack
    when 1
      puts "Nothing found"
    when 2..5
      if (@life_points + 50) > 100
        puts "Nice, you healed #{100 - @life_points}HP. Current HP: #{@life_points}/#{@max_life_points}"
        @life_points = 100
      else
        puts "Nice, you healed 50HP. Current HP: #{@life_points}/#{@max_life_points}"
        @life_points += 50
      end
    when 6
      if (@life_points + 50) > 100
        puts "Wow, you healed #{100 - @life_points}HP. Current HP: #{@life_points}/#{@max_life_points}"
        @life_points = 100
      else
        puts "Wow, you healed 80HP. Current HP: #{@life_points}/#{@max_life_points}"
        @life_points += 80
      end
    end
  end



end