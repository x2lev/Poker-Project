//
//  PokerObjects.swift
//  Gambling
//
//  Created by Kryvenko, Lev on 2/16/24.
//

import Foundation

class Card: Comparable {
    var suit: String
    var value: String
    var num_value: Int
    init(suitInit: String, valueInit: String) {
        suit = suitInit
        value = valueInit
        num_value = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"].firstIndex(of: valueInit) ?? 0
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.num_value == rhs.num_value
    }
    static func < (lhs: Card, rhs: Card) -> Bool{
        return lhs.num_value < rhs.num_value
    }
}

class Hand: Comparable {
    var cards: [Card]
    var card_freq: Dictionary<Int, Int>
    var hand_type: String
    var hand_num: Int
    var high_cards: [Card]
    init(cards: Card...) {
        cards = cards.sorted()
        card_freq = card_freq()
        hand_type = "High Card"
        hand_num = 0
        high_cards = cards
        if four_of_a_kind(){
            hand_type = "Four of a Kind"
            hand_num = 7
            high_cards = four_of_a_kind()
        } else if full_house(){
            hand_type = "Full House"
            hand_num = 6
            high_cards = full_house()
        } else if three_of_a_kind(){
            hand_type = "Three of a Kind"
            hand_num = 3
            high_cards = three_of_a_kind()
        } else if two_pair(){
            hand_type = "Two Pair"
            hand_num = 2
            high_cards = two_pair()
        } else if one_pair(){
            hand_type = "One Pair"
            hand_num = 1
            high_cards = one_pair()
        } else{
            high_flush = flush()
            high_straight = straight()
            if high_flush && high_straight{
                hand_type = high_straight[0].value == "A" ? "Royal Flush" : "Straight Flush"
                hand_num = 8
                high_cards = high_straight
            } else if high_flush{
                hand_type = "Flush"
                hand_num = 5
                high_cards = high_flush
            } else if high_straight{
                hand_type = "Straight"
                hand_num = 4
                high_cards = high_straight
            }
        }
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.hand_num == rhs.hand_num && lhs.high_cards == rhs.high_cards
    }
    static func < (lhs: Card, rhs: Card) -> Bool{
        if lhs.hand_num == rhs.hand_num {
            for (s, o) in zip(high_cards, other.high_cards) {
                if s != o {
                    return s < o
                }
            }
        }
        return lhs.hand_num < rhs.hand_num
    }

    func card_freq(){
        cards
        for card in cards.sorted(){
            if !cards.contains(card.num_value){
                cards[card.num_value] = 1
            } else {
                cards[card.num_value] += 1
            }
        }
        return cards
    }
    func get_keys(find: Int) -> [Int] {
        var found: [Int] = []
        for (k, v) in card_freq {
            if v == find {
                found.append(k)
            }
        }
        return found
    }
    func flush(){
        suit = cards[0].suit
        var vals: [Int] = []
        for card in cards[0...] {
            vals.append(card.num_value)
            if card.suit != suit {
                return nil
            }
        }
        return vals
    }
    func straight() -> [Card] {
        var cards = cards.copy()
        last_card = cards.popFirst()
        for card in cards {
            if card.num_value != last_card.num_value + 1{
                return []
            }
            last_card = card
        }
        return [last_card]
    }
    func four_of_a_kind() -> [Card] {
        if card_freq.values().sorted() == [1, 4] {
            return get_keys(4) + get_keys(1)
        }
        return nil
    }
    func full_house() -> [Card] {
        if card_freq.values().sorted() == [2, 3] {
            return get_keys(3) + get_keys(2)
        }
        return nil
    }
    func three_of_a_kind() -> [Card] {
        if card_freq.values().sorted() == [1, 1, 3] {
            return get_keys(3) + get_keys(1)
        }
        return nil
    }
    func two_pair() -> [Card] {
        if card_freq.values().sorted() == [1, 2, 2] {
            return get_keys(2) + get_keys(1)
        }
        return nil
    }
    func one_pair() -> [Card] {
        if card_freq.values().sorted() == [1, 1, 1, 2] {
            return get_keys(2) + get_keys(1)
        }
        return nil
    }
}

