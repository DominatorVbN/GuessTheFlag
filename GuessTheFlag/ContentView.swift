//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by dominator on 27/10/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    var correctCountryIndex = Int.random(in: 0...2)
    var body: some View {
        ZStack{
            Color.blue
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30){
                VStack {
                    Text("Pick flag of country")
                        .foregroundColor(.white)
                    Text(countries[correctCountryIndex])
                        .foregroundColor(.white)
                }
                
                ForEach(0..<3){ number in
                    Button(action: {
                        // do sometghingh
                    }){
                        Image(self.countries[number]).renderingMode(.original)
                    }
                    
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
