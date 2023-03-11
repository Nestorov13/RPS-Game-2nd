//
//  ContentView.swift
//  RPS-Game
//
//  Created by Borislav on 11.03.23.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var userChoice = ["🪨", "📜", "✂️"]
       // .shuffled()
        
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingAlert = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    @State private var numberTap = 0
    @State private var endGameAlert = false
    @State private var gameOver = ""
    
    func iconTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            currentScore += 50
            
        } else {
            scoreTitle = "Wrong, actually the answer is \(correctAnswer+1)"
            currentScore -= 45
        }
        showingScore = true
    }
    //This function randomizes the possible answers.
    func askQuestion() {
        userChoice.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    // This function is the Alert action after the game ends to reset the score.
    func restart(){
        endGameAlert = false
        numberTap = 0
        currentScore = 0
    }
    
    //This function is the Event on the last tap (8th tap) which shows
    //the Game over text and the finished score.
    
    func endGame(_ numberEnd: Int = 3) {
        if numberTap == numberEnd
        {
            endGameAlert = true
            gameOver = "Game Over, Score: \(currentScore)"
        }
    }
    var body: some View {
        ZStack{
            
            RadialGradient(stops: [
                .init(color: .green, location: 0.9),
                .init(color: .red, location: 0.9),
            ], center: .top, startRadius: 100, endRadius: 650)
                .blur(radius: 0)
          
            VStack(spacing: 4){
                
                Spacer()
                VStack{
                    Spacer()
                    Spacer()
                    // The info text at the top
                    Text("Chose wisely...")
                        .foregroundColor(.secondary)
                        .font(.system(size: 30))
                    
                 //   Text(userChoice[correctAnswer])
                //      .font(.largeTitle.weight(.semibold))
                    Text("Number of tries: \(numberTap)")
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    HStack {
                        
                        
                        
                        ForEach(0..<3) { number in
                            Button{
                                //Flag Tapped
                                iconTapped(number)
                                numberTap += 1
                                endGame()
                            }
                        label: {
                                Text(userChoice[number])
                                .font(.system(size: 100))
                                
                                
                                //.renderingMode(.original)
                                 //   .clipShape(Capsule().size(width: 400, height: 100))
                             .shadow(radius: 10)
                            }
                          
                            
                        }
                        
                        
                    }
                    
                               Spacer()
                }
        
                //This is the tap action button as the flag image.
     
            }
            
            
            
        }.ignoresSafeArea()
        // First alert after each tap
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(currentScore)")
            }
        
        
        // Game over alert
            .alert(gameOver, isPresented: $endGameAlert){
                Button("Restart", action: restart)
            } message: {
                Text("Try again!")
            }

    }
}
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
