# frozen_string_literal: true

# Tic Tac Toe Game Class

class Game
  attr_accessor :current_player, :game_over, :game_won, :game_tied,
                :board, :grid_size, :empty_cells, :winner
  attr_reader :player_one, :player_two

  def initialize(board, grid_size, empty_cells)
    @player_one = 'X'
    @player_two = 'O'
    @current_player = @player_one
    @game_over = false
    @game_won = false
    @game_tied = false
    @board = board
    @grid_size = grid_size
    @empty_cells = empty_cells
    @winner = nil
  end

  def draw_board
    (0..@grid_size - 1).each do |i|
      puts "\n"
      (0..@grid_size - 1).each do |j|
        if @board[i][j] == '' || @board[i][j].nil?
          print "(#{i},#{j})" + '|'
        else
          print "  #{board[i][j]}  |"
        end
        next unless j == @grid_size - 1

        print "\n"
        (0..@grid_size - 1).each do |_k|
          print '______'
        end
      end
    end

    puts "\n\n#{@current_player}'s turn'"
  end

  def play
    loop do
      draw_board

      set_player_piece

      is_game_over?

      set_current_player

      after_game_is_over
      break if @game_over == true
    end
  end

  def set_player_piece
    puts 'Enter the coordinates where you want to place your piece:'
    row = grid_size
    column = grid_size
    until row >= 0 && row < grid_size && column >= 0 && column < grid_size
      puts 'please enter valid coordinates'
      begin
        row = gets.chomp
        column = gets.chomp
        row = Integer(row)
        column = Integer(column)
      rescue ArgumentError
        puts 'please enter integers'
        retry
      end
    end

    @board[row][column] = @current_player
    @empty_cells -= 1
    get_player_move(row, column)
  end

  def get_player_move(row, column)
    puts "\n\n #{@current_player} placed their piece on (#{row},#{column})"
  end

  def set_current_player
    @current_player = if @current_player == @player_one
                        @player_two
                      else
                        @player_one
                      end
  end

  def is_game_over?
    if is_row_crossed? || is_column_crossed? || is_left_diagonal_crossed? || is_right_diagonal_crossed?
      @game_won = true
      @winner = current_player
      @game_over = true
    elsif is_game_tied?
      @game_tied = true
      @game_over = true
    end
  end

  def after_game_is_over
    if @game_over == true && @game_won == true
      draw_board
      puts "\n\n#{@winner} wins the game"

      play_again?

    elsif @game_over == true && @game_tied == true

      draw_board
      puts "\n\nGame is tied"
      play_again?

    end
  end

  def play_again?
    puts "\nDo yo wanna play again(y/n)?"
    answer = gets.chomp
    until %w[y Y n N].include? answer
      puts 'please enter a valid choice'
      answer = gets.chomp
    end
    if %w[n N].include? answer
      Process.exit(0)
    else
      start
    end
  end

  def is_row_crossed?
    number_of_same_cells = 1
    (0..@grid_size - 1).each do |i|
      (0..@grid_size - 1).each do |j|
        if @board[i][j] == @board[i][j + 1] && @board[i][j] != '' && !@board[i][j].nil?
          number_of_same_cells += 1
          return true if number_of_same_cells == @grid_size
        else
          number_of_same_cells = 1
          break
        end
      end
    end
    false
  end

  def is_column_crossed?
    number_of_same_cells = 1
    (0..@grid_size - 1).each do |i|
      (0..@grid_size - 1).each do |j|
        if @board[j][i] == @board[j + 1][i] && j + 1 != @grid_size && @board[j][i] != '' && !@board[j][i].nil?
          number_of_same_cells += 1
          return true if number_of_same_cells == @grid_size
        else
          number_of_same_cells = 1
          break
        end
      end
    end
    false
  end

  def is_left_diagonal_crossed?
    number_of_same_cells = 1
    (0..@grid_size - 1).each do |i|
      (0..@grid_size - 1).each do |j|
        next unless i == j

        if i + 1 != @grid_size && j + 1 != @grid_size
          unless @board[i][j] == @board[i + 1][j + 1] && @board[i][j] != '' && !@board[i][j].nil?
            break
          else
            number_of_same_cells += 1
            return true if number_of_same_cells == @grid_size
          end
        end
      end
    end
    false
  end

  def is_right_diagonal_crossed?
    number_of_same_cells = 1
    (0..@grid_size - 1).each do |i|
      (@grid_size - 1).downto(0).each do |j|
        next unless i + j == @grid_size - 1
        next unless i + 1 < @grid_size && j - 1 >= 0
        if i + 1 != @grid_size
          unless @board[i][j] == @board[i + 1][j - 1] && @board[i][j] != '' && !@board[i][j].nil?
            break
          else
            number_of_same_cells += 1
            return true if number_of_same_cells == @grid_size
          end
        end
      end
    end
    false
  end

  def is_game_tied?
    @empty_cells.zero?
  end
end

def start
  puts 'Enter the grid size'
  grid_size = 1
  begin
    grid_size = gets.chomp
    grid_size = Integer(grid_size)
  rescue ArgumentError
    puts 'Please enter a valid number'
    retry
  end
  grid_size = 1 if grid_size.zero?

  board = Array.new(grid_size.abs) { Array.new(grid_size.abs) }
  empty_cells = grid_size.abs * grid_size.abs
  game = Game.new(board, grid_size.abs, empty_cells)
  game.play
end

puts "Let's play tic tac toe!!!"

start
