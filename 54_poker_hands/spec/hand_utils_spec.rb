require_relative '../hand_utils'

RSpec.describe HandUtils do
  let(:dummy_class) { Class.new { include HandUtils } }
  subject { dummy_class.new }

  describe '#sorted_ranks' do
    let(:hand) { PokerHand.new(values) }

    context 'non-wheel hand' do
      let(:values) { %w[JC 8D 2S AH AS] }

      it 'is the sorted rank values of the hand' do
        expect(subject.sorted_ranks(hand)).to eq([12, 12, 9, 6, 0])
      end
    end

    context 'wheel (A-5 straight)' do
      let(:values) { %w[4C 3D 2S AH 5D] }

      it 'is the sorted rank values of the hand' do
        expect(subject.sorted_ranks(hand)).to eq([3, 2, 1, 0, -1])
      end
    end
  end

  describe '#paired_ranks_by_count' do
    context 'four of a kind' do
      let(:ranks) { [6, 6, 3, 6, 6] }

      it 'detects four of a kind' do
        expect(subject.paired_ranks_by_count(ranks, 4)).to eq([6, 6, 6, 6])
      end
    end

    context 'three of a kind' do
      let(:ranks) { [9, 6, 3, 6, 6] }

      it 'detects three of a kind' do
        expect(subject.paired_ranks_by_count(ranks, 3)).to eq([6, 6, 6])
      end
    end

    context 'two pairs' do
      let(:ranks) { [9, 3, 3, 6, 6] }

      it 'detects two pairs' do
        expect(subject.paired_ranks_by_count(ranks, 2)).to eq([6, 6, 3, 3])
      end
    end

    context 'one pair' do
      let(:ranks) { [9, 3, 3, 10, 6] }

      it 'detects one pair' do
        expect(subject.paired_ranks_by_count(ranks, 2)).to eq([3, 3])
      end
    end
  end
end
