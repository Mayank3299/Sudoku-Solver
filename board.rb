# frozen_string_literal: true

require_relative 'tile'
require 'colorize'

# Board Class
class Board
  VALUES = [1, 2, 3, 4, 5, 6, 7, 8, 9].freeze
  attr_accessor :grid

  def self.empty_grid
    Array.new(9) { Array.new(9, Tile.new(0)) }
  end

  def self.from_file(filename)
    rows = File.readlines(filename).map(&:chomp)
    tiles = rows.map do |row|
      nums = row.split('').map { |char| Integer(char) }
      nums.map { |ele| Tile.new(ele) }
    end
    new(tiles)
  end

  def initialize(grid = Board.empty_grid)
    @grid = grid
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    tile = @grid[row][col]
    tile.value = value
  end

  def render
    system('clear')
    puts "  #{(0..8).to_a.join(' ')}".green
    @grid.each_with_index do |row, i|
      print "#{i} ".green
      row.each_with_index do |ele,j|
        ((j + 1) % 3).zero? && j != 8 ? line= "|" : line= " "
        # print "#{ele}" + "#{line}"
        print ele.to_s + line.to_s
      end
      ((i + 1) % 3).zero? && i != 8 ? l= "\n  #{"-" * 17}" : l= ""
      puts l
    end
    nil
  end

  def solved?
    each_row && each_column && each_square
  end

  def each_row
    @grid.each do |row|
      arr = create_dup(VALUES)
      row.each do |ele|
        arr.delete(ele.value)
      end
      return false if arr.length.positive?
    end
    true
  end

  def each_column
    transposed_grid = @grid.transpose
    transposed_grid.each do |row|
      arr = create_dup(VALUES)
      row.each do |ele|
        arr.delete(ele.value)
      end
      return false if arr.length.positive?
    end
    true
  end

  def each_square
    array = (0...9).to_a.map { |i| square(i) }
    array.each do |row|
      arr = create_dup(VALUES)
      row.each do |ele|
        arr.delete(ele.value)
      end
      return false if arr.length.positive?
    end
    true
  end

  def square(index)
    x = (index / 3) * 3
    y = (index % 3) * 3
    tiles = []
    (x...x + 3).each do |i|
      (y...y + 3).each do |j|
        tiles << self[[i, j]]
      end
    end
    tiles
  end

  def create_dup(array)
    array.dup
  end
end
