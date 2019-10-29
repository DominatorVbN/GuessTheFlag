//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by dominator on 29/10/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    var name: String
    var body: some View {
        Image(name)
        .renderingMode(.original)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(Color.black, lineWidth: 1))
        .shadow(color: Color.black, radius: 2)
    }
    init(_ name: String) {
        self.name = name
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage("India")
    }
}
