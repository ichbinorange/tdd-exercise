require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require_relative '../lib/blackjack_score'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe 'Blackjack Score' do
  it 'can calculate the score for a pair of number cards' do

    # Arrange
    hand = [3, 4]

    # Act
    score = blackjack_score(hand)

    # Assert <-  You do this part!
    expect(score).must_equal 7

    hand = [2, 10, 6]
    score = blackjack_score(hand)
    expect(score).must_equal 18

    hand = [7, 3, 6, 5]
    score = blackjack_score(hand)
    expect(score).must_equal 21
  end

  it 'facecards have values calculated correctly' do
    hand = ["Jake", "King"]
    score = blackjack_score(hand)
    expect(score).must_equal 20

    hand = [10, "King"]
    score = blackjack_score(hand)
    expect(score).must_equal 20

    hand = [5, "Jake", 4]
    score = blackjack_score(hand)
    expect(score).must_equal 19

    hand = [5, "Queen", 2, 4]
    score = blackjack_score(hand)
    expect(score).must_equal 21
  end

  it 'calculates aces as 11 where it does not go over 21' do
    hand = ["Ace", "King"]
    score = blackjack_score(hand)
    expect(score).must_equal 21

    hand = [2, 7, "Ace"]
    score = blackjack_score(hand)
    expect(score).must_equal 20

    hand = [3, 2, 5, "Ace"]
    score = blackjack_score(hand)
    expect(score).must_equal 21
  end

  it 'calculates aces as 1, if an 11 would cause the score to go over 21' do
    hand = ["King", "Jake", "Ace"]
    score = blackjack_score(hand)
    expect(score).must_equal 21

    hand = [9, 8, "Ace", "Ace"]  # Both Ace are 1
    score = blackjack_score(hand)
    expect(score).must_equal 19

    hand = [2, 3, 4, "Ace", "Ace"] # One Ace is 1, the other is 11
    score = blackjack_score(hand)
    expect(score).must_equal 21
  end

  it 'raises an ArgumentError for invalid cards' do
    hand = [6, "Jake", 0]
    expect {blackjack_score(hand)}.must_raise ArgumentError

    hand = [2, "Queen", 5, -1]
    expect {blackjack_score(hand)}.must_raise ArgumentError

    hand = [2, 4, 5, 3, "Ace", 6]
    expect {blackjack_score(hand)}.must_raise ArgumentError
  end

  it 'raises an ArgumentError for scores over 21' do
    hand = ["Queen", 2, "Jake"]
    expect {blackjack_score(hand)}.must_raise ArgumentError

    hand = [6, 3, 5, 10]
    expect {blackjack_score(hand)}.must_raise ArgumentError

    hand = [4, 3, 5, "Ace", 10]
    expect {blackjack_score(hand)}.must_raise ArgumentError
  end
end
