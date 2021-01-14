# frozen_string_literal: true

require 'pry'
# nodes on chessboard for the knight
class ChessBoard
  require './knight-square'
  def initialize(board_size = 8)
    @board_size = board_size
    @knight_moves_adjacency_list = make_knight_moves_adjacency_list
  end

  private

  def make_knight_moves_adjacency_list
    number_of_squares = @board_size**2
    moves_list = []
    number_of_squares.times do |square|
      coordinate = convert_to_x_y(square)
      moves_list << generate_valid_coordinate_list(coordinate).map { |coord| convert_to_square_num(coord) }
    end
    moves_list
  end

  def convert_to_x_y(square_num)
    square_num.divmod(@board_size)
  end

  def convert_to_square_num(coordinate)
    coordinate[0] * @board_size + coordinate[1]
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
    single_coord > 7 || single_coord.negative?
  end
end

chessboard = ChessBoard.new
