# frozen_string_literal: true

# nodes on chessboard for the knight
class ChessBoard
  require './square'
  def initialize(board_size = 8)
    @board_size = board_size
    # generate an knight-specific adjacency list for every square on the game board
    @knight_moves_adjacency_list = make_knight_moves_adjacency_list
  end

  # find and print the shortest path a knight can take to get to a specified square
  def knight_moves(origin, destination)
    root = Square.new(convert_to_square_num(origin), 0, nil)
    destination_square = find_destination_of_shortest_path(convert_to_square_num(destination), [root])
    # p destination_square
    shortest_path = find_shortest_path_from_origin(destination_square)
    # p shortest_path
    puts "You made it in #{shortest_path.length} moves! Here's your path:"
    shortest_path.each { |coordinate| p coordinate }
    p destination
    shortest_path
  end

  private

  # generate an knight-specific adjacency list for every square on the game board
  def make_knight_moves_adjacency_list
    number_of_squares = @board_size**2 # number of total squares on the game board
    moves_list = [] # the adjacency list of knight moves
    number_of_squares.times do |square|
      # it was easier to logically plot out all possible moves and eliminate any out of bounds
      # if they were converted to the [x,y] format.
      coordinate = convert_to_x_y(square)
      # convert the list of [x,y] coordinates back to integer to better represent the array index
      # before storing
      moves_list << generate_valid_coordinate_list(coordinate).map { |coord| convert_to_square_num(coord) }
    end
    moves_list
  end

  def convert_to_x_y(square_num)
    # reversed because x should go before y in the [x,y] coordinate form
    square_num.divmod(@board_size).reverse
  end

  def convert_to_square_num(coordinate)
    coordinate[1] * @board_size + coordinate[0]
  end

  # make a list of valid knight moves from one single coordinate
  def generate_valid_coordinate_list(starting_point)
    all_possible_moves = generate_all_possible_moves(starting_point[0], starting_point[1])
    all_possible_moves.reject { |coord| out_of_bounds?(coord[0]) || out_of_bounds?(coord[1]) }
  end

  # knight-specific move set
  def generate_all_possible_moves(c_x, c_y)
    [[c_x - 2, c_y - 1], [c_x - 2, c_y + 1],
     [c_x + 2, c_y - 1], [c_x + 2, c_y + 1],
     [c_x - 1, c_y - 2], [c_x - 1, c_y + 2],
     [c_x + 1, c_y - 2], [c_x + 1, c_y + 2]]
  end

  # checks to see if the coordinate lands within the board
  def out_of_bounds?(single_coord)
    single_coord >= @board_size || single_coord.negative?
  end

  # level order traversal, stopping when the destination square is found and returns
  # the knight-square object (which contains all of it's predecessors)
  def find_destination_of_shortest_path(destination, queue)
    visited = [] # track visited squares
    loop do
      square = queue.shift # dequeue

      # using the square_num of the index as the index to the adjacency list, 
      # get all the possible squares the knight can move to, and process them.
      @knight_moves_adjacency_list[square.index].each do |index|
        return square if index.eql?(destination) # destination square is found

        new_knight = Square.new(index, square.distance + 1, square)
        queue.push(new_knight) unless visited.include?(index) # enqueue
        visited << index # track visited squares
      end
    end
  end

  # builds an array of squares in [x,y] form to print to console
  def find_shortest_path_from_origin(square)
    return [convert_to_x_y(square.index)] if square.predecessor.nil?

    find_shortest_path_from_origin(square.predecessor) << convert_to_x_y(square.index)
  end
end

chessboard = ChessBoard.new
chessboard.knight_moves([3,3],[4,3]) #=> [[3,3],[4,5],[2,4],[4,3]]
chessboard.knight_moves([0,0],[1,2]) #=> [[0,0],[1,2]]
chessboard.knight_moves([0,0],[3,3]) #=> [[0,0],[1,2],[3,3]]
chessboard.knight_moves([3,3],[0,0]) #=> [[3,3],[1,2],[0,0]]
#p chessboard