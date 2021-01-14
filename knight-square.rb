# frozen_string_literal: true

require 'pry'
# nodes on chessboard for the knight
class KnightSquare
  def initialize(coordinate)
    @coordinate = coordinate
    @possible_moves = []
  end

  attr_accessor :coordinate, :possible_moves
end
