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
    public var cardFreq: Dictionary<Int, Int>
    public var handType: String
    public var handNum: Int
    public var highCards: [Int]
    init() {
        cards = [Card(), Card(), Card(), Card(), Card()]
        cardFreq = [:]
        handType = ""
        handNum = 0
        highCards = []
    }
    init(_ cardsInit: [Card]) {
        cards = cardsInit
        handType = "High Card"
        handNum = 0
        highCards = []
        for card in cardsInit.sorted(){
            highCards.append(card.numValue)
        }
        cardFreq = [:]
        cardFreq = getCardFreq()
        if fourOfAKind() != [] {
            handType = "Four of a Kind"
            handNum = 7
            highCards = fourOfAKind()
        } else if fullHouse() != [] {
            handType = "Full House"
            handNum = 6
            highCards = fullHouse()
        } else if threeOfAKind() != [] {
            handType = "Three of a Kind"
            handNum = 3
            highCards = threeOfAKind()
        } else if twoPair() != [] {
            handType = "Two Pair"
            handNum = 2
            highCards = twoPair()
        } else if onePair() != [] {
            handType = "One Pair"
            handNum = 1
            highCards = onePair()
        } else {
            let highFlush = flush()
            let highStraight = straight()
            if highFlush != [] && highStraight != [] {
                handType = highStraight[0] == 12 ? "Royal Flush" : "Straight Flush"
                handNum = 8
                highCards = highStraight
            } else if highFlush != [] {
                handType = "Flush"
                handNum = 5
                highCards = highFlush
            } else if highStraight != [] {
                handType = "Straight"
                handNum = 4
                highCards = highStraight
            }
        }
    }
    static func == (lhs: Hand, rhs: Hand) -> Bool {
        return lhs.handNum == rhs.handNum && lhs.highCards == rhs.highCards
    }
    static func < (lhs: Hand, rhs: Hand) -> Bool{
        if lhs.handNum == rhs.handNum {
            for (s, o) in zip(lhs.highCards, rhs.highCards) {
                if s != o {
                    return s < o
                }
            }
        }
        return lhs.handNum < rhs.handNum
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
        for (k, v) in cardFreq {
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
        var lastCard = cards.sorted().last!
        let high = lastCard.numValue
        for card in cards.sorted() {
            if card.numValue != lastCard.numValue - 1 {
                return []
            }
            lastCard = card
        }
        return [high]
    }
    func fourOfAKind() -> [Int] {
        if cardFreq.values.sorted() == [1, 4] {
            return getKeys(4)
        }
        return []
    }
    func fullHouse() -> [Int] {
        if cardFreq.values.sorted() == [2, 3] {
            return getKeys(3)
        }
        return []
    }
    func threeOfAKind() -> [Int] {
        if cardFreq.values.sorted() == [1, 1, 3] {
            return getKeys(3)
        }
        return []
    }
    func twoPair() -> [Int] {
        if cardFreq.values.sorted() == [1, 2, 2] {
            return getKeys(2) + getKeys(1)
        }
        return []
    }
    func onePair() -> [Int] {
        if cardFreq.values.sorted() == [1, 1, 1, 2] {
            return getKeys(2) + getKeys(1)
        }
        return []
    }
}

