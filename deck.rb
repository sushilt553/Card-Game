require './card'
require './rank'
require './suit'

class Deck
    attr_accessor :cards
    def initialize
        @cards = Rank::RANKS.flat_map do |rank|
            Suit::SUITS.map do |suit|
                Card.new(rank, suit)
            end
        end
    end

    def draw
        @cards.pop
    end

    def shuffle!
        @cards.shuffle!
    end

    def sort!
        @cards.sort!
    end
end