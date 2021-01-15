# frozen_string_literal: true

require 'pry'
# nodes on chessboard for the knight
class Knight
  def initialize(index, distance = nil, predecessor = nil)
    @index = index
    @distance = distance
    @predecessor = predecessor
  end

  attr_accessor :index, :distance, :predecessor
end
