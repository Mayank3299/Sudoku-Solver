# frozen_string_literal: true

require_relative 'board'
require 'byebug'

# Game class
class Game
  def initialize
    @board = Board.from_file('sudoku1_almost.txt')
  end

  def game_grid
    @board.grid
  end

  def play
    until @board.solved?
      @board.render
      arr = prompt
      @board[arr[0]] = arr[1]
      @board.render
    end
    puts 'Congratulations! You won!'
  end

  def prompt
    [get_pos, get_value]
  end

  def get_pos
    inp = nil
    until inp && valid_pos?(inp)
      puts 'Please enter a position where you want to input:'
      inp = gets.chomp.split.map!(&:to_i)
    end
    inp
  end

  def valid_pos?(pos)
    pos.is_a?(Array) &&
    pos.length == 2 &&
    pos.all?{|ele| ele >= 0 && ele < game_grid.length}
  end

  def get_value
    val = nil
    until val && (1..9).include?(val)
      puts 'Please enter a value for the specified position'
      val = gets.chomp.to_i
    end
    val
  end
end
