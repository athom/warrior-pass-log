# level 4
#  ----
# |C s |
# | @ S|
# |C s>|
#  ----

class Player
	def initialize
		@dirs = [:forward, :backward, :left, :right]
		@binded_boys = []
	end
	
	
	def play_turn(warrior)
		
		around_dog_hash = {}#dog means enemy, bcz i hate dog
		around_pig_hash = {}#pig means capvite, bcz it looks attackless
		for dir in @dirs
			obj = warrior.feel(dir)
			puts obj
			if obj.to_s != "nothing" && obj.to_s != "wall" && obj.to_s != "Captive"
				around_dog_hash[obj] = dir
			end
			if obj.to_s == "Captive"
				around_pig_hash[obj] = dir
			end
		end
		
		#fight when bad guys are arround you
		if !around_dog_hash.empty?
			if around_dog_hash.size > 1 && !@binded_boys.include?(around_dog_hash.keys[0].id)
					warrior.bind!(around_dog_hash.values.first)
					@binded_boys << around_dog_hash.keys.first.id
			else 
				warrior.attack!(around_dog_hash.values.first)
			end
			return
		end
		
		#save captive
		if !around_pig_hash.empty?
			warrior.rescue!(around_pig_hash.values.first)
			return
		end

		
		pigs = warrior.listen
		if pigs.empty? #bingo, clear
				warrior.walk!(warrior.direction_of_stairs)
		else #go to next dog
			if warrior.health < 13
				warrior.rest!
			else
				warrior.walk!(warrior.direction_of(pigs.first))
			end
		end
  end
end
