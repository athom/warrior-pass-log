# level 8
#  ------
# |@ Cww>|
#  ------

class Player
  def play_turn(warrior)
		pigs = warrior.look.to_s
		
		#the queue contain only Wizard, shoot them
		if !pigs.include?("Captive") && pigs.include?("Wizard")
			warrior.shoot!
			return
		end
		
		#rescue if the meets the Captive
		if warrior.feel.captive?
			warrior.rescue!
			return
		end
	
		#go go go
 		warrior.walk!
  end
end
