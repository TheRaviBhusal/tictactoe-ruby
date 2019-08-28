
class Player
    attr_accessor :id, :name, :player_piece

    def initialize(id,player_name)
        @id = id
        @name = player_name
        @id == 1 ? @player_piece = "X" : @player_piece = "O"
    end

end



