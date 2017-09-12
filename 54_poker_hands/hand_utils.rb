require_relative 'poker_hand'

# shared methods for poker hands
module HandUtils
  def sorted_ranks(hand)
    ranks = hand.cards.map { |c| PlayingCard::RANKS.index(c.rank) }.sort.reverse

    # handle A 2 3 4 5 straights
    if ranks == [12, 3, 2, 1, 0]
      [3, 2, 1, 0, -1]
    else
      ranks
    end
  end

  def paired_ranks_by_count(ranks, num_pairs)
    ranks.select do |r|
      ranks.count(r) == num_pairs
    end.sort.reverse
  end
end
