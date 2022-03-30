class Player
    attr_reader :name
    attr_accessor :owned_cards
    def initialize(name)
        @name = name
        @owned_cards = []
    end
end