//
//  PokerObjects.swift
//  Gambling
//
//  Created by Kryvenko, Lev on 2/16/24.
//

import Foundation

class Card: Comparable {
    public var suit: String
    public var value: String
    public var numValue: Int
    init() {
        suit = "Spades"
        value = "A"
        numValue = 12
    }
    init(_ suitInit: String, _ valueInit: String) {
        suit = suitInit
        value = valueInit
        numValue = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"].firstIndex(of: valueInit)!
    }
    public static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.numValue == rhs.numValue
    }
    public static func < (lhs: Card, rhs: Card) -> Bool{
        return lhs.numValue < rhs.numValue
    }
    public func toString() -> String{
        return "card\(suit)\(value)"
    }
}

class Hand: Comparable {
    public var cards: [Card]
    public var card_freq: Dictionary<Int, Int>
    public var hand_type: String
    public var hand_num: Int
    public var high_cards: [Int]
    init() {
        cards = [Card(), Card(), Card(), Card(), Card()]
        card_freq = [:]
        hand_type = ""
        hand_num = 0
        high_cards = []
        // hi
    }
    init(_ cardsInit: [Card]) {
        cards = cardsInit.sorted()
        hand_type = "High Card"
        hand_num = 0
        high_cards = []
        for card in cards {
            high_cards.append(card.numValue)
        }
        card_freq = [:]
        card_freq = getCardFreq()
        if four_of_a_kind() != [] {
            hand_type = "Four of a Kind"
            hand_num = 7
            high_cards = four_of_a_kind()
        } else if full_house() != [] {
            hand_type = "Full House"
            hand_num = 6
            high_cards = full_house()
        } else if three_of_a_kind() != [] {
            hand_type = "Three of a Kind"
            hand_num = 3
            high_cards = three_of_a_kind()
        } else if two_pair() != [] {
            hand_type = "Two Pair"
            hand_num = 2
            high_cards = two_pair()
        } else if one_pair() != [] {
            hand_type = "One Pair"
            hand_num = 1
            high_cards = one_pair()
        } else {
            let high_flush = flush()
            let high_straight = straight()
            if high_flush != [] && high_straight != [] {
                hand_type = high_straight[0] == 12 ? "Royal Flush" : "Straight Flush"
                hand_num = 8
                high_cards = high_straight
            } else if high_flush != [] {
                hand_type = "Flush"
                hand_num = 5
                high_cards = high_flush
            } else if high_straight != [] {
                hand_type = "Straight"
                hand_num = 4
                high_cards = high_straight
            }
        }
    }
    static func == (lhs: Hand, rhs: Hand) -> Bool {
        return lhs.hand_num == rhs.hand_num && lhs.high_cards == rhs.high_cards
    }
    static func < (lhs: Hand, rhs: Hand) -> Bool{
        if lhs.hand_num == rhs.hand_num {
            for (s, o) in zip(lhs.high_cards, rhs.high_cards) {
                if s != o {
                    return s < o
                }
            }
        }
        return lhs.hand_num < rhs.hand_num
    }

    func getCardFreq() -> Dictionary<Int, Int> {
        var cardDict: Dictionary<Int, Int> = [:]
        for card in cards.sorted(){
            if cardDict.keys.contains(card.numValue) {
                cardDict[card.numValue]! += 1
            } else {
                cardDict[card.numValue] = 1
            }
        }
        return cardDict
    }
    func getKeys(_ find: Int) -> [Int] {
        var found: [Int] = []
        for (k, v) in card_freq {
            if v == find {
                found.append(k)
            }
        }
        return found
    }
    func flush() -> [Int] {
        let suit = cards[0].suit
        var vals: [Int] = []
        for card in cards[0...] {
            vals.append(card.numValue)
            if card.suit != suit {
                return []
            }
        }
        return vals
    }
    func straight() -> [Int] {
        var tempCards: [Card] = []
        for c in 0..<cards.count {
            tempCards[c] = cards[c]
        }
        let highCard = tempCards.last!
        var lastCard = tempCards.popLast()!
        for card in cards {
            if card.numValue != lastCard.numValue - 1 {
                return []
            }
            lastCard = card
        }
        return [highCard.numValue]
    }
    func four_of_a_kind() -> [Int] {
        if card_freq.values.sorted() == [1, 4] {
            return getKeys(4)
        }
        return []
    }
    func full_house() -> [Int] {
        if card_freq.values.sorted() == [2, 3] {
            return getKeys(3)
        }
        return []
    }
    func three_of_a_kind() -> [Int] {
        if card_freq.values.sorted() == [1, 1, 3] {
            return getKeys(3)
        }
        return []
    }
    func two_pair() -> [Int] {
        if card_freq.values.sorted() == [1, 2, 2] {
            return getKeys(2) + getKeys(1)
        }
        return []
    }
    func one_pair() -> [Int] {
        if card_freq.values.sorted() == [1, 1, 1, 2] {
            return getKeys(2) + getKeys(1)
        }
        return []
    }
}

