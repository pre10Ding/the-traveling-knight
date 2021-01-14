# frozen_string_literal: true

require 'pry'
# nodes on chessboard for the knight
class Knight
  require './knight-square'
  def initialize
    @root = nil
    @covered_coordinates = []
    @max_stacks_allowed = 3000
    @stack_level = 0
  end

  def knight_moves(starting_point, destination)
    # check to see if the KnightSquare obj is the same as last time.
    @root = generate_knight(starting_point) #unless @root.nil? || @root.coordinate.eql?(starting_point)
    # p @covered_coordinates
    # p @root
    @covered_coordinates = []
    @stack_level = 0
    squares_traveled = traverse_knight(destination) # array of coordinates
    number_of_moves = squares_traveled.length
    print_result(squares_traveled, number_of_moves)
  end

  private

  def generate_knight(starting_point)
    # puts "GENERATING KNIGHT MOVE #{starting_point}"
    knight = KnightSquare.new(starting_point)
    valid_coordinates = generate_valid_coordinate_list(starting_point)
    # p valid_coordinates
    valid_coordinates.each do |coordinate|
      # @covered_coordinates << coordinate
      @stack_level += 1
      @stack_level
      knight.possible_moves << generate_knight(coordinate) if @stack_level < @max_stacks_allowed
    end
    knight
  end

  def generate_valid_coordinate_list(starting_point)
    all_possible_moves = generate_all_possible_moves(starting_point[0], starting_point[1])
    # all_possible_moves -= @covered_coordinates
    all_possible_moves.reject { |coord| out_of_bounds?(coord[0]) || out_of_bounds?(coord[1]) }
  end

  def generate_all_possible_moves(c_x, c_y)
    [[c_x - 2, c_y - 1], [c_x - 2, c_y + 1],
     [c_x + 2, c_y - 1], [c_x + 2, c_y + 1],
     [c_x - 1, c_y - 2], [c_x - 1, c_y + 2],
     [c_x + 1, c_y - 2], [c_x + 1, c_y + 2]]
  end

  def out_of_bounds?(single_coord)
    single_coord > 8 || single_coord < 1
  end

  def traverse_knight(destination, square = @root)
    # p square
    return nil if square.possible_moves.eql?([])
    return square.coordinate if square.coordinate.eql?(destination)

    square.possible_moves.each do |move|
      path = traverse_knight(destination, move)
      return path.unshift(square.coordinate) unless path.nil?
    end
  end

  def print_result(squares_traveled, number_of_moves)
    puts "You made it in #{number_of_moves} moves!. Here is your path:"
    squares_traveled.each{ |square| p square }
  end
end

knight = Knight.new
knight.knight_moves([4, 4], [5, 4])
knight.knight_moves([1,1],[2,3]) # == [[0,0],[1,2]]
knight.knight_moves([1,1],[4,4]) # == [[0,0],[1,2],[3,3]]
knight.knight_moves([4,4],[1,1]) # == [[3,3],[1,2],[0,0]]
