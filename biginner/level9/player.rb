# level 9
#  -----------
# |>Ca  @ S wC|
#  -----------

#S: Thick Sludge
#C: Captive
#w: Wizard
#a: Archer


class Player
	def initialize()
		@go_home = false
	end
	
	def shoud_shoot(arr, dir)
		if dir == :backward
			if arr.match(/(nothing|Captive)*(Archer|Wizard|Thick Sludge)(nothing)*$/)
				puts 'b!!!!!!'
				return true
			end
		else
			if arr.match(/^(nothing)*(Archer|Wizard|Thick Sludge)(nothing|Captive)*/)
				puts 'f!!!!!!'
				return true
			end
		end
		return false
	end
	
  def play_turn(warrior)
		pigs = warrior.look.to_s
		dogs = warrior.look(:backward).to_s
		
		#the queue contain only Wizard or Archer, shoot them
		if shoud_shoot(dogs, :backward)
			warrior.shoot!(:backward)
			return
		end
		if shoud_shoot(pigs, :forward)
			warrior.shoot!(:forward)
			return
		end
		
		#rescue if the meets the Captive
		if warrior.feel.captive?
			warrior.rescue!
			return
		elsif !warrior.feel.empty? && !warrior.feel.wall?
			warrior.attack!
			return
		end
		
		if warrior.feel(:backward).captive?
			warrior.rescue!(:backward)
			return
		elsif !warrior.feel(:backward).empty?
			warrior.attack!(:backward)
			return
		end
	
		#go go go
		if !warrior.feel.wall? && !@go_home
			warrior.walk!
		elsif @go_home
			warrior.walk!(:backward)
		end
		if warrior.feel.wall? 
			@go_home = true
		end
 		
  end
end
