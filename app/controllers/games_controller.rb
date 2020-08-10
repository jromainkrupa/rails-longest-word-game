require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...7).map { ('a'..'z').to_a[rand(26)] }
    return @letters
  end

  def score
    @word = params[:word].split("")
    @letters = params[:letters].split("")
    @result = 0
    @word.each do |letter|
      if @letters.include?(letter) && english?(params[:word])
        @result = "Congratulation !  #{params[:word].upcase} is a valid English word"
      elsif english?(params[:word]) != true
        @result = "Sorry but #{params[:word].upcase} doesn't seem to be a valid English word... "
      else
        @result = "Sorry but #{params[:word].upcase} can't be build out of #{params[:letters].upcase} "
      end
    end
  end

  def english?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
