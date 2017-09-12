require_relative '../playing_card'

RSpec.describe PlayingCard do
  describe '#<=>' do
    subject { PlayingCard.new('7C') }
    let(:other) { PlayingCard.new(value) }

    context 'other rank is lower' do
      let(:value) { '6C' }

      it 'is 1' do
        expect(subject <=> other).to eq(1)
      end
    end

    context 'other rank is higher' do
      let(:value) { '8C' }

      it 'is -1' do
        expect(subject <=> other).to eq(-1)
      end
    end

    context 'other rank is the same' do
      let(:value) { '7D' }

      it 'is 0' do
        expect(subject <=> other).to eq(0)
      end
    end
  end
end
