class PokersController < ApplicationController

  def index
    @info = HTTParty.post('https://services.comparaonline.com/dealer/deck',:headers =>{'Content-Type' => 'application/json'} )
    @mano1 = [
        {
            "number": "7",
            "suit": "diamonds"
        },
        {
            "number": "5",
            "suit": "hearts"
        },
        {
            "number": "5",
            "suit": "clubs"
        },
        {
            "number": "6",
            "suit": "hearts"
        },
        {
            "number": "3",
            "suit": "clubs"
        }
    ]
    @mano2 = [
        {
            "number": "2",
            "suit": "diamonds"
        },
        {
            "number": "3",
            "suit": "diamonds"
        },
        {
            "number": "4",
            "suit": "diamonds"
        },
        {
            "number": "5",
            "suit": "diamonds"
        },
        {
            "number": "6",
            "suit": "diamonds"
        }
    ]
    puts direct(@mano2)
    puts "============"

  end
end
