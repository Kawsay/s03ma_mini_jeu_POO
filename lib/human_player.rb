require 'colorize'

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



  ##################
  ##    WEAPON    ##
  ##################
   
  def search_weapon
    system("clear")
    weapon_found_level = rand(1..6)
    puts (@weapon_level < weapon_found_level) ?
      "You find a level ".colorize(:black).on_white + "#{weapon_found_level}".colorize(:red).on_white + " weapon. Grab it ?".colorize(:black).on_white + "   [Y/n]\n".colorize(:green) :
      "You find a level #{weapon_found_level} weapon. Keep fighting !" .colorize(:black).on_white
    grab_weapon(weapon_found_level) if ((@weapon_level < weapon_found_level) && (gets.chomp == ("" || "y" || "Y" || "yes" || "Yes")))
  end

  def grab_weapon(weapon_found_level)
    @weapon_level = weapon_found_level
    puts "Weapon grabbed. You now have a level ".colorize(:black).on_white + "#{@weapon_level}".colorize(:red).on_white + " weapon !".colorize(:black).on_white
    sleep(3)
  end

  ##################
  ##     HEAL     ##
  ##################

  def search_health_pack
    healpack = rand(1..6)
    case healpack
    when 1
      system("clear")
      puts "Nothing found..."
      sleep(3)
    when 2..5
      system("clear")
      if (@life_points + 50) > 100
        puts "Nice, you healed #{100 - @life_points}HP.".colorize(:green) + " Current HP: #{@life_points}/#{@max_life_points}"
        @life_points = 100
      else
        puts "Nice, you healed 50HP.".colorize(:green) +  "Current HP: #{@life_points}/#{@max_life_points}"
        @life_points += 50
      end
      sleep(3)
    when 6
      system("clear")
      if (@life_points + 50) > 100
        puts "Wow, you healed #{100 - @life_points}HP.".colorize(:green) + " Current HP: #{@life_points}/#{@max_life_points}"
        @life_points = 100
      else
        puts "Wow, you healed 80HP.".colorize(:green) + " Current HP: #{@life_points}/#{@max_life_points}"
        @life_points += 80
      end
      sleep(3)
    end
  end



end