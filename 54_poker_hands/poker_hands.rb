require_relative 'playing_card'
require_relative 'poker_hand'

h1_wins = 0
h2_wins = 0
ties = 0

File.readlines('p054_poker.txt').each do |l|
  h1 = PokerHand.new
  h2 = PokerHand.new
  cards = l.chomp.split(' ')
  h1.add_cards(cards[0..4])
  h2.add_cards(cards[5..9])

  if h1 > h2
    h1_wins += 1
  elsif h1 < h2
    h2_wins += 1
  else
    ties += 1
  end
end

puts "h1 wins: #{h1_wins}"
puts "h2 wins: #{h2_wins}"
puts "ties: #{ties}"
