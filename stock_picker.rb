
# Picks buy and sell dates, based on maximizing profit from an array of prices,
# where each array position represents the stock price for that day.
#
# The method assumes prices are given as integer values, and that stock can
# neither be bought nor sold at a price of $0.  Therefore, the method requires
# that there be at least 2 non-zero prices, and there must be an increase in
# price from one non-zero price to another.
#
# The method also attempts to avoid "risk" by holding stock for as few days as
# necessary.  Therefore, if 2 different sets of buy/sell dates will result in
# the same profit, the algorithm will choose the set where the buy/sell dates
# are closest to one another.  If two sets of dates result in the same profit,
# and the holding time is the same for both sets, the algorithm chooses the
# earliest-occurring set of buy/sell dates.
#
def stock_picker prices
  valid_result = true
  # can not analyze if there are less than 2 prices
  if (prices.empty? || (prices.size < 2))
    valid_result = false
  end
  position_buy = 0
  position_sell = 0
  final_days_held = 0
  max_profit = 0
  prices.each.with_index do |price, index|
    # can not buy at price of $0. skip iteration.
    if price == 0
      next
    end
    temp_high = index
    counter = 1

    # find best buy/sell range starting with this index
    while (index + counter) < prices.size
      if prices[(index + counter)] > prices[temp_high]
        temp_high = index + counter
      end
      counter += 1
    end

    # check if this bu/sell range is better and any others previously checked
    temp_profit = prices[temp_high] - price
    temp_days_held = temp_high - index
    if ((temp_profit > max_profit) ||
            ((temp_profit ==  max_profit) &&
            (temp_days_held > 0) &&
            (temp_days_held < final_days_held)))
      position_buy = index
      position_sell = temp_high
      max_profit = temp_profit
      final_days_held = temp_days_held
    end
  end
  if (prices[position_buy] == 0) || (position_buy == position_sell)
    # case: two non-zero prices do not exist, or later price not greater than first
    valid_result = false
  end
  if valid_result
    return [position_buy, position_sell]
  else
    return []
  end
end


# Method to test various inputs for stock_picer method
def test_picker check, prices, expect
  result = stock_picker(prices)
  puts "\nCurrent Test: " + check
  puts "\nPrices Analayzed:"
  p prices
  puts "Expected:"
  p expect
  puts "Result:"
  p result
  puts "================================================"
end


#Test Case:
check = "Simple case. 2 prices, second higher than first. Both are non-zero."
prices = [1, 10]
expect = [0, 1]
test_picker(check, prices, expect)
#Test Case: empty array
check = "There must be at least 2 non-zero prices. Can neither buy, nor sell, for #$0."
prices = []
expect = []
test_picker(check, prices, expect)
#Test Case:
check = "There must be at least 2 non-zero prices. Can neither buy, nor sell, for #$0."
prices = [0, 10]
expect = []
test_picker(check, prices, expect)
#Test Case:
check = "There must be at least 2 non-zero prices. Can neither buy, nor sell, for #$0."
prices = [10, 0]
expect = []
test_picker(check, prices, expect)
#Test Case:
check = "There must be at least 2 non-zero prices. Can neither buy, nor sell, for #$0."
prices = [0, 0]
expect = []
test_picker(check, prices, expect)
#Test Case:
check = "There must be a price increase from one non-zero price to another."
prices = [10, 1]
expect = []
test_picker(check, prices, expect)
#Test Case:
check = "There must be a price increase from one non-zero price to another. Ignores zero."
prices = [0, 10, 2]
expect = []
test_picker(check, prices, expect)
#Test Case:
check = "There must be a price increase from one non-zero price to another."
prices = [1, 1, 1]
expect = []
test_picker(check, prices, expect)
#Test Case:
check = "There must be a price increase from one non-zero price to another."
prices = [8, 5, 3, 1]
expect = []
test_picker(check, prices, expect)
#Test Case:
check = "Ignore lowest price of zero, when it appears first."
prices = [0, 2, 10]
expect = [1, 2]
test_picker(check, prices, expect)
#Test Case:
check = "Ignore lowest price of zero, when it appears in the middle."
prices = [2, 0, 10]
expect = [0, 2]
test_picker(check, prices, expect)
#Test Case:
check = "Ignore lowest price of zero, when it appears in the middle."
prices = [10, 0, 2]
expect = []
test_picker(check, prices, expect)
#Test Case:
check = "Ignores lowest price when it comes on last day."
prices = [8, 3, 5, 1]
expect = [1, 2]
test_picker(check, prices, expect)
#Test Case:
check = "Ignores highest price when it comes first."
prices = [8, 3, 5, 1, 7]
expect = [3, 4]
test_picker(check, prices, expect)
#Test Case:
check = "Adjusts to higher, later-occuring sell price, it offers higher profit than an earlier date."
prices = [1, 5, 3, 8]
expect = [0, 3]
test_picker(check, prices, expect)
#Test Case:
check = "Adjusts to lower, later-occuring buy price, if an increase still occurs afterward."
prices = [3, 1, 5, 8]
expect = [1, 3]
test_picker(check, prices, expect)
#Test Case:
check = "Chooses to hold stock for fewest number of days, when same profit margin is available from two different sets of days. Here, first occurrence hold fewer days."
prices = [3, 4, 5, 1, 3]
expect = [3, 4]
test_picker(check, prices, expect)
#Test Case:
check = "Chooses to hold stock for fewest number of days, when same profit margin is available from two different sets of days. Here, second occurrence hold fewer days."
prices = [3, 5, 1, 2, 3]
expect = [0, 1]
test_picker(check, prices, expect)
#Test Case:
check = "Chooses first occurrence, when multiple sets of days result in the same profit, and the number of days holding stock is the same for both sets."
prices = [3, 5, 2, 4]
expect = [0, 1]
test_picker(check, prices, expect)
#Test Case:
check = "Chooses largest profit, even when lowest price is not the correct buy date."
prices = [18, 34, 15, 24, 98, 10, 1, 60]
expect = [2, 4]
test_picker(check, prices, expect)
#Test Case:
check = "Chooses largest profit, even when highest price is not the correct sell date."
prices = [45, 55, 80, 15, 24, 65, 60]
expect = [3, 5]
test_picker(check, prices, expect)
