require 'world.rb'

class Game
	attr_accessor :world, :current_turn

	def initialize
		@world = World.new("Earth",25,25)
		@current_turn = 0
	end

	def move_character(character, direction)
		if direction.downcase == "s"
			if character.location[1] + 1 == @world.y
				if character.class.to_s == "Player"
					puts "That is an invalid move"
					puts	
				end
			else
				@world.findRoom(character.location[0],character.location[1]).occupents.delete(character)
				character.location[1] += 1
				@world.findRoom(character.location[0],character.location[1]).occupents.push(character)
			end
		elsif direction.downcase == "n"
			if character.location[1] - 1 < 0
				if character.class.to_s == "Player"
					puts "That is an invalid move"
					puts	
				end
			else
				@world.findRoom(character.location[0],character.location[1]).occupents.delete(character)
				character.location[1] += -1
				@world.findRoom(character.location[0],character.location[1]).occupents.push(character)
			end
		elsif direction.downcase == "e"
			if character.location[0] + 1 == @world.x
				if character.class.to_s == "Player"
					puts "That is an invalid move"
					puts	
				end
			else
				@world.findRoom(character.location[0],character.location[1]).occupents.delete(character)
				character.location[0] += 1
				@world.findRoom(character.location[0],character.location[1]).occupents.push(character)
			end
		elsif direction.downcase == "w"
			if character.location[0] - 1 < 0
				if character.class.to_s == "Player"
					puts "That is an invalid move"
					puts	
				end
			else
				@world.findRoom(character.location[0],character.location[1]).occupents.delete(character)
				character.location[0] += -1
				@world.findRoom(character.location[0],character.location[1]).occupents.push(character)
			end
		else 
			puts "That is an invalid move"
			puts
		end
	end

	def turn	
		system "clear"
		self.move_character(self.world.player,$response)		
		@world.monsters.each do |monster|
			move = monster.move
			if move != nil
				self.move_character(monster, move)
			end
		end
		@world.render
		puts
		puts "What direction would you like to move?"
		$response = gets.chomp
		@current_turn += 1
	end
end

game0 = Game.new
game0.world.generateRooms
game0.world.render
puts "What direction would you like to move?"
$response = gets.chomp
while $response.downcase != "end"
	game0.turn
end	
