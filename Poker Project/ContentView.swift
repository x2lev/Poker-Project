//
//  ContentView.swift
//  Gambling
//
//  Created by Kryvenko, Lev on 2/12/24.
//

import SwiftUI

struct ContentView: View {
    @State var deck: [Card] = []
    
    @State var playerHand = Hand()
    @State var oppHand = Hand()
    @State var oppCards = ["cardBack_red2", "cardBack_red2", "cardBack_red2", "cardBack_red2", "cardBack_red2"]
    @State var won = false
    @State var roundEnded = false
    @State var toggles = [false, false, false, false, false]
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("PokerTable"))
                .ignoresSafeArea()
            
            VStack {
                Text("Five Card Draw Poker!")
                    .font(.title)
                
                Spacer()
                Text("Opponent's Hand:")
                HStack {
                    Image(oppCards[0])
                        .resizable()
                        .scaledToFit()
                    Image(oppCards[1])
                        .resizable()
                        .scaledToFit()
                    Image(oppCards[2])
                        .resizable()
                        .scaledToFit()
                    Image(oppCards[3])
                        .resizable()
                        .scaledToFit()
                    Image(oppCards[4])
                        .resizable()
                        .scaledToFit()
                }.padding(.horizontal, 10)
                Spacer()
                Text("Your Hand:")
                HStack {
                    VStack {
                        Image(playerHand.cards[0].toString())
                            .resizable()
                            .scaledToFit()
                        
                        Toggle("", isOn: $toggles[0])
                            .labelsHidden()
                    }
                    VStack {
                        Image(playerHand.cards[1].toString())
                            .resizable()
                            .scaledToFit()
                        
                        Toggle("", isOn: $toggles[1])
                            .labelsHidden()
                    }
                    VStack {
                        Image(playerHand.cards[2].toString())
                            .resizable()
                            .scaledToFit()
                        
                        Toggle("", isOn: $toggles[2])
                            .labelsHidden()
                    }
                    VStack {
                        Image(playerHand.cards[3].toString())
                            .resizable()
                            .scaledToFit()
                        
                        Toggle("", isOn: $toggles[3])
                            .labelsHidden()
                    }
                    VStack {
                        Image(playerHand.cards[4].toString())
                            .resizable()
                            .scaledToFit()
                        
                        Toggle("", isOn: $toggles[4])
                            .labelsHidden()
                    }
                }.padding(.horizontal, 10)
                Group {
                    Spacer()
                    Text("You \(won ? "won" : "lost") 🤯")
                    Spacer()
                }
                HStack {
                    Button("Draw") {
                        draw()
                    }
                    .frame(width: 100, height: 30)
                    .background(Color("PokerRed"))
                    .cornerRadius(10)
                    
                    Button("Restart") {
                        startGame()
                    }
                    .frame(width: 100, height: 30)
                    .background(Color("PokerRed"))
                    .cornerRadius(10)
                }
            }
            .foregroundColor(.white)
        }
        .onAppear(perform: startGame)
    }
    
    func startGame() {
        oppCards = ["cardBack_red2", "cardBack_red2", "cardBack_red2", "cardBack_red2", "cardBack_red2"]
        toggles = [false, false, false, false, false]
        let suits = ["Hearts", "Diamonds", "Spades", "Clubs"]
        let values: [String] = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
        for suit in suits {
            for value in values {
                deck.append(Card(suit, value))
            }
        }
        deck.shuffle()
        var playerTemp: [Card] = []
        var oppTemp: [Card] = []
        for _ in 1...5 {
            playerTemp.append(deck.popLast()!)
            oppTemp.append(deck.popLast()!)
        }
        playerHand = Hand(playerTemp)
        oppHand = Hand(oppTemp)
    }
    
    func draw() {
        let suits = ["Hearts", "Diamonds", "Spades", "Clubs"]
        let values: [String] = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
        for suit in suits {
            for value in values {
                deck.append(Card(suit, value))
            }
        }
        deck.shuffle()
        var playerTemp: [Card] = playerHand.cards
        for i in 0...4 {
            if !toggles[i] {
                playerTemp[i] = deck.popLast()!
            }
        }
        playerHand = Hand(playerTemp)
        
        for i in 0...4 {
            oppCards[i] = oppHand.cards[i].toString()
        }
        
        won = oppHand < playerHand 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
