//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by dominator on 27/10/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    @State private var countries = ["India","Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctCountryIndex = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var varshowingScore = false
    @State private var score = "0"
    @State private var errorMessage = ""
    @State private var animationAmount = 0.0
    @State private var opacityValue = 1.0
    @State private var selectedFlagIndex = 0
    @State private var wrongAttempes = 0
    
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
                    .modifier(Shake(animatableData: CGFloat(self.wrongAttempes)))
                    .animation(number == self.selectedFlagIndex ? Animation.default : nil)
                        
                    .opacity(self.opacityValue)
                    .animation(number == self.correctCountryIndex ? nil : Animation.default)
                        
                    .rotation3DEffect(.degrees(self.animationAmount), axis: (x: 0, y: number == self.correctCountryIndex ? 1 : 0, z: 0))
                    .animation(self.animationAmount != 0 ? Animation.default : nil)
                    .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown flag"]))
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
        self.selectedFlagIndex = number
        if number == correctCountryIndex{
            self.scoreTitle = "Correct"
            let currentScore = Int(score) ?? 0
            score = "\(currentScore+1)"
            errorMessage = ""
            animateCorrect()
        }else{
            self.scoreTitle = "Wrong"
            errorMessage = "Wrong! That’s the flag of \(countries[number])"
            animateInCorrect()
        }
        
        self.varshowingScore = true
    }
    
    func animateCorrect(){
        withAnimation{
            animationAmount = 360
        }
        animationAmount = 0
        opacityValue = 0.25
    }
    
    func animateInCorrect(){
        withAnimation(.default) {
            wrongAttempes += 1
        }
    }
    
    func askQuestion(){
        opacityValue = 1
        countries.shuffle()
        correctCountryIndex = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                                              y: 0))
    }
}

