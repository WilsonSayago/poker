class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  $token = nil
  NUMBERS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  def pars(hand)
    number_par = []
    hand.each do |card|
      if hand.find_all {|c| c['number'] == card['number'] and c['suit'] != card['suit']}.size > 0
        if !number_par.include?(card['number'])
          number_par.push(card['number'])
        end
      end
    end
    return number_par
  end

  def three(hand)
    number_three = nil
    hand.each do |card|
      if hand.find_all {|c| c['number'] == card['number'] and c['suit'] != card['suit']}.size == 2
        number_three = card['number']
      end
    end
    return number_three
  end

  def direct(hand)
    hand_base = hand
    order = []
    hand_base.each do |card|
      order.push(NUMBERS.index(card['number']))
    end
    order.sort!
    index = order[0]
    if NUMBERS[order[1]]==NUMBERS[index+1] && NUMBERS[order[2]]==NUMBERS[index+2] && NUMBERS[order[3]]==NUMBERS[index+3] && NUMBERS[order[4]]==NUMBERS[index+4]
      return true
    else
      return false
    end
  end

  def flush(hand)
    if hand.find_all {|c| c['suit'] != hand[0]['suit']}.size > 0
      return false
    end
    return true
  end

  def full_house(hand)
    cards_three = three(hand)
    cards_par = pars(hand)
    cards_par.delete(cards_three)
    cards_three.present? && cards_par.present? ? true : false
  end

  def four_class(hand)
    #number_four = nil
    hand.each do |card|
      if hand.find_all {|c| c['number'] == card['number'] and c['suit'] != card['suit']}.size == 3
        #number_four = card['number']
        return true
      end
    end
    return false#number_four
  end

  def straight_flush(hand)
    order = []
    suit = hand[0]['suit']
    hand.each do |card|
      if suit != card['suit']
        return false
      end
      order.push(NUMBERS.index(card['number']))
    end
    order.sort!
    index = order[0]
    if NUMBERS[order[1]]==NUMBERS[index+1] && NUMBERS[order[2]]==NUMBERS[index+2] && NUMBERS[order[3]]==NUMBERS[index+3] && NUMBERS[order[4]]==NUMBERS[index+4]
      return true
    else
      return false
    end
  end

  def royal_flush(hand)
    order = []
    suit = hand[0]['suit']
    hand.each do |card|
      if suit != card['suit']
        return false
      end
      order.push(NUMBERS.index(card['number']))
    end
    order.sort!
    if NUMBERS[order[0]]==NUMBERS[8] && NUMBERS[order[1]]==NUMBERS[9] && NUMBERS[order[2]]==NUMBERS[10] && NUMBERS[order[3]]==NUMBERS[11] && NUMBERS[order[4]]==NUMBERS[12]
      return true
    else
      return false
    end
  end

  def qualification(hand)
    hand_base = hand
    if royal_flush(hand_base)
      return [10, "Royal Flush"]
    elsif straight_flush(hand_base)
      return [9, "Straight Flush"]
    elsif four_class(hand_base)
      return [8, "Four Class"]
    elsif full_house(hand_base)
      return [7, "Full House"]
    elsif flush(hand_base)
      return [6, "Flush"]
    elsif direct(hand_base)
      return [5, "Direct"]
    elsif three(hand).present?
      return [4, "Three"]
    elsif pars(hand).size > 1
      return [3, "Two Pars"]
    elsif pars(hand).size == 1
      return [2, "One Pars"]
    else
      return [0, "No have combinations"]
    end
  end

  def search_high_card(hand)
    order = []
    hand.each do |card|
      order.push(NUMBERS.index(card['number']))
    end
    order.sort!
    return [order[4], NUMBERS[order[4]]]
  end
end
