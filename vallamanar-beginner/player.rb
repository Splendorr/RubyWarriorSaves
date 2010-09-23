class Player
  def taking_damage?(prev, curr)
    if prev.to_i > curr.to_i
      return true
    else
      return false
    end
  end
  
  def play_turn(warrior)
    hearts = warrior.health    
    # warrior.feel
    if warrior.feel.empty?
      if @hurts == false
        if hearts <= 17
          warrior.rest!
        else
          warrior.walk!
        end
      else
        warrior.walk!
      end
    elsif warrior.feel.captive?
      warrior.rescue!
    else
      warrior.attack!
    end
    @hurts = taking_damage?(@health, hearts)
    puts "Hurts is #{@hurts}"
    @health = warrior.health
  end
  
end
