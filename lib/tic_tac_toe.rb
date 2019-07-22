WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [2,5,8],
  [1,4,7]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(inp)
  return inp.to_i - 1
end

def move(board, inp, char)
  board[inp] = char
  return board
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  ind = input_to_index(input)
  until valid_move?(board, ind)
    puts "Please enter 1-9:"
    input = gets.strip
    ind = input_to_index(input)
  end
  move(board, ind, current_player(board))
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |spot|
    if spot == "X" || spot == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def won?(board)
  win = false
  empty_board = board.all? {|x| x == " "}
  WIN_COMBINATIONS.each do |combo|
    if empty_board
      win = false
    elsif combo.all? { |value| board[value] =="X" } || combo.all? { |value| board[value] =="O" }
      win = combo
    end
  end
  return win
end

def full?(board)
  !board.any? { |x| x == " " }
end

def draw?(board)
  if (won?(board) == false) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if !(won?(board) == false) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if !(won?(board) == false)
    return board[won?(board)[0]]
  end
end
