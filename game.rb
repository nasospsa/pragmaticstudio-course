#!/usr/bin/env ruby
require_relative 'player'
require_relative 'game_turn'
require_relative 'treasure_trove'

class Game
	attr_reader :title

	def initialize(title)
		@title = title
		@players = []
	end

	def add_player(a_player)
		@players << a_player
	end

	def load_players(from_file)
		File.readlines(from_file).each do |line|
			add_player Player.from_csv(line)
		end
	end

	def play(rounds)
		puts "There are #{@players.size} players in #{@title}: "
		@players.each do |player|
			puts player
		end

		1.upto(rounds) do |round|
			puts "\nRound #{round}:"
			@players.each do |player|
				GameTurn.take_turn(player)
				puts player
			end
		end
	end

	def total_points
		@players.reduce(0) {|sum, player| sum + player.points }
	end

	def print_name_and_health(player)
		puts "#{player.name} (#{player.health})"
	end

	def print_stats
		puts "\n#{@title} Statistics:"
		strong_players, wimpy_players = @players.partition {|player| player.strong?}

		puts "\n#{strong_players.size} strong players:"
		strong_players.each do |p|
			print_name_and_health(p)
		end

		puts "\n#{wimpy_players.size} wimpy players:"
		wimpy_players.each do |p|
			print_name_and_health(p)
		end

		puts "\n#{title} High Scores:"
		@players.sort {|p1, p2|
			p2.score <=> p1.score
		}.each do |p|
			formatted_name = p.name.ljust(20, '.')
			puts "#{formatted_name} #{p.score}"
		end

		puts "\n#{total_points} total points from treasures found"
		@players.sort {|p1, p2|
			p2.score <=> p1.score
		}.each do |player|
			puts "\n#{player.name}'s point totals:"
			player.each_found_treasure do |treasure|
				puts "#{treasure.points} total #{treasure.name} points"
			end
			puts "#{player.points} grand total points"
		end

	end

	def save_high_scores(to_file='high_scores.txt')
		File.open(to_file, "w") do |file|
			file.puts "#{title} High Scores:"
			@players.sort { |p1, p2|
				p2.score <=> p1.score
			}.each do |player|
				file.puts high_score_entry(player)
			end
		end
	end

	def high_score_entry(player)
		player.name.ljust(10, ' ') + ":  #{player.score}"
	end

end

