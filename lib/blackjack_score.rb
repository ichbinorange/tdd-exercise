# blackjack_score.rb

VALID_CARDS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

def blackjack_score(hand)
  score = 0
  raise ArgumentError.new("Invalid number of cards: #{ hand.count }") if hand.count > 5 || hand.count < 2
  ace_num = hand.count("Ace")
  hand.delete ("Ace")
  hand.each do |card|
    case card
    when (2..10)
      score += card
    when "Jake", "Queen", "King"
      score += 10
    else
      raise ArgumentError.new("Invalid card: #{ card }")
    end
  end

  while ace_num > 0
    if score > 10
      score += 1
    elsif score <= 10
      score += 11
    end
    ace_num -= 1
  end

  raise ArgumentError.new("Scores over 21: #{ score }") if score > 21
  return score
end
