#!/usr/bin/env ruby

class Die
	def roll
		Random.new.rand(1..4)
	end
end