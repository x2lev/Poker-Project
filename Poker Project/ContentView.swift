//
//  ContentView.swift
//  Gambling
//
//  Created by Kryvenko, Lev on 2/12/24.
//

import SwiftUI

struct ContentView: View {
    @State var deck: [Card] = []
    
    @State var playerHand: Hand = Hand()
    @State var oppHand: Hand = Hand()
    
    @State var playerImages = ["cardBack_red2", "cardBack_red2", "cardBack_red2", "cardBack_red2", "cardBack_red2"]
    
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
                    Image("cardBack_red2")
                        .resizable()
                        .scaledToFit()
                    Image("cardBack_red2")
                        .resizable()
                        .scaledToFit()
                    Image("cardBack_red2")
                        .resizable()
                        .scaledToFit()
                    Image("cardBack_red2")
                        .resizable()
                        .scaledToFit()
                    Image("cardBack_red2")
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
                        Image(playerImages[1])
                            .resizable()
                            .scaledToFit()
                        
                        Toggle("", isOn: $toggles[1])
                            .labelsHidden()
                    }
                    VStack {
                        Image(playerImages[2])
                            .resizable()
                            .scaledToFit()
                        
                        Toggle("", isOn: $toggles[2])
                            .labelsHidden()
                    }
                    VStack {
                        Image(playerImages[3])
                            .resizable()
                            .scaledToFit()
                        
                        Toggle("", isOn: $toggles[3])
                            .labelsHidden()
                    }
                    VStack {
                        Image(playerImages[4])
                            .resizable()
                            .scaledToFit()
                        
                        Toggle("", isOn: $toggles[4])
                            .labelsHidden()
                    }
                }.padding(.horizontal, 10)
                Spacer()
                Spacer()
                
                Button("Draw!") {
                    for t in toggles {
                        if !t {
                            print(t)
                        }
                    }
                }
                .frame(width: 100, height: 30)
                .background(Color("PokerRed"))
                .cornerRadius(10)
            }
            .foregroundColor(.white)
        }
        .onAppear(perform: startGame)
    }
    
    func startGame() {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
