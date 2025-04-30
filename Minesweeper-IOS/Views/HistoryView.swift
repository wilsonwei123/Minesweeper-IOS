//
//  HistoryView.swift
//  Minesweeper-IOS
//
//  Created by Wilson Wei on 30/04/2025.
//

import SwiftUI

struct HistoryView: View {
    @State var historyM = HistoryModel()
    var body: some View {
        ScrollView {
            List() {
                ForEach(historyM.games) { game in
                    Button(action: {
                        
                    }, label: {
                        Text("\(game.gameWin ? "Win" : "Lose")")
                    })
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
        }
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: 375)
    }
}

#Preview {
    HistoryView()
}
