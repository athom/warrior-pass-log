# level 2
#  ----
# |@s  |
# | sS>|
#  ----

class Player
	def play_turn(warrior)
		#fight!!!
		dir = warrior.direction_of_stairs
		if warrior.feel(dir).to_s.match(/S/)
			warrior.attack!(dir)
		else
			warrior.walk!(dir)
		end
  end
end
