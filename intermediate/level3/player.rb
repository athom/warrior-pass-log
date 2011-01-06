# level 3
#  ---
# |>s |
# |s@s|
# | C |
#  ---

class Player
	def initialize
		@dirs = [:forward, :backward, :left, :right]
		@bind_flags = {:forward => false,
		               :backward => false,
		               :left => false,
		               :right => false
		               }
	end
	
	
	def play_turn(warrior)
		for dir in @dirs
			pig = warrior.feel(dir)
			if pig.to_s == "Captive"
				warrior.rescue!(dir)
				return
			elsif pig.to_s == "Sludge" && !@bind_flags[dir]
				warrior.bind!(dir)
				@bind_flags[dir] = true
				return
			end
		end
		
		dir = warrior.direction_of_stairs
		if warrior.feel(dir).to_s == "Sludge"
			warrior.attack!(dir) 
			return
		end
		warrior.walk!(dir)
  end
end
