# level 4
#  -----
# |    S|
# |@> SC|
#  -----
class WorldModel
	
	def initialize(warrior)
		@warrior = warrior
		@left_state = warrior.feel(:left)
		@right_state = warrior.feel(:right)
		@forward_state = warrior.feel(:forward)
		@backward_state = warrior.feel(:backward)
		@enemy_dirs = []
		@binded_dirs = []
	end
	def enemy_count
		for dir in [:forward, :backward, :left, :right]
			obj = @warrior.feel(dir)
			if obj.to_s == "nothing" && !@warrior.feel(dir).stairs?
				@enemy_dirs << dir
			end
		end
		return 
	end
end



class Player
	def initialize
		@dirs = [:forward, :backward, :left, :right]
		@binded_flags = {:forward => false, :backward => false, :left => false, :right => false}
	end
	
	def fight(warrior, toward)
		puts toward
		for dir in @dirs
			if dir != toward && !@binded_flags[dir] && !warrior.feel(dir).empty? && !warrior.feel(dir).wall? && !warrior.feel(dir).captive?
				warrior.bind!(dir)
				@binded_flags[dir] = true
				return
			end
		end
		warrior.attack!(toward)
	end
	
	def search_enemies(warrior,toward)
		for dir in @dirs
			if dir != toward && warrior.feel(dir).empty?
				warrior.walk!(dir)
				return
			end
		end
	end
	
	def attacked?(warrior)
		for dir in @dirs
			if !warrior.feel(dir).empty? && !warrior.feel(dir).captive? && !warrior.feel(dir).wall? && !@binded_flags[dir]
				return true
			end
		end
		return false
	end
	
	def play_turn(warrior)
		pigs = warrior.listen
		if pigs.empty? #bingo, clear
				warrior.walk!(warrior.direction_of_stairs)
		else #go to next dog
			if warrior.health < 16 && !attacked?(warrior) && pigs.to_s.match(/Thick Sludge/)
				warrior.rest!
			else
				dir = warrior.direction_of(pigs.first)
				#puts dir
				if warrior.feel(dir).stairs?
					#warrior.walk!(wheretogo.values.first)
					search_enemies(warrior,dir)
				elsif warrior.feel(dir).captive?
					warrior.rescue!(dir)
					@binded_flags[dir] = false
				elsif warrior.feel(dir).empty?
					warrior.walk!(dir)
				else 
					fight(warrior,dir)
				end
			end
		end
  end
end
