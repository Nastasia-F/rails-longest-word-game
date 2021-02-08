class GamesController < ApplicationController
  def new
    # display a new random grid and a form
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @result = params[:result]
    @letters = params[:letters]
    if include_letters?(@result) && english_word?
      @message = 'Congratulation'
    elsif include_letters?(@result)
      @message = 'Not an english word'
    else
      @message = 'Not in the grid'
    end
  end

  def english_word?
    url = "https://wagon-dictionary.herokuapp.com/#{@result}"
    word = open(url).read
    words = JSON.parse(word)
    words[:found]
  end

  def include_letters?(input)
    input.upcase.split('').all? { |letter| @letters.include?(letter) }
  end
end
