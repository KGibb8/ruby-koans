
def score(dice)
  return 0 if dice.empty?
  score = 0
  num = 1
  while num <= 6
    items = dice.select {|i| i == num} # separates out recurring numbers
    if items.length >= 3
      score += 1000 if (num == 1)
      score += (num * 100) if (num != 1)
      if items.length == 4
        score += 100 if (num == 1)
        score += 50 if (num == 5)
      elsif items.length == 5
        score += 200 if num == 1
        score += 100 if num == 5
      end
    elsif items.length == 2
      score += 200 if num == 1
      score += 100 if num == 5
    elsif items.length == 1
      score += 100 if num == 1
      score += 50 if num == 5
    end
    num += 1
  end
  return score
end


def diceroll
  rand(1..6)
end

def greed
  dice = []
  for i in 1..5
    i = diceroll
    dice.push(i)
  end
  return dice
end
