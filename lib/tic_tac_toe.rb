class TicTacToe

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end
  
  WIN_COMBINATIONS = [
    [0,1,2], #Top row
    [3,4,5], #Middle row
    [6,7,8], #Bottom row
    [0,3,6], #Left column
    [1,4,7], #Middle column
    [2,5,8], #Right column
    [0,4,8], #Diagonal (top-left to bottom-right)
    [2,4,6], #Diagonal (bottom-left to top-right)
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def position_taken?(index)
    @board[index] != " " && @board[index] != "" && @board[index] != nil
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    player = current_player
    if valid_move?(index)
      move(index, player)
    else
      turn
    end
    display_board
  end

  def turn_count
    turn_num = 0
    @board.each do |square|
      if square == "X" || square == "O"
        turn_num += 1
      end
    end
    turn_num
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.detect do |winning_line|
      @board[winning_line[0]] == @board[winning_line[1]] &&
      @board[winning_line[1]] == @board[winning_line[2]] &&
      position_taken?(winning_line[0])
    end
  end

  def full?
    !(@board.any? {|x| x == "" || x == " " || x == nil})
  end

  def draw?
    if full?
      if !won?
        return true
      end
    end
  end

  def over?
    full? || won? || draw?
  end

  def winner
    if combo = won?
      @board[combo.first]
    end
  end

  def play
    turn until over?
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end

  end
end