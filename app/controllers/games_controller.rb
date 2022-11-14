require 'net/http'
require 'json'


class GamesController < ApplicationController
  def new
    @letters = 10.times.map { rand(65..90).chr }
  end

  def score
    uri = URI("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    response = Net::HTTP.get(uri)
    json = JSON.parse(response)
    word_split = params[:word].upcase.split('')
    letters_split = params[:letters].gsub(' ', '')
    array_check = []
    word_split.each { |c| array_check << letters_split.slice!(c) }
    if array_check == word_split
      if json["found"] == true
        @result = "Congratulations!! #{word_split.join} is a valid English word"
      else
        @result = "Sorry but #{word_split.join} doesnt seem to be a valid English word..."
      end
    else
      @result = "Sorry but #{word_split.join} cant be built out of #{params[:letters]}"
    end
  end
end
