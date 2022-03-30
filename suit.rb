class Suit
    SUITS = [:spade, :heart, :diamond, :club]

    attr_reader :suit
    def initialize(suit)
        @suit = suit
    end
end