require_relative 'hand_comparer'
require_relative 'hand_utils'

# represents a poker hand
class PokerHand
  include Comparable
  include HandUtils
  attr_reader :cards

  HAND_VALUES = %i[
    royal_flush
    straight_flush
    four_of_a_kind
    full_house
    flush
    straight
    three_of_a_kind
    two_pairs
    one_pair
    high_card
  ].freeze

  def initialize(values = [])
    @cards = []
    add_cards(values)
  end

  def add_card(value)
    @cards << PlayingCard.new(value)
    @sorted_ranks = sorted_ranks(self)
  end

  def add_cards(values)
    values.each do |value|
      add_card value
    end
  end

  def hand_value
    return nil unless @cards.size == 5

    HAND_VALUES.each do |hv|
      return hv if send("#{hv}?")
    end
  end

  def <=>(other)
    HandComparer.new(self, other).compare
  end

  private

  def royal_flush?
    @sorted_ranks.first == PlayingCard::RANKS.size - 1 &&
      flush? &&
      straight?
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    !paired_ranks_by_count(@sorted_ranks, 4).empty?
  end

  def full_house?
    three_of_a_kind? && one_pair?
  end

  def flush?
    @cards.map(&:suit).uniq.size == 1
  end

  def straight?
    @sorted_ranks == (@sorted_ranks.min..@sorted_ranks.max).to_a.reverse
  end

  def three_of_a_kind?
    !paired_ranks_by_count(@sorted_ranks, 3).empty?
  end

  def two_pairs?
    paired_ranks_by_count(@sorted_ranks, 2).uniq.size == 2
  end

  def one_pair?
    !paired_ranks_by_count(@sorted_ranks, 2).empty?
  end

  def high_card?
    true
  end
end
