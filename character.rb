require 'rubygems'
require 'colorize'

class Character
	attr_accessor :name, :location, :is_alive

	def initialize(name, x, y)
		@name = name
		@location = [x, y]
		@is_alive = true
	end
end

class Player < Character
	attr_accessor :hp, :str, :con, :dex, :symbol
	def initialize(name, x, y, level)
		super(name, x, y)
		@level = level
		@hp = (rand(8)+1) * level
		@str = stat_roll
		@con = stat_roll
		@dex = stat_roll
		@symbol = "O".colorize( :green )
	end
end

class Monster < Character
	attr_accessor :hp, :str, :con, :dex, :symbol
	
	def initialize(name, x, y, level)
		super(name, x, y)
		@level = level
		@hp = (rand(6)+2) * level
		@str = stat_roll
		@con = stat_roll
		@dex = stat_roll
		@symbol = "M".colorize( :red )
	end

	def move
		if rand(4) == 3
			direction = rand(4)
			if direction == 0
				"n"
			elsif direction == 1
				"s"
			elsif direction == 2
				"e"
			elsif direction == 3
				"w"
			end
		else
			nil
		end
	end
end


