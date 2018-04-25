# ruby_building_blocks

Three small ruby coding projects: caeser_cipher, stock_picker, and substrings.  

Each project consists of a single method to be designed according to the specifications put forth by The Odin Project (https://www.theodinproject.com/courses/ruby-programming/lessons/building-blocks?ref=lnav)

Each project also includes several other helper methods that either facilitate creating either test code, or the objects used in the main method (for example, to create the dictionary array in substrings)

## Caaser Cipher

Returns an encrypted version of the input string.
Encryption is done by increasing (or decreasing) each alpha-numeric
character by the shift_factor (positive shifts to the right, numerically,
or alphabetically, while negative shifts to the left...).
Uppercase letters remain uppercase, Lowercase letters remain lowercase,
and numbers remain numbers.  Each type/set wraps to the beginning if
extended beyond its upper bound (Type/set ranges are: a-z, A-Z, and 0-9)
eg: If shift factor is 2, Z => B, z => b, and 9 => 1.
Non-alphanumeric characters are not affected (including "space")


## Stock Picker

Picks buy and sell dates, based on maximizing profit from an array of prices,
where each array position represents the stock price for that day.

The method assumes prices are given as integer values, and that stock can
neither be bought nor sold at a price of $0.  Therefore, the method requires
that there be at least 2 non-zero prices, and there must be an increase in
price from one non-zero price to another.

The method also attempts to avoid "risk" by holding stock for as few days as
necessary.  Therefore, if 2 different sets of buy/sell dates will result in
the same profit, the algorithm will choose the set where the buy/sell dates
are closest to one another.  If two sets of dates result in the same profit,
and the holding time is the same for both sets, the algorithm chooses the
earliest-occurring set of buy/sell dates.


## Substrings

Returns a Hash containing Strings (keys), and a count for each (values).
The strings consist of entries from a given dictionary (Array) that match 
( either partially or fully) the words contained in the input (String).  
The count is number of times each dictionary entry finds within the input.
Only entries with a count greater than 0 are returned.
