require_relative 'hand_comparer'

# represents a poker hand
class PokerHand
  include Comparable
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
    @cards.sort.first.rank == 'T' &&
      flush? &&
      straight?
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    ranks = @cards.map(&:rank)
    ranks.any? { |r| ranks.count(r) == 4 }
  end

  def full_house?
    three_of_a_kind? && one_pair?
  end

  def flush?
    @cards.map(&:suit).uniq.size == 1
  end

  def straight?
    sorted_ranks = @cards.sort.map { |c| PlayingCard::RANKS.index(c.rank) }
    sorted_ranks == (sorted_ranks.min..sorted_ranks.max).to_a ||
      # special case of A 2 3 4 5
      sorted_ranks == [0, 1, 2, 3, 12]
  end

  def three_of_a_kind?
    ranks = @cards.map(&:rank)
    ranks.any? { |r| ranks.count(r) == 3 }
  end

  def two_pairs?
    ranks = @cards.map(&:rank)
    pairs = ranks.each_with_object({}) do |r, accum|
      accum[r] ||= 0
      accum[r] += 1
    end

    pairs.select { |_, v| v == 2 }.size == 2
  end

  def one_pair?
    ranks = @cards.map(&:rank)
    ranks.any? { |r| ranks.count(r) == 2 }
  end

  def high_card?
    true
  end
end
