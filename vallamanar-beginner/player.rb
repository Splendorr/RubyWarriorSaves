class Player
  
  def taking_damage?(prev, curr)
    if prev.to_i > curr.to_i
      return true
    else
      return false
    end
  end
  
  def standard_sequence_backup
    if warrior.feel.empty?
      if @hurts == false
        if @hearts <= 17
          puts "Vallamanar is hurt and must, regrettably, rest."
          warrior.rest!
        elsif @hearts >= 18
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
  end
  
  def standard_sequence(d)
    if @w.feel(d).empty?
      if @hurts == false
        if @hearts <= 17
          puts "#{@pc_name} is hurt and apparently safe, and so must, regrettably, rest."
          @w.rest!
        elsif @hearts >= 18
          if @targets_ahead.to_s =~ /Wizard/ && @targets_ahead.to_s !~ /Captive/
            puts "#{@pc_name} sees a Wizard and has a clear shot."
            @w.shoot!
          else
            puts "#{@pc_name} feels great, and proceeds!"
            @w.walk!(d)
          end
        end
      elsif @hurts == true
        if @hearts <= 10
          puts "#{@pc_name} is taking fire and near death, and must retreat!"
          @w.walk!(:backward)
        else
          puts "#{@pc_name} is under siege, and must forge onward."
          @w.walk!(d)
        end
      end
    elsif @w.feel(d).captive?
      puts "#{@pc_name} has located a Captive! Be free, Captive!"
      @w.rescue!(d)
    elsif @w.feel(d).wall?
      @w.pivot!
    else
      puts "#{@pc_name} cries out, 'Die, foul beast!'"
      @w.attack!(d)
    end
  end
  
  def play_turn(warrior)
    @all_backed_up ||= false
    @all_backed_up = true
    @w = warrior
    @pc_name = "Vallamanar"
    @hearts = warrior.health
    @hurts = taking_damage?(@health, @hearts)
    @targets_ahead = warrior.look(:forward).to_a
    @targets_behind = warrior.look(:backward).to_a
    puts "At the beginning, hurts is #{@hurts}"    
    puts "Behind #{@pc_name} is #{@targets_behind.join(", ")}."
    puts "Ahead of #{@pc_name} is #{@targets_ahead.join(", ")}."

    if @all_backed_up == false
      standard_sequence(:backward)
      if warrior.feel(:backward).to_s == "wall"
        @all_backed_up = true
      end
    elsif @all_backed_up == true
      standard_sequence(:forward)
    end
    #@hurts = taking_damage?(@health, @hearts)
    #puts "At the end, hurts is #{@hurts}"
    @health = warrior.health
  end
  
end
