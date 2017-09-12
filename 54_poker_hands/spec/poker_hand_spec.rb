require_relative '../poker_hand'

RSpec.describe PokerHand do
  subject { described_class.new(values) }

  describe '#hand_value' do
    context 'not enough cards' do
      let(:values) { %w[AS] }

      it 'is nil' do
        expect(subject.hand_value).to be nil
      end
    end

    context 'royal flush' do
      let(:values) { %w[AS JS QS KS TS] }

      it 'identifies a royal flush' do
        expect(subject.hand_value).to eq(:royal_flush)
      end
    end

    context 'straight flush' do
      let(:values) { %w[7C JC 8C TC 9C] }

      it 'identifies a straight flush' do
        expect(subject.hand_value).to eq(:straight_flush)
      end
    end

    context 'four of a kind' do
      let(:values) { %w[TS TD 2S TC TH] }

      it 'identifies four of a kind' do
        expect(subject.hand_value).to eq(:four_of_a_kind)
      end
    end

    context 'full house' do
      let(:values) { %w[TS TD 2S TC 2H] }

      it 'identifies a full house' do
        expect(subject.hand_value).to eq(:full_house)
      end
    end

    context 'flush' do
      let(:values) { %w[TS 7S 2S 8S KS] }

      it 'identifies a flush' do
        expect(subject.hand_value).to eq(:flush)
      end
    end

    context 'straight' do
      context 'ace to five straight' do
        let(:values) { %w[5S 4D 3H 2C AS] }

        it 'identifies a straight' do
          expect(subject.hand_value).to eq(:straight)
        end
      end

      context 'other straights' do
        let(:values) { %w[5S 6D 7H 8C 9S] }

        it 'identifies a straight' do
          expect(subject.hand_value).to eq(:straight)
        end
      end
    end

    context 'three of a kind' do
      let(:values) { %w[TS TC TH 8S KS] }

      it 'identifies three of a kind' do
        expect(subject.hand_value).to eq(:three_of_a_kind)
      end
    end

    context 'two pairs' do
      let(:values) { %w[TS TC 8H 8S KS] }

      it 'identifies two pairs' do
        expect(subject.hand_value).to eq(:two_pairs)
      end
    end

    context 'one pair' do
      let(:values) { %w[TS TC 8H 7S KS] }

      it 'identifies one pair' do
        expect(subject.hand_value).to eq(:one_pair)
      end
    end

    context 'high card' do
      let(:values) { %w[TS AC 8H 7S KS] }

      it 'identifies high card' do
        expect(subject.hand_value).to eq(:high_card)
      end
    end
  end
end
