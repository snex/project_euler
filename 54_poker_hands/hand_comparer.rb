require_relative 'playing_card'
require_relative 'poker_hand'
require_relative 'hand_utils'

# class to handle comparing two poker hands
class HandComparer
  include HandUtils

  def initialize(h1, h2)
    @h1 = h1
    @h2 = h2
    @h1_ranks = sorted_ranks(@h1)
    @h2_ranks = sorted_ranks(@h2)
  end

  def compare
    if PokerHand::HAND_VALUES.index(@h1.hand_value) ==
       PokerHand::HAND_VALUES.index(@h2.hand_value)
      send("compare_#{@h1.hand_value}")
    else
      PokerHand::HAND_VALUES.index(@h2.hand_value) <=>
        PokerHand::HAND_VALUES.index(@h1.hand_value)
    end
  end

  private

  def compare_royal_flush
    0
  end

  def compare_straight_flush
    compare_straight
  end

  def compare_four_of_a_kind
    compare_paired_hand(4)
  end

  def compare_full_house
    compare_three_of_a_kind
  end

  def compare_flush
    compare_high_card
  end

  def compare_straight
    @h1_ranks.first <=> @h2_ranks.first
  end

  def compare_three_of_a_kind
    compare_paired_hand(3)
  end

  def compare_two_pairs
    test = compare_paired_hand(2, 2)
    return test if test != 0

    compare_high_card
  end

  def compare_one_pair
    test = compare_paired_hand(2)
    return test if test != 0

    compare_high_card
  end

  def compare_high_card
    0.upto(4) do |i|
      test = @h1_ranks[i] <=> @h2_ranks[i]
      return test if test != 0
    end

    0
  end

  def compare_paired_hand(arity, num_pairs = 1)
    h1_paired_ranks = paired_ranks_by_count(@h1_ranks, arity)
    h2_paired_ranks = paired_ranks_by_count(@h2_ranks, arity)

    0.upto(num_pairs) do |i|
      test = h1_paired_ranks[i] <=> h2_paired_ranks[i]
      return test if test != 0
    end

    0
  end
end
