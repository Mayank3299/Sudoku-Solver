# frozen_string_literal: true

require_relative 'board'
require 'byebug'

# SudokuSolver Class
class SudokuSolver
  attr_reader :board

  def initialize
    @board = Board.from_file('sudoku3.txt')
  end

  def tile(idx_i, idx_j)
    @board[[idx_i, idx_j]]
  end

  def sudoku_recurse(row, col)
    return true if @board.solved?

    if col == 9
      row += 1
      col = 0
    end

    (1...10).each do |val|
      return sudoku_recurse(row, col + 1) if tile(row, col).given?

      if placeable(row, col, val)
        @board[[row, col]] = val
        puts "Inserting value #{val} at [#{row},#{col}]"
        # @board.render
        return true if sudoku_recurse(row, col + 1) == true

        @board[[row, col]] = 0
        puts "Removing value #{val} from [#{row},#{col}]"
      end
    end
  end

  def placeable(x , y, val)
    check_row(x, val) && check_col(y, val) && check_square(x, y, val)
  end

  def check_row(x ,val)
    (0...9).each do |i|
      return false if tile(x, i).value == val
    end
    true
  end

  def check_col(y, val)
    (0...9).each do |j|
      return false if tile(j, y).value == val
    end
    true
  end

  def check_square(x,y,val)
    row = (x / 3) * 3
    col = (y / 3) * 3

    (row...row + 3).each do |i|
      (col...col + 3).each do |j|
        return false if tile(i, j).value == val
      end
    end
    true
  end

  def play
    sudoku_recurse(0, 0)
    @board.render
  end
end

if $PROGRAM_NAME == __FILE__
  s = SudokuSolver.new
  s.play
end
