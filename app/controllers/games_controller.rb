require 'open-uri'
require 'json'

class GamesController < ApplicationController


  def new
     @letters = []
    (1..10).each { @letters << ("A".."Z").to_a.sample(1) }
  end

  def score
    @letters = params[:grid].split(" ")
    @word = params[:word].upcase.split("")
    @url = "https://wagon-dictionary.herokuapp.com/#{@word.join}"
    @word_serialized = open(@url).read
    @checking = JSON.parse(@word_serialized)
    @print_grid = @letters.join(", ")
    if @checking["found"] == false
      @test = "Do you speak english you fool ? <strong>#{@word.join.capitalize!}</strong> is not English! "
    elsif
      @word.all? { |letter| @word.count(letter) <= @letters.count(letter) }
      @test = "Bien joué ! #{@word.join.capitalize!} is <strong> #{@word.length} </strong> caracters long."
    else
      @test = "<strong>#{@word.join.capitalize!}</strong> is not in the grid bro!"
    end
  end
end
