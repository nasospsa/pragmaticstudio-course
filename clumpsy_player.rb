#!/usr/bin/env ruby
require_relative 'player'
require_relative 'treasure_trove'

class ClumpsyPlayer < Player
	attr_reader :boost_factor

	def initialize(name, health=100, boost_factor=1)
		super name, health
		@boost_factor = boost_factor
	end

	def w00t
		@boost_factor.times { super }
	end

	def found_treasure(treasure)
		damaged_treasure = Treasure.new treasure.name, trasure.points/2.0
		super damaged_treasure
	end
end