require 'rubygems'
require 'colorize'
require 'character.rb'

def stat_roll
	(rand(6)+1) + (rand(6)+1) + (rand(6)+1)
end

class World
	attr_accessor :name, :x, :y, :size, :rooms, :player, :max_monsters, :total_monsters, :monsters

	def initialize(name, x, y)
		@name = name
		@x = x
		@y = y
	end

	def generateRooms
		@size = x * y
		@max_monsters = @size / 4
		@total_monsters = 0
		@monsters = []
		@rooms = []	
		@player = Player.new("Player 1",0,0,1)
	
		@y.times do |y|
			current_line = []
			@x.times do |x|
				if x == 0 && y == 0
					room = (Room.new("room_#{x}#{y}",x,y,[@player]))	
				elsif @total_monsters < @max_monsters && rand(4) == 3
					@monsters.push(Monster.new("monster_#{@total_monsters}",x,y,1))
					@total_monsters += 1
					room = Room.new("room_#{x}#{y}",x,y,[@monsters[@total_monsters-1]])
				else
					room = Room.new("room_#{x}#{y}",x,y,[])

				end	
				current_line.push(room)
			end
			@rooms.push current_line
		end
	end

	def findRoom(x, y) 
		@rooms[y][x]
	end

	def render
		@rooms.each do |line|
			row = ""
			line.each do |room|
				row += room.to_s + " "
			end
			puts row
		end
	end
end

class Room < World
	attr_accessor :occupents

	def initialize(name, x, y, occupents)
		super(name, x, y)
		@occupents = []
		if occupents.length > 0
			occupents.each do |occupent|
				@occupents.push(occupent)
			end
		end
	end

	def has_player?
		@occupents.each do |occupent|
			if occupent.class.to_s == "Player"
				return true
			end
		end
	end

	def has_monster?
		@occupents.each do |occupent|
			if occupent.class.to_s == "Monster"
				return true
			end
		end
	end

	def to_s
		player_check = has_player?
		monster_check = has_monster?
		if @occupents.length == 0
			"X".colorize( :yellow )
		elsif @occupents.length == 1
			@occupents[0].symbol
		elsif @occupents.length > 1 && player_check == true
			"B".colorize( :white )
		elsif @occupents.length > 1 && monster_check == true
			"+".colorize( :grey )
		end
	end
end
