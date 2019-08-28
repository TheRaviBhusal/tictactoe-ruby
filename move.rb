
class Move
    attr_accessor :x, :y, :moved_player

    def set_player_move_position(row,column,current_player)
        @x = row
        @y = column 
        @moved_player = current_player
    end

    def get_player_move_position
        puts "#{@moved_player.name} place their piece '#{@moved_player.player_piece}' at (#{x},#{y})"
    end


    
end

