class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # GETTER and SETTER Methods

  def word
    @word
  end

  def word=(value)
    if value.empty?
      raise ArgumentError.new("Word cannot be empty")
    else
      @word = value
    end
  end

  def guesses
    @guesses
  end

  def guesses=(list)
    if list.empty?
      raise ArgumentError.new("Guesses cannot be empty")
    else
      @guesses = list
    end
  end

  def wrong_guesses
    @wrong_guesses
  end

  def wrong_guesses=(list)
    if list.empty?
      raise ArgumentError.new("Wrong guesses cannot be empty")
    else
      @wrong_guesses = list
    end
  end


  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end


  def guess(letter)
    if word.include?(letter.downcase())
      insert_helper(letter, guesses)
    else
      insert_helper(letter, wrong_guesses)
    end
  end

  # This is a helper function that checks whether the current letter is already included in the string
  # If not, it includes the letter into the list
  # Note: This function is Case INSensitive
  def insert_helper(letter, list)
    unless list.include?(letter.downcase())
      list << letter
    else
      return false
    end
  end

  def guess_several_letters(string)
    string.each do |x|
      guess(x)
    end
  end
end
