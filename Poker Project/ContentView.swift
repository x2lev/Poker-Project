//
//  ContentView.swift
//  Gambling
//
//  Created by Kryvenko, Lev on 2/12/24.
//

import SwiftUI

struct ContentView: View {
    @State var deck = [
        "HeartsA", "HeartsK", "HeartsQ", "HeartsJ", "Hearts10", "Hearts9", "Hearts10", "Hearts9",
        "Hearts8", "Hearts7", "Hearts6", "Hearts5", "Hearts4", "Hearts3", "Hearts2",
        "DiamondsA", "DiamondsK", "DiamondsQ", "DiamondsJ", "Diamonds10", "Diamonds9", "Diamonds10", "Diamonds9",
        "Diamonds8", "Diamonds7", "Diamonds6", "Diamonds5", "Diamonds4", "Diamonds3", "Diamonds2",
        "SpadesA", "SpadesK", "SpadesQ", "SpadesJ", "Spades10", "Spades9", "Spades10", "Spades9",
        "Spades8", "Spades7", "Spades6", "Spades5", "Spades4", "Spades3", "Spades2",
        "ClubsA", "ClubsK", "ClubsQ", "ClubsJ", "Clubs10", "Clubs9", "Clubs10", "Clubs9",
        "Clubs8", "Clubs7", "Clubs6", "Clubs5", "Clubs4", "Clubs3", "Clubs2"
    ].shuffled()
    
    @State var playerHand = ["cardHeartsA", "cardHeartsK", "cardHeartsQ", "cardHeartsJ", "cardHearts10"]
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
                        Image(playerHand[0])
                            .resizable()
                            .scaledToFit()
                        
                        Toggle("", isOn: $toggles[0])
                            .labelsHidden()
                    }
                    VStack {
                        Image(playerHand[1])
                            .resizable()
                            .scaledToFit()
                        
                        Toggle("", isOn: $toggles[1])
                            .labelsHidden()
                    }
                    VStack {
                        Image(playerHand[2])
                            .resizable()
                            .scaledToFit()
                        
                        Toggle("", isOn: $toggles[2])
                            .labelsHidden()
                    }
                    VStack {
                        Image(playerHand[3])
                            .resizable()
                            .scaledToFit()
                        
                        Toggle("", isOn: $toggles[3])
                            .labelsHidden()
                    }
                    VStack {
                        Image(playerHand[4])
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
