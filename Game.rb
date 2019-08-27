
class Game
	attr_accessor :current_player, :game_over, :game_won, :game_tied,
								:board, :grid_size, :empty_cells, :winner
	attr_reader :player_one, :player_two

	def initialize(board,grid_size,empty_cells)
		@player_one="X"
		@player_two="O"
		@current_player=@player_one
		@game_over=false
		@game_won=false
		@game_tied=false
		@board=board
		@grid_size=grid_size
		@empty_cells=empty_cells
		@winner=nil
	end


	def draw_board()
		for i in 0..@grid_size-1
			puts "\n"		
			for j in 0..@grid_size-1
				if @board[i][j]=="" || @board[i][j]==nil
					print "(#{i},#{j})" +"|" 
				else
					print "  #{board[i][j]}  |"
				end	
				if j==@grid_size-1
					print"\n"
					for k in 0..@grid_size-1
						print "______"
					end
				else
					next
				end
			end
		end

		puts "\n\n#{@current_player}'s turn'"
	end



	def play()
		loop do
			draw_board()

			set_player_piece()
		
			is_game_over?()

			set_current_player()

			after_game_is_over()
		end
	end

	def set_player_piece()
		puts "Enter the coordinates where you want to place your piece:"
			begin
				row=gets.chomp
				column=gets.chomp
				row=Integer(row)
				column=Integer(column)
			rescue ArgumentError
				puts "please enter integers"
				retry
			end
			until row>=0 && row <grid_size && column>=0 && column<grid_size 
				puts "please enter valid coordinates"
				begin
					row=gets.chomp
					column=gets.chomp
					row=Integer(row)
					column=Integer(column)
				rescue ArgumentError
					puts "please enter integers"
					retry
				end
			end
				
				@board[row][column]=@current_player
				@empty_cells-=1
				get_player_move(row,column)

	end

	def get_player_move(row,column)
		puts "\n\n\#{@current_player} placed their piece on (#{row},#{column})"
	end




	def set_current_player()
		if @current_player==@player_one then
			@current_player=@player_two
		else
			@current_player=@player_one
		end
	end


	def is_game_over?()
		if	is_row_crossed? || is_column_crossed? || is_left_diagonal_crossed? || is_right_diagonal_crossed?
			@game_won=true
			@winner=current_player
			@game_over=true
		elsif is_game_tied?
			@game_tied=true
			@game_over=true
		else
		end
	
	end



	def after_game_is_over()
		if @game_over==true && @game_won==true
			draw_board()
			puts "\n\n#{@winner} wins the game"
	
			puts "Do yo wanna play again(y/n)?"
			answer=gets.chomp
			until answer=='y' || answer=='Y' || answer=='N' || answer=="n"
				puts"please enter a valid choice"
				answer=get.chomp
			end
			if(answer=='n' ||answer=='N') then
				Process.exit(0)
			else
				start()
			end
				
			
		elsif @game_over==true && @game_tied==true
			
				draw_board()
				puts "\n\nGame is tied"
	
				puts "\nDo yo wanna play again(y/n)?"
				answer=gets.chomp
				until answer=='y' || answer=='Y' || answer=='N' || answer=="n"
					puts"please enter a valid choice"
					answer=get.chomp
				end
				if(answer=='n' ||answer=='N') then
					Process.exit(0)
				else
					start()
				end
		end
	end




	def is_row_crossed?()		
		number_of_same_cells=1
		(0..@grid_size-1).each do |i| 
			(0..@grid_size-1).each do |j|  
				if @board[i][j] == @board[i][j + 1] && @board[i][j] != "" && @board[i][j] != nil 
					number_of_same_cells+=1			
					if number_of_same_cells == @grid_size				
						return true 
						break			
					else 
						next
					end	
				else
					number_of_same_cells = 1
					break
				end			
			end
		end
		return false 
	end

	def is_column_crossed?()
		number_of_same_cells=1
		(0..@grid_size-1).each do |i| 
			(0..@grid_size-1).each do |j| 
				if @board[j][i]==@board[j+1][i] &&	j+1!=@grid_size && @board[j][i]!="" && @board[j][i]!=nil then
					number_of_same_cells+=1
					if number_of_same_cells==@grid_size then
						return true		
						break
					else 
						next
					end
				else
					number_of_same_cells=1
					break
				end
			end
		end
		return false 
	end

	

	def is_left_diagonal_crossed?()
		number_of_same_cells = 1
		(0..@grid_size-1).each do |i| 
			(0..@grid_size-1).each do |j| 
				if i == j then
					if i + 1 != @grid_size && j + 1 != @grid_size then
						if @board[i][j] == @board[i + 1][j + 1] && @board[i][j] != "" && @board[i][j] != nil then
							puts "here here here"
							number_of_same_cells+=1
							if number_of_same_cells == @grid_size  then 
								return true
								break
							else 
								break
							end
						else 
								break
						end						
					end					
				end
			end
		end
		return false
	end



	def is_right_diagonal_crossed?()
		number_of_same_cells = 1
		(0..@grid_size-1).each do |i| 
			(@grid_size-1).downto(0).each do |j| 
				if i + j ==@grid_size-1 then
					if i + 1 < @grid_size && j - 1 >= 0 then
						if i + 1 != @grid_size
							if @board[i][j] == @board[i + 1][j - 1] && @board[i][j] != "" && @board[i][j] != nil then
								number_of_same_cells+=1
								if number_of_same_cells ==@grid_size then   
									puts "here #{number_of_same_cells}" 
									return true
									break
								else 
									break
								end
							else 
								break
							end				
						end
					end
				end
			end	
		end
		return false
	end



	def is_game_tied?()
		if @empty_cells==0 then
			return true
		else
	  	return false
		end
	end

end


def start()
	puts "Enter the grid size"
	grid_size=1
	begin
		grid_size=gets.chomp
		grid_size=Integer(grid_size)
	rescue ArgumentError
		puts "Please enter a valid number"
		retry
	end
	if grid_size==0
		grid_size=1
	end
	
	board=Array.new(grid_size.abs){Array.new(grid_size.abs)}
	empty_cells= grid_size.abs * grid_size.abs
	game=Game.new(board,grid_size.abs,empty_cells)
	game.play()
end


puts "Let's play tic tac toe!!!"

start()





