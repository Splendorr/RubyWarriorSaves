class Player
  
  def taking_damage?(prev, curr)
    if prev.to_i > curr.to_i
      return true
    else
      return false
    end
  end
  
  def play_turn(warrior)
    @pc_name = "Vallamanar"
    hearts = warrior.health
    @hurts = taking_damage?(@health, hearts)
    puts "At the beginning, hurts is #{@hurts}"    
    puts "Behind #{@pc_name} is #{warrior.feel(:backward)}"
    puts "Ahead of #{@pc_name} is #{warrior.feel}"
    if warrior.feel.empty?
      if @hurts == false
        if hearts <= 17
          puts "Vallamanar is hurt and must, regrettably, rest."
          warrior.rest!
        elsif hearts >= 18
          puts "Vallamanar feels great, and proceeds!"
          warrior.walk!
        end
      elsif @hurts == true
        puts "Vallamanar is under siege, and must forge onward."
        warrior.walk!
      end
    elsif warrior.feel.captive?
      puts "Vallamanar has located a Captive! Be free, Captive!"
      warrior.rescue!
    else
      puts "Vallamanar cries out, 'Die, foul beast!'"
      warrior.attack!
    end
    #@hurts = taking_damage?(@health, hearts)
    #puts "At the end, hurts is #{@hurts}"
    @health = warrior.health
  end
  
end
