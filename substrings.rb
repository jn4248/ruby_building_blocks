
# Returns a Hash containing Strings (keys), and a count for each (values).
# The strings consist of entries from a given dictionary (Array) that match
# ( either partially or fully) the words contained in the input (String).
# The count is number of times each dictionary entry finds within the input.
# Only entries with a count greater than 0 are returned.
#
def substrings input, dictionary
  input.downcase!
  result = {}
  dictionary.each do |word|
    word.downcase!
    matches = input.scan(/#{word}/)
    if matches.size > 0
      result[word] = matches.size
    end
  end
  return result
end

# Adds strings to an exisisting dictionary, where the dictionary is an Array
# of strings.
# The input string can be one word, or multiple words.
# The input is split into individual words using "space" as a delimiter,
# then further stripped of any spaces or non-alphabetical characters, and
# then finally reduced to all lowercase letters before being stored in an array.
def add_words my_string, dictionary
  new_words = my_string.split(" ")
  new_words.each do |word|
    # remove any returns or spaces
    word.strip!
    # remove possesive case
    if word[-2..-1] == "'s"
      word.slice!(-2, 2)
    end
    # remove any preceeding non-alphabetical characters
    while (word.length > 0) && (word[0].match(/[a-zA-Z]/) == nil)
      # note: can not call match() on nil strings. must check length first
      word.slice!(0)
    end
    # remove any trailing non-alphabetical characters
    while (word.length > 0) && (word[-1].match(/[a-zA-Z]/) == nil)
      # note: can not call match() on nil strings. must check length first
      word.slice!(-1)
    end
    # don't add empty strings
    if (word.length > 0) && (!dictionary.include?(word))
      dictionary.push(word.downcase)
    end
  end
end

# Test Code
my_dictionary = []
content = "below down go going horn how howdy it i low own part partner sit"
add_words(content, my_dictionary)
phrase = "Howdy partner, sit down! How's it going?"
matches = substrings(phrase, my_dictionary)
# Display results
puts "\nMy Dictionary:"
p my_dictionary
puts "\nTest Phrase: \"#{phrase}\""
puts "\n`Substrings found:"
puts matches
