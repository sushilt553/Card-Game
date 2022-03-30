require './rank'
require './suit'

class Card
    attr_reader :rank, :suit
    def initialize(rank, suit)
        @rank = Rank.new(rank)
        @suit = Suit.new(suit)
    end

    def <=> other
        rank <=> other.rank
    end
end