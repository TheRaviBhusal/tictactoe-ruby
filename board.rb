
class Board
    attr_accessor :board, :grid_size, :empty_cells

    def initialize(grid_size)
        @grid_size = grid_size
        @board = Array.new(grid_size){Array.new(grid_size)}
        @empty_cells = grid_size*grid_size

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
    end

    def set_board_cell_value(row,column,current_player)
        @board[row][column] = current_player.player_piece
        @empty_cells -= 1
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
