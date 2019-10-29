//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by dominator on 27/10/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["India","Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctCountryIndex = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var varshowingScore = false
    @State private var score = "0"
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.orange,.white,.green]), startPoint: .topLeading, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30){
                VStack {
                    Text("Pick flag of country")
                        .foregroundColor(.white)
                    Text(countries[correctCountryIndex])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                }
                
                ForEach(0..<3){ number in
                    Button(action: {
                        self.flagSelected(number)
                    }){
                        FlagImage(self.countries[number])
                    }
                }
                
                Spacer()
            }
        }.alert(isPresented: $varshowingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score).\n\(errorMessage.isEmpty ? "" : errorMessage)."), dismissButton: .default(Text("Continue"), action: {
                self.askQuestion()
            }))
        }
    }
    
    func flagSelected(_ number: Int){
        if number == correctCountryIndex{
            self.scoreTitle = "Correct"
            let currentScore = Int(score) ?? 0
            score = "\(currentScore+1)"
            errorMessage = ""
        }else{
            self.scoreTitle = "Wrong"
            errorMessage = "Wrong! That’s the flag of \(countries[number])"
        }
        
        self.varshowingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctCountryIndex = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
