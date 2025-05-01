//
//  FinishedGridView.swift
//  Minesweeper-IOS
//
//  Created by Wilson Wei on 30/04/2025.
//

import SwiftUI

struct FinishedGridView: View {
    var game: GameViewModel
    var cellSize: Int
    init(game: GameViewModel) {
        self.game = game
        self.cellSize = (400 + (-game.gridSize-5) * 8) / game.gridSize
    }
    var body: some View {
        VStack {
            Text("Status: \(game.gameWin ? "Win" : "Loss")")
                .font(.headline)
            Text("Cells uncovered: \(game.numUncovered)")
                .font(.headline)
            Text("Percentage uncovered (safe cells only): \(String(format: "%.2f", (100 * Double(game.numUncovered)/(Double(game.gridSize*game.gridSize) - Double(game.numOfMines)))))%\n")
                .font(.headline)
            ForEach(0..<game.gridSize) { i in
                HStack {
                    ForEach(0..<game.gridSize) { j in
                        ZStack {
                            RoundedRectangle(cornerRadius: 3)
                                .foregroundStyle((i == game.mineSteppedOn[0] && j == game.mineSteppedOn[1]) ? Color.red.opacity(0.5) : game.cells[i][j].uncovered ? Color.orange.opacity(0.2) : Color.gray.opacity(0.2))
                                .frame(width: CGFloat(cellSize), height: CGFloat(cellSize))
                            if game.cells[i][j].isMine {
                                Image(systemName: "burst.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: CGFloat(cellSize), height: CGFloat(cellSize))
                            } else {
                                Text("\(game.cells[i][j].minesAdjacent)")
                                    .frame(width: CGFloat(cellSize), height: CGFloat(cellSize))
                            }
                        }
                    }
                }
            }
        }
        .foregroundStyle(.black)
    }
}
