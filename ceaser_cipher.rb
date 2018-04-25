
# Returns an encrypted version of the input string.
# Encryption is done by increasing (or decreasing) each alpha-numeric
# character by the shift_factor (positive shifts to the right, numerically,
# or alphabetically, while negative shifts to the left...).
# Uppercase letters remain uppercase, Lowercase letters remain lowercase,
# and numbers remain numbers.  Each type/set wraps to the beginning if
# extended beyond its upper bound (Type/set ranges are: a-z, A-Z, and 0-9)
# eg: If shift factor is 2, Z => B, z => b, and 9 => 1.
# Non-alphanumeric characters are not affected (including "space")
#
# Parameters:   message: (string) the string to encrypt
#               shift_factor: (int) number each character shifts to the right
# Returns:      (string) the encrypted string
#
def caeser_cipher message, shift_factor
  message_encrypted = message.clone
  position = 0  # position in message_encrypted
  message_encrypted.each_char do |char|
    code = char.ord
    code_new = 0
    set_size = 26
    lower_bound = 0
    upper_bound = 0
    valid_char = true

    #lowercase letters
    if code >= 97 && code <= 122
      lower_bound = 97
      upper_bound = 122
    #uppercase letters
    elsif code >= 65 && code <= 90
      lower_bound = 65
      upper_bound = 90
    #numbers
    elsif code >= 48 && code <= 57
      lower_bound = 48
      upper_bound = 57
      set_size = 10
    #not alpha-numeric
    else
      valid_char = false
    end

    if valid_char == true
      code_shifted = code + shift_factor
      if code_shifted < lower_bound
        code_new = upper_bound - (((lower_bound -1) - code_shifted) % set_size)
      elsif code_shifted > upper_bound
        code_new = lower_bound + ((code_shifted - (upper_bound + 1)) % set_size)
      else
        code_new = code_shifted
      end
      message_encrypted[position] = code_new.chr
    end
    position += 1
  end
  return message_encrypted
end


def cipher_test test_message
  puts " "
  puts test_message + "  (original)"
  puts caeser_cipher(test_message, 0)   + "  (shift =   0)"
  puts caeser_cipher(test_message, 3)   + "  (shift =   3)"
  puts caeser_cipher(test_message, -3)  + "  (shift =  -3)"
  puts caeser_cipher(test_message, 10)  + "  (shift =  10)"
  puts caeser_cipher(test_message, -10) + "  (shift = -10)"
  puts caeser_cipher(test_message, 26)  + "  (shift =  26)"
  puts caeser_cipher(test_message, -26) + "  (shift = -26)"
  puts caeser_cipher(test_message, 29)  + "  (shift =  29)"
  puts caeser_cipher(test_message, -29) + "  (shift = -29)"
  puts "________________________________________________"
  puts " "
end


# Run tests
puts "\nTest uppercase range"
msg = "ABCDE, VWXYZ!"
cipher_test(msg)
puts "Test lowercase character range"
msg = "abcde, vwxyz!"
cipher_test(msg)
puts "Test number character range"
msg = "01234, 56789!"
cipher_test(msg)
puts "Test non-alphanumeric characters"
msg = "!@#$%^&*()_+-=[]{}\\|;':?/,.<>`~"
cipher_test(msg)
