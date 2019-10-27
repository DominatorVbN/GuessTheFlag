//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by dominator on 27/10/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctCountryIndex = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var varshowingScore = false
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue,.black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
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
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .overlay(RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 1))
                            .shadow(color: Color.black, radius: 2)
                    }
                    
                }
                
                Spacer()
            }
        }.alert(isPresented: $varshowingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is ???"), dismissButton: .default(Text("Continue"), action: {
                self.askQuestion()
            }))
        }
    }
    
    func flagSelected(_ number: Int){
        if number == correctCountryIndex{
            self.scoreTitle = "Correct"
        }else{
            self.scoreTitle = "Worng"
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
