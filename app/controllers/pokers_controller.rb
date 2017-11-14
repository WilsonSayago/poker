class PokersController < ApplicationController
  before_action :set_token

  def index
    hands = get_hand
    @mano1 = hands[0]
    @mano2 = hands[1]
    cal_hand_1 = qualification(@mano1)
    cal_hand_2 = qualification(@mano2)
    if cal_hand_1[0] > cal_hand_2[0]
      @message = "Winner hand one, with combination: " + cal_hand_1[1]
    elsif cal_hand_1[0] < cal_hand_2[0]
      @message = "Winner hand two, with combination: " + cal_hand_2[1]
    else
      high_1 = search_high_card(@mano1)
      high_2 = search_high_card(@mano2)
      if high_1[0] > high_2[0]
        @message = "Tie, winner hand one with high card #{high_1[1]}"
      elsif high_1[0] < high_2[0]
        @message = "Tie, winner hand two with high card #{high_2[1]}"
      else
        @message = "Tie"
      end
    end
  end

  def shuffle
    $token = nil
    set_token
    redirect_to root_path
  end

  private
    def set_token
      if !$token.present?
        begin
          response = HTTParty.post('https://services.comparaonline.com/dealer/deck',:headers =>{'Content-Type' => 'application/json'} )
          case response.code
            when 200
            $token = response
          end
        end until $token.present?
      end
    end

    def get_hand
      cant = 0
      hands = []
      begin
        response = HTTParty.get('https://services.comparaonline.com/dealer/deck/' + $token + '/deal/5',:headers =>{'Content-Type' => 'application/json'} )
        case response.code
          when 200
            cant += 1
            hands.push(response)
          when 404
            puts "No se encuentra el mazo o a caducado el tiempo de juego"
            $token = nil
            set_token
            cant = 0
          when 405
            puts "insuficientes cartas"
            $token = nil
            set_token
            cant = 0
          when 500
            puts "error 500"
        end
      end until cant==2
      return hands
    end
end
