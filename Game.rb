

def draw_board(board,grid_size)

	for i in 0..grid_size-1
		puts "\n"		
		for j in 0..grid_size-1
			if board[i][j]=="" or board[i][j]==nil
				print "(#{i},#{j})" +"|" 
			else
				print "  #{board[i][j]}  |"
			end
			
			if j==grid_size-1
				print"\n"
				for k in 0..grid_size-1
					print "______"
				end
			else
				next
			end
		
		end
	end
end








def play(board,grid_size,empty_cells)
	player_one='X'

	player_two="O"

	current_player=player_one

	game_over=false

	game_won=false

	game_tied=false

	loop do

		draw_board(board,grid_size)
		puts "\n\n#{current_player}'s turn'"
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
			
			board[row][column]=current_player
			puts "#{current_player} placed their piece on (#{row},#{column})"
			empty_cells-=1
			game_over, game_won, winner=check_row_crossed(board,grid_size,current_player)
			if game_over==false		
				game_over, game_won, winner=check_column_crossed(board,grid_size,current_player)
				if game_over==false
					game_over, game_won, winner=check_left_diagonal_crossed(board,grid_size,current_player)	
					if game_over==false
						game_over, game_won, winner=check_right_diagonal_crossed(board,grid_size,current_player)
						if game_over==false
							game_over,game_tied=check_game_tied(board,grid_size,empty_cells)
						end
					end
				end
			end
			if current_player==player_one then
				current_player=player_two
			else
				current_player=player_one
			end
			
			if game_over==true && game_won==true
		
				draw_board(board,grid_size)
				puts "\n\n#{winner} wins the game"
		
				puts "Do yo wanna play again(y/n)?"
				answer=gets.chomp
				until answer=='y' || answer=='Y' || answer=='N' || answer=="n"
					puts"please enter a valid choice"
					answer=get.chomp
				end
				if(answer=='n' ||answer=='N') then
					break
				else
					start()
				end
					
				
			elsif game_over==true && game_tied==true
				
					draw_board(board,grid_size)
					puts "\n\nGame is tied"
		
					puts "Do yo wanna play again(y/n)?"
					answer=gets.chomp
					until answer=='y' || answer=='Y' || answer=='N' || answer=="n"
						puts"please enter a valid choice"
						answer=get.chomp
					end
					if(answer=='n' ||answer=='N') then
						break
					else
						start()
					end
			end
	
	end

	
		
end


def check_row_crossed(board,grid_size,current_player)
	
	number_of_same_cells=1

	(0..grid_size-1).each do |i| 
		(0..grid_size-1).each do |j|  
			if board[i][j] == board[i][j + 1] && board[i][j] != "" && board[i][j] != nil 
				number_of_same_cells+=1
			
				if number_of_same_cells == grid_size
					
					return true , true , current_player		
					break			
				else 
					next
				end	
			else
				number_of_same_cells = 1
				break
			end
			
			
		end
		return false , false , ''

	end
	return false , false , ''

end


def check_column_crossed(board,grid_size,current_player)
	number_of_same_cells=1

	(0..grid_size-1).each do |i| 
		(0..grid_size-1).each do |j| 
			if board[j][i]==board[j+1][i] &&	j+1!=grid_size && board[j][i]!="" && board[j][i]!=nil then
				number_of_same_cells+=1
				if number_of_same_cells==grid_size then
					return true , true , current_player		
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
	return false , false , ''

end

def check_left_diagonal_crossed(board,grid_size,current_player)
  number_of_same_cells = 1
	(0..grid_size-1).each do |i| 
		(0..grid_size-1).each do |j| 
      if i == j then
				if i + 1 != grid_size && j + 1 != grid_size then
					if board[i][j] == board[i + 1][j + 1] && board[i][j] != "" && board[i][j] != nil then
						puts "here here here"
						number_of_same_cells+=1
						if number_of_same_cells == grid_size  then 
							return true , true , current_player             
              break
						else 
              break
						end
					else 
              break
					end						
				end
			else
				
			end

		end
	end
	return false , false , ''
end
				

def check_right_diagonal_crossed(board,grid_size,current_player)
	number_of_same_cells = 1
  (0..grid_size-1).each do |i| 
		(grid_size-1).downto(0).each do |j| 
			if i + j ==grid_size-1 then
				if i + 1 < grid_size && j - 1 >= 0 then
        	if i + 1 != grid_size
          	if board[i][j] == board[i + 1][j - 1] && board[i][j] != "" && board[i][j] != nil then
            	number_of_same_cells+=1
							if number_of_same_cells ==grid_size then   
								puts "here #{number_of_same_cells}" 
                return true , true , current_player
                break
            	else 
              	break
							end
          	else 
              break
						end
          
        	else 
					end
				else
				end
			end
		end	
	end
	return false , false , ''
end



def check_game_tied(board,grid_size,empty_cells)
	if empty_cells==0 then
		return true, true
	else
	  return false,false
	end
end



puts "Let's play tic tac toe!!!"

def start()


	puts "Enter the grid size"
	grid_size=gets.chomp().to_i
	board=Array.new(grid_size){Array.new(grid_size)}
	empty_cells= grid_size * grid_size

	play(board, grid_size, empty_cells)
end

start()



