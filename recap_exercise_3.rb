def no_dupes?(arr)
    hash = Hash.new(0)
    arr.each do |val|
        hash[val]+=1
    end
    result = Array.new(0)
    hash.each {|k,v| result << k if v==1}
    result
end

# # Examples
# p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
# p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
# p no_dupes?([true, true, true])            # => []

def no_consecutive_repeats?(arr)
    return true if arr.length < 2
    (0...arr.length-1).all? do |i|
        arr[i] != arr[i+1]
    end
end

# p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
# p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
# p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
# p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
# p no_consecutive_repeats?(['x'])

def char_indices(str)
    hash = Hash.new {|h,k| h[k] = Array.new(0)}
    str.each_char.with_index {|char, i| hash[char] << i}
    hash
end

# Examples
# p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
# p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}

def longest_streak(str)
    return str if str.length < 2
    maxWord = ""
    i = 0
    while i < str.length-1
        word = ""
        while i < str.length-1 && str[i] == str[i+1]
            word << str[i]
            i+=1
        end
        word << str[i]
        maxWord = word if word.length >= maxWord.length
        i+=1
    end
    maxWord
end

# Examples
# p longest_streak('a')           # => 'a'
# p longest_streak('accccbbb')    # => 'cccc'
# p longest_streak('aaaxyyyyyzz') # => 'yyyyy
# p longest_streak('aaabbb')      # => 'bbb'
# p longest_streak('abc')         # => 'c'

def prime(num)
    (2...num).none? {|val| num % val == 0}
end

def bi_prime?(num)
    (2...num).each do |val|
        return true if num%val == 0 && prime(val) && prime(num/val)
    end
    false
end

# # Examples
# p bi_prime?(14)   # => true
# p bi_prime?(22)   # => true
# p bi_prime?(25)   # => true
# p bi_prime?(94)   # => true
# p bi_prime?(24)   # => false
# p bi_prime?(64)   # => false

def vigenere_cipher(message, keys)
    alpha = ('a'..'z').to_a
    mod = message.length % keys.length
    keys = keys*(message.length/keys.length) + keys[0...mod]
    message.split("").map.with_index {|char,i| alpha[(alpha.index(char)+keys[i])%26]}.join("")
end

# p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
# p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
# p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
# p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
# p vigenere_cipher("yawn", [5, 1])             # => "dbbo"

def vowel_rotate(str)
    vowels = "aeiou"
    vowelArr = Array.new(0)
    vowelIndices = Array.new(0)
    str.each_char.with_index do |char,i|
        if vowels.include?(char)
            vowelArr << char 
            vowelIndices << i
        end
    end
    vowelArr.unshift(vowelArr.pop)
    vowelArr.each_with_index do |vowel, i|
        str[vowelIndices[i]] = vowel
    end
    str
end

# p vowel_rotate('computer')      # => "cempotur"
# p vowel_rotate('oranges')       # => "erongas"
# p vowel_rotate('headphones')    # => "heedphanos"
# p vowel_rotate('bootcamp')      # => "baotcomp"
# p vowel_rotate('awesome')       # => "ewasemo"

class String

    def select(&prc)
        return "" if prc == nil
        newStr = ""
        self.each_char {|char| newStr << char if prc.call(char)}
        newStr
    end

    def map!(&prc)
        self.each_char.with_index {|char,i| self[i] = prc.call(char,i)}
    end

end

# # Examples
# p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
# p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
# p "HELLOworld".select          # => ""

# # Examples
# word_1 = "Lovelace"
# word_1.map! do |ch| 
#     if ch == 'e'
#         '3'
#     elsif ch == 'a'
#         '4'
#     else
#         ch
#     end
# end
# p word_1        # => "Lov3l4c3"

# word_2 = "Dijkstra"
# word_2.map! do |ch, i|
#     if i.even?
#         ch.upcase
#     else
#         ch.downcase
#     end
# end
# p word_2        # => "DiJkStRa"

# def multiply(a,b)
#     aSign = a < 0 ? -1 : 1
#     bSign = b < 0 ? -1 : 1
#     a = -1*a if aSign == -1
#     b = -1*b if bSign == -1 
#     aSign*bSign*multiply_positive(a,b)
# end

def multiply(a,b)
    return 0 if b==0
    # multiply(-3,-6) = multiply(-3,-5)-a
    # multiple(-3,5) = multiply(-3,4)+a
    # multiply(3, -6) = multiple(3,-5)-a
    if b < 0
        return multiply(a,b+1) - a
    else
        return multiply(a,b-1) + a
    end
end
# # Examples
# p multiply(3, 5)        # => 15
# p multiply(5, 3)        # => 15
# p multiply(2, 4)        # => 8
# p multiply(0, 10)       # => 0
# p multiply(-3, -6)      # => 18
# p multiply(3, -6)       # => -18
# p multiply(-3, 6)       # => -18

def lucas_sequence(n)
    return [] if n == 0
    return [2] if n == 1
    return [2,1] if n == 2
    arr = lucas_sequence(n-1)
    return arr << arr[-1]+arr[-2]
end

# Examples
# p lucas_sequence(0)   # => []
# p lucas_sequence(1)   # => [2]    
# p lucas_sequence(2)   # => [2, 1]
# p lucas_sequence(3)   # => [2, 1, 3]
# p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
# p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]

def prime_factorization(num)
    return [num] if prime(num)
    result = Array.new(0)
    (2...num).each do |i|
        if num % i == 0 && prime(i)
            return result += [i] + prime_factorization(num/i)
        end   
    end
end

# # Examples
# p prime_factorization(12)     # => [2, 2, 3]
# p prime_factorization(24)     # => [2, 2, 2, 3]
# p prime_factorization(25)     # => [5, 5]
# p prime_factorization(60)     # => [2, 2, 3, 5]
# p prime_factorization(7)      # => [7]
# p prime_factorization(11)     # => [11]
# p prime_factorization(2017)   # => [2017]