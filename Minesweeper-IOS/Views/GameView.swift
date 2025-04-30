//
//  ContentView.swift
//  Minesweeper-IOS
//
//  Created by Wilson Wei on 28/04/2025.
//

import SwiftUI

// username to be implemented later

struct GameView: View {
    @ObservedObject var gameVM: GameViewModel
    let cellSize: Int
    @State var isGameOver: Bool = false
    @State var isGameWon: Bool = false
    @State var isFirstTurn: Bool = true
    init(gridSize: Int, difficulty: Int) {
        self.gameVM = GameViewModel(gridSize: gridSize, difficulty: difficulty)
        self.cellSize = (400 + (-gridSize-5) * 8) / gridSize
    }
    var body: some View {
        VStack {
            ForEach(0..<gameVM.gridSize) { i in
                HStack {
                    ForEach(0..<gameVM.gridSize) { j in
                        var cell = gameVM.cells[i][j]
                        ZStack {
                            RoundedRectangle(cornerRadius: 3)
                                .frame(width: CGFloat(cellSize), height: CGFloat(cellSize))
                                .foregroundStyle(cell.flagged ? Color.red : Color.gray.opacity(0.2))
                                .onTapGesture() {
                                    if isFirstTurn {
                                        gameVM.firstTurn(indexI: i, indexJ: j)
                                        isFirstTurn = false
                                    } else {
                                        gameVM.uncoverCell(indexI: i, indexJ: j)
                                    }
                                }
                                .onTapGesture(count: 2) {
                                    if !isFirstTurn {
                                        gameVM.flagCell(indexI: i, indexJ: j)
                                    }
                                }
                            
                            Group {
                                if cell.flagged {
                                    Image(systemName: "flag")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: CGFloat(cellSize), height: CGFloat(cellSize))
                                        .onTapGesture(count: 2) {
                                            gameVM.flagCell(indexI: i, indexJ: j)
                                        }
                                } else if cell.uncovered {
                                    if !cell.isMine {
                                        Text("\(cell.minesAdjacent)")
                                            .frame(width: CGFloat(cellSize), height: CGFloat(cellSize))
                                    }
                                }
                            }
                        }
                    }
                }
                .onChange(of: gameVM.gameIsOver) { newValue in
                    isGameOver = newValue
                }
                .onChange(of: gameVM.gameWin) { newValue in
                    isGameWon = newValue
                }
                
            }
            NavigationLink(destination: GameOverView(gameVM: gameVM, win: isGameWon), isActive: $isGameOver, label: { EmptyView() })
        }
        .padding(5)
        .foregroundStyle(.black)
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    GameView(gridSize: 8, difficulty: 3)
}
