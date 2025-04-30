//
//  GameOverView.swift
//  Minesweeper-IOS
//
//  Created by Wilson Wei on 28/04/2025.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var gameVM: GameViewModel
    let win: Bool
    var body: some View {
        VStack {
            if win {
                Image(systemName: "sparkles")
                    .font(.system(size: 40))
                Text("You win!")
                    .font(.title)
                    .padding()
            } else {
                Image(systemName: "burst.fill")
                    .font(.system(size: 40))
                Text("Game over")
                    .font(.title)
                    .padding()
            }
            NavigationLink(destination: FinishedGridView(game: gameVM), label: {
                ButtonView(text: "View results")
                    .background(Color.cyan)
                    .cornerRadius(10)
            })
            NavigationLink(destination: BeginView(), label: {
                ButtonView(text: "Play again")
                    .background(Color.cyan)
                    .cornerRadius(10)
                    .padding()
            })
        }
        .navigationBarBackButtonHidden(true)
        .foregroundStyle(.black)
    }
}

