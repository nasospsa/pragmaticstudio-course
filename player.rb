#!/usr/bin/env ruby

require_relative 'treasure_trove'
require_relative 'playable'

class Player
	include Playable

	attr_accessor :name, :health

	def initialize(name, health=100)
		@name = name.capitalize
		@health = health
		@found_treasures = Hash.new(0)
	end

	def self.from_csv(string)
		name, health = string.split ','
		new name, Integer(health)
	end

	def found_treasure(treasure)
		@found_treasures[treasure.name] += treasure.points
		puts "#{@name} found a #{treasure.name} worth #{treasure.points} points."
		puts "#{@name}'s treasures: #{@found_treasures}"
	end

	def each_found_treasure
		@found_treasures.each do |name, points|
			yield Treasure.new(name, points)
		end
	end

	def to_s
		"I'm #{@name} with health = #{@health}, points = #{points}, and score = #{score} as of #{time}"
	end

	def time
		current_time = Time.new
		current_time.strftime('%I:%M:%S')
	end

	def points
		@found_treasures.values.reduce(0,:+)
	end

	def score
		@health + points
	end
end