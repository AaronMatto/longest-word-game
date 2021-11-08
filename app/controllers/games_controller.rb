require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    alphabet = ('A'..'Z').to_a
    @letters = []
    10.times do
      index = rand(25)
      @letters << alphabet[index]
    end
  end

  def score
    @user_word = params[:word]
    @result = ""
    @letters = params[:game_letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@user_word}"
    word_serialized = URI.open(url).read
    words = JSON.parse(word_serialized)


    @user_word_array = @user_word.upcase.split("")


    attempt_letter_count = @user_word_array.each.all? do |letter|
      @user_word_array.count(letter) <= @letters.split(" ").count(letter)
    end

    if words["found"] == true && attempt_letter_count
      @result = "win win win lol lol lol"
    else
      @result = "you lose! Try again"
    end

  end

end
