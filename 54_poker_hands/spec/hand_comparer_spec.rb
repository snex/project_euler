require_relative '../hand_comparer'

RSpec.describe HandComparer do
  let(:h1) { PokerHand.new(values) }
  let(:h2) { PokerHand.new(other_values) }

  describe '.compare' do
    subject { described_class.new(h1, h2).compare }

    context 'hand_value is the same' do
      context 'royal flush' do
        let(:values) { %w[AS KS QS JS TS] }
        let(:other_values) { %w[TD JD QD KD AD] }

        it 'is 0' do
          expect(subject).to eq(0)
        end
      end

      context 'straight flush' do
        let(:values) { %w[7C JC 8C TC 9C] }

        context 'other hand is better' do
          let(:other_values) { %w[QD JD TD 9D 8D] }

          it 'is -1' do
            expect(subject).to eq(-1)
          end
        end

        context 'other hand is worse' do
          let(:other_values) { %w[5D 4D 3D 2D AD] }

          it 'is 1' do
            expect(subject).to eq(1)
          end
        end

        context 'other hand is the same' do
          let(:other_values) { %w[7D 8D 9D TD JD] }

          it 'is 0' do
            expect(subject).to eq(0)
          end
        end
      end

      context 'four of a kind' do
        let(:values) { %w[6S 6H 6D 6C 7D] }

        context 'other hand is worse' do
          let(:other_values) { %w[3C 3H 3D 3S AC] }

          it 'is 1' do
            expect(subject).to eq(1)
          end
        end

        context 'other hand is better' do
          let(:other_values) { %w[8C 8H 8D 8S AC] }

          it 'is -1' do
            expect(subject).to eq(-1)
          end
        end
      end

      context 'full house' do
        let(:values) { %w[6S 6H 6D 7C 7D] }

        context 'other hand is worse' do
          let(:other_values) { %w[3C 3H 3D AS AC] }

          it 'is 1' do
            expect(subject).to eq(1)
          end
        end

        context 'other hand is better' do
          let(:other_values) { %w[8C 8H 8D AS AC] }

          it 'is -1' do
            expect(subject).to eq(-1)
          end
        end
      end

      context 'flush' do
        let(:values) { %w[AS KS QS JS 2S] }

        context 'other hand is worse' do
          let(:other_values) { %w[AD KD JD TD 2D] }

          it 'is 1' do
            expect(subject).to eq(1)
          end
        end

        context 'other hand is better' do
          let(:other_values) { %w[AC KC QC JC 3C] }

          it 'is -1' do
            expect(subject).to eq(-1)
          end
        end

        context 'other hand is the same' do
          let(:other_values) { %w[AC KC QC JC 2C] }

          it 'is 0' do
            expect(subject).to eq(0)
          end
        end
      end

      context 'straight' do
        let(:values) { %w[7C 8D 9H TS JC] }

        context 'other hand is worse' do
          let(:other_values) { %w[AD 2D 3D 4D 5C] }

          it 'is 1' do
            expect(subject).to eq(1)
          end
        end

        context 'other hand is better' do
          let(:other_values) { %w[AC KC QC JC TD] }

          it 'is -1' do
            expect(subject).to eq(-1)
          end
        end

        context 'other hand is the same' do
          let(:other_values) { %w[JD TC 9S 8H 7S] }

          it 'is 0' do
            expect(subject).to eq(0)
          end
        end
      end

      context 'three of a kind' do
        let(:values) { %w[6S 6H 6D AC 7D] }

        context 'other hand is worse' do
          let(:other_values) { %w[3C 3H 3D 7S AC] }

          it 'is 1' do
            expect(subject).to eq(1)
          end
        end

        context 'other hand is better' do
          let(:other_values) { %w[8C 8H 8D 7S AC] }

          it 'is -1' do
            expect(subject).to eq(-1)
          end
        end
      end

      context 'two pairs' do
        let(:values) { %w[5H 5D 7H 7D KC] }

        context 'other hand is worse' do
          context 'no pairs match' do
            let(:other_values) { %w[3H 3D 4H 4D KS] }

            it 'is 1' do
              expect(subject).to eq(1)
            end
          end

          context 'top pair matches' do
            let(:other_values) { %w[7H 7D 4H 4D KS] }

            it 'is 1' do
              expect(subject).to eq(1)
            end
          end

          context 'bottom pair matches' do
            let(:other_values) { %w[5S 5C 7S 7C QS] }

            it 'is 1' do
              expect(subject).to eq(1)
            end
          end
        end

        context 'other hand is better' do
          context 'no pairs match' do
            let(:other_values) { %w[9H 8D 9H 8D AS] }

            it 'is -1' do
              expect(subject).to eq(-1)
            end
          end

          context 'top pair matches' do
            let(:other_values) { %w[7H 7D 6H 6D AS] }

            it 'is -1' do
              expect(subject).to eq(-1)
            end
          end

          context 'bottom pair matches' do
            let(:other_values) { %w[5S 5C 7S 7C AS] }

            it 'is -1' do
              expect(subject).to eq(-1)
            end
          end
        end

        context 'other hand is the same' do
          let(:other_values) { %w[5S 5C 7S 7C KS] }

          it 'is 0' do
            expect(subject).to eq(0)
          end
        end
      end

      context 'one pair' do
        let(:values) { %w[3H 6D 7H 7D KC] }

        context 'other hand is worse' do
          context 'no pair match' do
            let(:other_values) { %w[3H 2D 4H 4D KS] }

            it 'is 1' do
              expect(subject).to eq(1)
            end
          end

          context 'pair matches' do
            context 'no kicker match' do
              let(:other_values) { %w[7S 7C TH 9D JS] }

              it 'is 1' do
                expect(subject).to eq(1)
              end
            end

            context 'first kicker matches' do
              let(:other_values) { %w[7S 7C KH 5D 4S] }

              it 'is 1' do
                expect(subject).to eq(1)
              end
            end

            context 'second kicker matches' do
              let(:other_values) { %w[7S 7C KH 6D 2S] }

              it 'is 1' do
                expect(subject).to eq(1)
              end
            end
          end
        end

        context 'other hand is better' do
          context 'no pair match' do
            let(:other_values) { %w[8C 8D 3H 4S 2C] }

            it 'is -1' do
              expect(subject).to eq(-1)
            end
          end

          context 'pair matches' do
            context 'no kicker match' do
              let(:other_values) { %w[7C 7S AH 4S 2C] }

              it 'is -1' do
                expect(subject).to eq(-1)
              end
            end

            context 'first kicker matches' do
              let(:other_values) { %w[7C 7S KH 8S 2C] }

              it 'is -1' do
                expect(subject).to eq(-1)
              end
            end

            context 'second kicker matches' do
              let(:other_values) { %w[7C 7S KH 6S 5C] }

              it 'is -1' do
                expect(subject).to eq(-1)
              end
            end
          end
        end

        context 'other hand is the same' do
          let(:other_values) { %w[7S 7C KS 6C 3S] }

          it 'is 0' do
            expect(subject).to eq(0)
          end
        end
      end

      context 'high card' do
        let(:values) { %w[3H 6D 8H TD KC] }

        context 'other hand is worse' do
          context 'no card match' do
            let(:other_values) { %w[QC JD 9H 8S 4D] }

            it 'is 1' do
              expect(subject).to eq(1)
            end
          end

          context 'first kicker matches' do
            let(:other_values) { %w[KS 2D 9H 8S 4D] }

            it 'is 1' do
              expect(subject).to eq(1)
            end
          end

          context 'second kicker matches' do
            let(:other_values) { %w[KS TD 5H 3S 4D] }

            it 'is 1' do
              expect(subject).to eq(1)
            end
          end

          context 'third kicker matches' do
            let(:other_values) { %w[KS TD 8S 2S 4D] }

            it 'is 1' do
              expect(subject).to eq(1)
            end
          end

          context 'fourth kicker matches' do
            let(:other_values) { %w[KS TD 8S 2S 6S] }

            it 'is 1' do
              expect(subject).to eq(1)
            end
          end
        end

        context 'other hand is better' do
          context 'no card match' do
            let(:other_values) { %w[AS TD 7S 2S 6S] }

            it 'is -1' do
              expect(subject).to eq(-1)
            end
          end

          context 'first kicker matches' do
            let(:other_values) { %w[KS JD 4S 2S 3S] }

            it 'is -1' do
              expect(subject).to eq(-1)
            end
          end

          context 'second kicker matches' do
            let(:other_values) { %w[KS TS 9S 2S 3S] }

            it 'is -1' do
              expect(subject).to eq(-1)
            end
          end

          context 'third kicker matches' do
            let(:other_values) { %w[KS TS 8S 7S 3S] }

            it 'is -1' do
              expect(subject).to eq(-1)
            end
          end

          context 'fourth kicker matches' do
            let(:other_values) { %w[KS TS 8S 7S 4S] }

            it 'is -1' do
              expect(subject).to eq(-1)
            end
          end
        end

        context 'other hand is the same' do
          let(:other_values) { %w[3S 6S 8C TH KS] }

          it 'is 0' do
            expect(subject).to eq(0)
          end
        end
      end
    end

    context 'hand_value is different' do
      let(:values) { %w[AS AC AH 5S 6C] }

      context 'other hand_value is worse' do
        let(:other_values) { %w[7C 7S 5H 5D TC] }

        it 'returns 1' do
          expect(subject).to eq(1)
        end
      end

      context 'other hand is better' do
        let(:other_values) { %w[7C 8S 9H JD TC] }

        it 'returns -1' do
          expect(subject).to eq(-1)
        end
      end
    end
  end
end
