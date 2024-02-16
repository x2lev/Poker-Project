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
    init(suit: String, value: String) {
        self.suit = suitInit
        self.value = valueInit
        self.num_value = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"].firstIndex(of: value) ?? 0
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.num_value == rhs.num_value
    }
    static func <(lhs: Card, rhs: Card) -> Bool{
        return lhs.num_value < rhs.num_value
    }
}

class Hand {self.cards = list(sorted(cards))
    var cards: Array<Card>
    var card_freq: Dictionary<int, int>
    var hand_type: String
    var hand_num: Int
    var high_cards: Array<Card>
     init(self, *cards: Card) {
        self.cards = list(sorted(cards))
        self.card_freq = self.__card_freq()
        self.hand_type = 'High Card'
        self.hand_num = 0
        self.high_cards = self.cards
}
        if high_cards := self.four_of_a_kind(){
            self.hand_type = 'Four of a Kind'
            self.hand_num = 7
            self.high_cards = high_cards
        }else if high_cards := self.full_house(){
            self.hand_type = 'Full House'
            self.hand_num = 6
            self.high_cards = high_cards
        }else if high_cards := self.three_of_a_kind(){
            self.hand_type = 'Three of a Kind'
            self.hand_num = 3
            self.high_cards = high_cards
        }else if high_cards := self.two_pair(){
            self.hand_type = 'Two Pair'
            self.hand_num = 2
            self.high_cards = high_cards
        }else if high_cards := self.one_pair(){
            self.hand_type = 'One Pair'
            self.hand_num = 1
            self.high_cards = high_cards
        }else{
            high_flush = self.flush()
            high_straight = self.straight()
            if high_flush and high_straight{
                self.hand_type = "Royal Flush" if high_straight[0].value == "A" else "Straight Flush"
                self.hand_num = 8
                self.high_cards = high_straight
            }else if high_flush{
                self.hand_type = "Flush"
                self.hand_num = 5
                self.high_cards = high_flush
            }else if high_straight{
                self.hand_type = "Straight"
                self.hand_num = 4
                self.high_cards = high_straight
                
            }
}
    def __lt__(self, other):
        if self.hand_num == other.hand_num:
            for s, o in zip(self.high_cards, other.high_cards):
                if s != o:
                    return s < o
        return self.hand_num < other.hand_num

    def __str__(self):
        return ", ".join([x.__str__() for x in self.cards])

    def __card_freq(self):
        cards = {}
        for card in sorted(self.cards):
            if card.num_value not in cards:
                cards[card.num_value] = 1
            else:
                cards[card.num_value] += 1
        return cards

    def __get_key(self, find: int) -> [int]:
        return [k for k, v in self.card_freq.items() if v == find]

    def flush(self):
        suit = self.cards[0].suit
        for card in self.cards[1:]:
            if card.suit != suit:
                return []
        return self.cards

    def straight(self):
        cards = self.cards.copy()
        last_card = cards.pop(0)
        for card in cards:
            if card.num_value != last_card.num_value + 1:
                return None
            last_card = card
        return [last_card]

    def four_of_a_kind(self) -> list | None:
        if sorted(self.card_freq.values()) == [1, 4]:
            return self.__get_key(4) + self.__get_key(1)
        return None

    def full_house(self) -> list | None:
        if sorted(self.card_freq.values()) == [2, 3]:
            return self.__get_key(4) + self.__get_key(1)
        return None

    def three_of_a_kind(self) -> list | None:
        if sorted(self.card_freq.values()) == [1, 1, 3]:
            return self.__get_key(4) + self.__get_key(1)
        return None

    def two_pair(self) -> list | None:
        if sorted(self.card_freq.values()) == [1, 2, 2]:
            return self.__get_key(2) + self.__get_key(1)
        return None

    def one_pair(self) -> list | None:
        if sorted(self.card_freq.values()) == [1, 1, 1, 2]:
            return self.__get_key(2) + self.__get_key(1)
        return None
}

