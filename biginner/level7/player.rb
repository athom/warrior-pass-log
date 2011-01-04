# level 7
#  ------
# |>a S @|
#  ------

class Player
  def initialize()
		@hp = 0
		@is_rescue = false
		@need_rest = false
		@attack_count = 0
  end

  def play_turn(warrior)
		if warrior.feel.empty? && @need_rest
			warrior.walk!
		elsif warrior.feel(:backward).empty? && !@need_rest
			warrior.walk!(:backward)
		end
	
		if !warrior.feel(:backward).empty? && !warrior.feel(:backward).captive? && !@need_rest 
			warrior.attack!(:backward)
			@attack_count += 1
			@need_rest = true if warrior.health < 6 
		end
		
		#rescue captive
		if warrior.feel(:backward).captive? 
			warrior.rescue!(:backward)
		end
		if warrior.feel.captive?
			warrior.rescue!
		end
		
		if warrior.feel.wall? 
			if @need_rest
				warrior.rest!
			end
			if @hp > 14
				@need_rest = false
			end
		end
		
		@hp = warrior.health
  end
end
