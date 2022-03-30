require './deck'
require './player'

class Game
    attr_reader :players, :deck, :dealer
    def initialize    
        @deck = Deck.new
        @dealer = Player.new('Dealer')
        @players = []
    end

    def create_player(name)
        Player.new(name)
    end

    def deal_cards
        deal_count = 1;
        2.times do
            if deal_count == 1 
                puts "--> First Deal <--"
            else
                puts "--> Second Deal <--"
            end
            sleep 1
            players.each do |player|
                card = deck.draw
                player.owned_cards << card
                puts "#{player.name}: #{card.rank.rank}(#{card.suit.suit})"
                sleep 1
            end
            deal_count += 1
        end
    end

    def render_both_cards_for_all_players
        players.each do |player|
            first_card_rank = player.owned_cards[0].rank.rank
            first_card_suit = player.owned_cards[0].suit.suit
            second_card_rank = player.owned_cards[1].rank.rank
            second_card_suit = player.owned_cards[1].suit.suit
            puts "#{player.name}: |#{first_card_rank}(#{first_card_suit})| |#{second_card_rank}(#{second_card_suit})|"
            sleep 1
        end
    end

    def render_both_cards_for_dealer
        first_card_rank = dealer.owned_cards[0].rank.rank
        first_card_suit = dealer.owned_cards[0].suit.suit
        second_card_rank = dealer.owned_cards[1].rank.rank
        second_card_suit = dealer.owned_cards[1].suit.suit
        puts "#{dealer.name}: |#{first_card_rank}(#{first_card_suit})| |#{second_card_rank}(#{second_card_suit})|"
    end
    
    def dealer_first_deal
        first_card = deck.draw
        dealer.owned_cards << first_card
        first_card_rank = first_card.rank.rank
        first_card_suit = first_card.suit.suit
        puts "#{dealer.name}: #{first_card_rank}(#{first_card_suit})"
    end

    def dealer_second_deal
        second_card = deck.draw
        dealer.owned_cards << second_card
        second_card_rank = second_card.rank.rank
        second_card_suit = second_card.suit.suit
        puts "#{dealer.name}: #{second_card_rank}(#{second_card_suit})"
    end
    
    def calculate_winners
        dealer_highest_card = (dealer.owned_cards[0] <=> dealer.owned_cards[1]) == 1 ? dealer.owned_cards[0] : dealer.owned_cards[1]
        players_highest_cards = []
        players.each do |player|
            result = player.owned_cards[0] <=> player.owned_cards[1]
    
            if result === 1
                players_highest_cards << player.owned_cards[0]
            else
                players_highest_cards << player.owned_cards[1]
            end
        end

        players_highest_cards.each_with_index do |card, idx|
            result = card <=> dealer_highest_card
            player = players[idx]

            if result == 0
                puts "Dealer vs #{player.name}: DRAW"
            elsif result == 1
                puts "Dealer vs #{player.name}: #{player.name.upcase}"
            else
                puts "Dealer vs #{player.name}: DEALER"
            end
            sleep 1
        end
    end

    def play_hand
        deal_cards

        puts "--> Cards dealt to players <--"
        render_both_cards_for_all_players
        
        puts "Drawing dealer hands now..."
        sleep 1
        puts "--> First Deal <--"
        sleep 1
        dealer_first_deal
        sleep 1
        puts "--> Second Deal <--"
        sleep 1
        dealer_second_deal
        sleep 1
        puts "--> Dealer's cards <--"
        sleep 1
        render_both_cards_for_dealer
        sleep 1

        puts "And the WINNERS are..."
        sleep 2
        calculate_winners
        sleep 1
        puts "Do you want to play next hand? If yes, click 'y' and hit 'Enter', if no, just hit 'Enter'."
        response = gets.strip

        if (response === 'y')
            puts "Collecting and Shuffling cards..." 
            dealt_cards = []
            total_players = players + [dealer]
            total_players.each do |player| 
                dealt_cards += player.owned_cards
                player.owned_cards = []
            end
            deck.cards += dealt_cards
            deck.shuffle!
            sleep 1
            play_hand
        else
            puts '***GAME OVER!!! Hope you enjoyed playing!***'
        end
    end

    def play
        puts "****Welcome to the card game!!!****"
        count = 1
        while count <= 5 do
            puts "Player #{count}: Please enter your name..."
            name = gets.strip
            players << create_player(name)
            count += 1
        end

        deck.shuffle!
        players_list = players.map{|player| player.name }.join(', ')
        puts "Players: #{players_list}"
        sleep 1
        puts "***You will be playing with a dealer. Highest hand wins. Winner will be announced for each hand.***"
        sleep 2

        play_hand
    end
end

game = Game.new
game.play



