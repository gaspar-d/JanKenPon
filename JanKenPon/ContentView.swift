//
//  ContentView.swift
//  JanKenPon
//
//  Created by Diogo Gaspar on 23/02/21.
//

import SwiftUI

struct ContentView: View {
    @State var userHand = ["Rock", "Paper", "Scissor"]
    @State var defaultHand = 1
    
    @State var cpuHands = ["Rock", "Paper", "Scissor"].shuffled()
    @State var cpuHand = Int.random(in: 0 ... 2)
    
    @State var popUp = false
    
    @State var countingHands = 0
    @State var score = 0
    
//    MARK: call the popup alert and shuffle hands again
    func showAlert() {
        popUp = true
        cpuHands.shuffle()
    }
    
    func counters() {
        countingHands += 1
        
        if handVsHand == "Won" {
            score += 1
        } else if handVsHand == "Lose" {
            score -= 1
        }
    }
    
//    MARK: get the hand chosen by the player
    var handChosen: String {
        switch defaultHand {
        case 0:
            return "Rock"
        case 1:
            return "Paper"
        case 2:
            return "Scissor"
        default:
            return "Opa"
        }
    }
    
    var cpuChosen: String {
        switch cpuHands[cpuHand] {
        case "Rock":
            return "Pedra"
        case "Paper":
            return "Papel"
        case "Scissor":
            return "Tesoura"
        default:
            return "Opa"
        }
    }
    
    var handVsHand: String {
        let cpuChosenHand = cpuHands[cpuHand]
        
        if handChosen == "Rock" {
            switch handChosen == "Rock" {
            case cpuChosenHand == "Rock":
                return "Draw"
            case cpuChosenHand == "Paper":
                return "Lose"
            case cpuChosenHand == "Scissor":
                return "Won"
            default:
                return "Opa1"
            }
        } else if handChosen == "Paper" {
            switch handChosen == "Paper" {
            case cpuChosenHand == "Rock":
                return "Won"
            case cpuChosenHand == "Paper":
                return "Draw"
            case cpuChosenHand == "Scissor":
                return "Lose"
            default:
                return "Opa2"
            }
        } else if handChosen == "Scissor" {
            switch handChosen == "Scissor" {
            case cpuChosenHand == "Rock":
                return "Lose"
            case cpuChosenHand == "Paper":
                return "Won"
            case cpuChosenHand == "Scissor":
                return "Draw"
            default:
                return "Opa3"
            }
        }
        
        return "Some Error"
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    
                    // MARK: Show CPU hand
                    Section(header: Text("Show CPU hand").textCase(nil) ) {
                        Text("\(cpuHands[cpuHand])")
                    }
                    
                    // MARK: Button to play, maybe put a image to click in
                    Section(header: Text("Press to Play").textCase(nil) ) {
                        Button(action: {
                            showAlert()
                        }) {
                            Text("\(handChosen)")
                                .frame(width: 340, alignment: .center)
                        }
                    }
                    
                    // MARK: Here the user choose his hand for this round
                    Section(header: Text("Choose your hand")
                                .textCase(nil)) {
                        Picker("janKenPon user selector", selection: $defaultHand) {
                            ForEach(0 ..< userHand.count) {
                                Text("\(userHand[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    // MARK: Show the score and probably will use to count 10 rounds and show who won
                    Section {
//                            Text("Counter \(countingHands)")
                        Text("Score \(score)")
                    }
                }
            }
            .navigationBarTitle(Text("JanKenPon"))
        }
        // MARK: The alert popup saying who won the round and with the continue button
        .alert(isPresented: $popUp) {
            countingHands < 10 ?  Alert(title: Text("\(handVsHand)"), message:
                    Text("\(handChosen) \(handVsHand) VS \(cpuHands[cpuHand])"), dismissButton: .default(Text("Continue")) {
                        counters()
                    }) : Alert(title: Text("Acabou"), message: Text("Fim"), dismissButton: .default(Text("Terminado")) {
                        countingHands = 0
                        score = 0
                    } )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
