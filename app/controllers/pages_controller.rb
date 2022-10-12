require 'open-uri'

class PagesController < ApplicationController
  def new
    $letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @word = params[:input]
    @response = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read

    @my_hash = JSON.parse(@response)
    @check = @my_hash['error']
    tester = []

    if @check == "word not found"
      @result = "Sorry but #{@word} can't be found"
    elsif @my_hash['found']
      @word.chars.each do |word|
        tester << $letters.include?(word)
      end
        if tester.include?(false)
          @result = "Sorry but #{@word} can't be built out of #{$letters.join(', ').upcase}"
        else
      @result = "Congrats, #{@word} is a English word"
    end
    end
  end
end
