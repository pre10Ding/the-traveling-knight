# the-traveling-knight
Ruby implementation of finding the shortest amount of moves a knight would have to make to go from one square to another on a chess board.


ChessBoard instance methods:

``` #initialize(board_size = 8) ``` Returns a new ChessBoard object with an option to make it bigger or smaller than the default 8x8. 

``` #knight_moves(origin, destination) ``` Returns and prints the shortest path a knight from 'origin' (ie. [0,5]) can take to get to a specified destination square.


Run ```>ruby chess-board.rb``` to see some sample calculations.
