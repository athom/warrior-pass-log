# level 9
#  ----
# |ssC>|
# |@sss|
# |ssC |
#  ----

class RubyWarrior::Space
	def <=>(other)
		if self.ticking? && !other.ticking?
			return -1
		elsif !self.ticking? && other.ticking?
			return 1
		else
			return self.to_s <=> other.to_s
		end
	end
end


class Player
	def initialize
		@dirs = [:forward, :backward, :left, :right]
		@hp = 0
		@binded_dogs = []
	end
	
	
	def fight(warrior, toward)
		puts toward
		for dir in @dirs
			if dir != toward && !@binded_dogs.include?(warrior.feel(dir)) && !warrior.feel(dir).empty? && !warrior.feel(dir).wall? && !warrior.feel(dir).captive?
				warrior.bind!(dir)
				@binded_dogs << warrior.feel(dir)
				return
			end
		end
		
		nuts = warrior.look(toward)
		if !nuts.to_s.match(/Captive/) && !nuts.to_s.match(/wall/) && nuts.to_s.match(/^((Thick Sludge)(Sludge)*|(Sludge)(Thick Sludge)*)/)
			warrior.detonate!(toward)
		else
			warrior.attack!(toward)
		end
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
			if !warrior.feel(dir).empty? && !warrior.feel(dir).captive? && !warrior.feel(dir).wall? && !@binded_dogs.include?(warrior.feel(dir))
				return true
			end
		end
		return false
	end
	
	def play_turn(warrior)
		pigs = warrior.listen
		pigs.sort!
		
		if pigs.empty? #bingo, clear
				warrior.walk!(warrior.direction_of_stairs)
		else #go to next dog
			if warrior.health < 13 && !attacked?(warrior)
				warrior.rest!
			else
				dir = warrior.direction_of(pigs.first)
				if warrior.feel(dir).stairs?
					search_enemies(warrior,dir)
				elsif warrior.feel(dir).captive?
					warrior.rescue!(dir)
					@binded_dogs.delete(warrior.feel(dir))
				elsif warrior.feel(dir).empty?
					warrior.walk!(dir)
				else 
					fight(warrior,dir)
				end
			end
		end
		
		@hp = warrior.health
  end
	
end
