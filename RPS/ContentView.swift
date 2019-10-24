//
//  ContentView.swift
//  RPS
//
//  Created by Michele Galvagno on 24/10/2019.
//  Copyright © 2019 Michele Galvagno. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var moves = ["Rock", "Paper", "Scissor"]
    var movesEmojis = ["👊🏻", "🖐🏻", "✌🏻"]
    
    @State private var score = 0
    
    @State private var appsChoice = Int.random(in: 0...2)
    @State private var playersChoice = 0
    
    @State private var shouldWin = Bool.random()
    
    @State private var result = ""
    
    @State private var roundsPlayed = 0 {
        didSet {
            if roundsPlayed == 10 {
                isGameOver = true
            }
        }
    }
    
    @State private var isGameOver = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Score: \(score) / \(roundsPlayed)")
                    .font(.headline)
                
                Spacer()
                
                Text(movesEmojis[appsChoice])
                    .font(.system(size: 110))
                    .padding(.bottom)
                
                Text(shouldWin ? "Win against \(moves[appsChoice])" : "Lose against \(moves[appsChoice])")
                    .padding()
                
                HStack {
                    Button("👊") {
                        self.play(with: 0)
                    }.font(.system(size: 100))

                    Button("🖐") {
                        self.play(with: 1)
                    }.font(.system(size: 100))

                    Button("✌️") {
                        self.play(with: 2)
                    }.font(.system(size: 100))
                }.padding()
                
                Text("\(result)")
                
                Spacer()
            }
            .navigationBarTitle("Rock, Paper, Scissors!")
        }
        .environment(\.horizontalSizeClass, .compact)
        .alert(isPresented: $isGameOver) { () -> Alert in
            Alert(title: Text("Game Over"), message: Text("Your score is \(score)/10!"), dismissButton: .default(Text("New Game"), action: {
                self.restartGame()
            }))
        }
    }
    
    private func play(with playersChoice: Int) {
        self.playersChoice = playersChoice
        
        if shouldWin {
            if appsChoice != (playersChoice + 2) % 3 {
                result = "Wrong!"
                score -= 1
            } else {
                result = "Correct!"
                score += 1
            }
        } else {
            if appsChoice != (playersChoice + 1) % 3 {
                result = "Wrong!"
                score -= 1
            } else {
                result = "Correct!"
                score += 1
            }
        }
        
        roundsPlayed += 1
        appsChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    private func restartGame() {
        score = 0
        
        appsChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
        
        roundsPlayed = 0
        isGameOver = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
