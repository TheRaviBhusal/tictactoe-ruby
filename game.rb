# frozen_string_literal: true

# Tic Tac Toe Game Class
require './board.rb'
require './player.rb'
require './move.rb'


class Game
  attr_accessor :current_player, :game_over, :game_won, :game_tied,
                :board, :grid_size, :empty_cells, :winner
  attr_reader :player_one, :player_two

  def initialize()    
    @game_over = false
    @game_won = false
    @game_tied = false
    @winner = nil
	end
	
	def restart

		get_grid_size

		set_initial_board

		play

	end


  def start
    
    get_player_names

    get_grid_size

    set_initial_board
    
    play

	end
	


  def get_player_names
    puts "Lets Play Tic-Tac-Toe"

    puts "Enter player one's name:"
    player_one_name = gets.chomp

    @player_one= Player.new(1,player_one_name)

    puts "Enter player two's name:"
    player_two_name = gets.chomp

    @player_two=Player.new(2,player_two_name)

    @current_player = @player_one


  end


  def get_grid_size
    puts 'Enter the grid size'
    @grid_size = 1
    begin
      @grid_size = gets.chomp
      @grid_size = Integer(@grid_size)
    rescue ArgumentError
      puts 'Please enter a valid number'
      retry
    end
    @grid_size = 1 if @grid_size.zero?
  end

  def set_initial_board
    puts "#{@grid_size}"
    @board= Board.new(@grid_size)
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

  def draw_board
    board.draw_board
  end


  def set_player_piece
    puts "\n\nEnter the coordinates where you want to place your piece:"
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

    @board.set_board_cell_value(row,column,@current_player)
    move=Move.new()
    move.set_player_move_position(row,column,@current_player)
    move.get_player_move_position

  end

  def is_game_over?
    if @board.is_row_crossed? || @board.is_column_crossed? || @board.is_left_diagonal_crossed? || @board.is_right_diagonal_crossed?
      @game_won = true
      @winner = @current_player
      @game_over = true
    elsif @board.is_game_tied?
      @game_tied = true
      @game_over = true
    end
  end


  def set_current_player
    @current_player = if @current_player == @player_one
                        @player_two
                      else
                        @player_one
                      end
  end

  

  def after_game_is_over
    if @game_over == true && @game_won == true
      draw_board
      puts "\n\n#{@winner.name} wins the game"

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
      restart
    end
  end

 
end


game = Game.new

game.start
