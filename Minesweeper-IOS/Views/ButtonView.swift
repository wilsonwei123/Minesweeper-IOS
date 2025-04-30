//
//  BlueButtonView.swift
//  Minesweeper-IOS
//
//  Created by Wilson Wei on 28/04/2025.
//

import SwiftUI

struct ButtonView: View {
    let text: String
    var body: some View {
        HStack {
            Text(text)
                .bold()
                .padding(14)
                .multilineTextAlignment(.center)
        }
    }
}
