class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  NUMBERS = ['2', '3', '4', '5', '6', '7', '8', '9', 'diez', 'Jack', 'Queen', 'King', 'Ace']

  def pars(hands)
    number_par = []
    hands.each do |card|
      if hands.find_all {|c| c[:number] == card[:number] and c[:suit] != card[:suit]}.size > 0
        if !number_par.include?(card[:number])
          number_par.push(card[:number])
        end
      end
    end
    return number_par
  end

  def three(hands)
    number_three = nil
    hands.each do |card|
      if hands.find_all {|c| c[:number] == card[:number] and c[:suit] != card[:suit]}.size == 2
        number_three = card[:number]
      end
    end
    return number_three
  end

  def direct(hands)
    order = []
    hands.each do |card|
      order.push(NUMBERS.index(card[:number]))
    end
    order.sort!
    index = order[0]
    if NUMBERS[order[1]]==NUMBERS[index+1] && NUMBERS[order[2]]==NUMBERS[index+2] && NUMBERS[order[3]]==NUMBERS[index+3] && NUMBERS[order[4]]==NUMBERS[index+4]
      return true
    else
      return false
    end
  end

  def flush(hands)
    if hands.find_all {|c| c[:suit] != hands[0][:suit]}.size > 0
      return false
    end
    return true
  end

  def full_house(hands)
    cards_three = three(hands)
    cards_par = pars(hands)
    cards_par.delete(cards_three)
    cards_three.present? && cards_par.present? ? true : false
  end

  def four_class(hands)
    number_four = nil
    hands.each do |card|
      if hands.find_all {|c| c[:number] == card[:number] and c[:suit] != card[:suit]}.size == 3
        number_four = card[:number]
      end
    end
    return number_four
  end

  def straight_flush(hands)
    order = []
    suit = hands[0][:suit]
    hands.each do |card|
      if suit != card[:suit]
        return false
      end
      order.push(NUMBERS.index(card[:number]))
    end
    order.sort!
    index = order[0]
    if NUMBERS[order[1]]==NUMBERS[index+1] && NUMBERS[order[2]]==NUMBERS[index+2] && NUMBERS[order[3]]==NUMBERS[index+3] && NUMBERS[order[4]]==NUMBERS[index+4]
      return true
    else
      return false
    end
  end

  def royal_flush(hands)
    order = []
    suit = hands[0][:suit]
    hands.each do |card|
      if suit != card[:suit]
        return false
      end
      order.push(NUMBERS.index(card[:number]))
    end
    order.sort!
    if NUMBERS[order[0]]==NUMBERS[8] && NUMBERS[order[1]]==NUMBERS[9] && NUMBERS[order[2]]==NUMBERS[10] && NUMBERS[order[3]]==NUMBERS[11] && NUMBERS[order[4]]==NUMBERS[12]
      return true
    else
      return false
    end
  end
end
