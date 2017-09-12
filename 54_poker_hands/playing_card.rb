# represents an individual playing card
class PlayingCard
  include Comparable
  attr_reader :rank, :suit

  RANKS = %w[2 3 4 5 6 7 8 9 T J Q K A].freeze
  SUITS = %w[C D H S].freeze

  def initialize(value)
    @rank, @suit = value.split('')
  end

  def <=>(other)
    RANKS.index(rank) <=> RANKS.index(other.rank)
  end
end
