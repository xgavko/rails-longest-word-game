require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = []
    10.times do @letters << ('a'..'z').to_a[rand(26)]
    end
  end

  def score
    answer = params[:answer].strip
    letters = params[:letters]
    score_check = []
    answer.each_char do |c|
      letters.include?(c) ? score_check << 1 : score_check << 0
    end
    @score = score_check.reduce(:*) * answer.length
    if @score > 0
      dictionnary_check(answer)
    elsif @result = "Letters not in the original grid"
    end
  end

  def dictionnary_check(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    uri = open(url).read
    response = JSON.parse(uri)
      if response["found"] == true
        @result = "Your score is #{@score}"
      elsif
        @result = response["error"]
    end
  end

end
# The word can't be built out of the original grid
# The word is valid according to the grid, but is not a valid English word
# The word is valid according to the grid and is an English word
