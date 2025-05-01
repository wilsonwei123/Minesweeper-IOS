//
//  CellViewModel.swift
//  Minesweeper-IOS
//
//  Created by Wilson Wei on 28/04/2025.
//

import Foundation

class GameViewModel: ObservableObject, Identifiable {
    var id = UUID()
    @Published var cells: [[Cell]]
    @Published var gameIsOver = false
    @Published var gameWin = false
    //@Published var historyM = HistoryModel()
    var gridSize: Int
    var difficulty: Difficulty
    var numOfMines: Int
    var numUncovered: Int
    var mineSteppedOn = [-1, -1]
    
    enum Difficulty: Int {
        case easy = 1
        case medium
        case hard
        case veryHard
        case hardest
    }
    
    init(gridSize: Int, difficulty: Int) {
        self.difficulty = Difficulty(rawValue: difficulty) ?? .easy
        self.gridSize = gridSize
        self.numOfMines = 0
        self.numUncovered = 0
        self.cells = (0..<gridSize).map { i in
            (0..<gridSize).map { j in
                Cell()
            }
        }
    }
    
    func configMines() {
        for i in 0..<gridSize {
            for j in 0..<gridSize {
                if cells[i][j].isPicked {
                    continue
                }
                switch difficulty {
                    case .easy:
                        if Int.random(in: 1...100) < 10 {
                            cells[i][j].isMine = true
                            numOfMines += 1
                            }
                    case .medium:
                        if Int.random(in: 1...100) < 15 {
                            cells[i][j].isMine = true
                            numOfMines += 1
                        }
                    case .hard:
                        if Int.random(in: 1...100) < 20 {
                            cells[i][j].isMine = true
                            numOfMines += 1
                        }
                    case .veryHard:
                        if Int.random(in: 1...100) < 25 {
                            cells[i][j].isMine = true
                            numOfMines += 1
                        }
                    case .hardest:
                        if Int.random(in: 1...100) < 30 {
                            cells[i][j].isMine = true
                            numOfMines += 1
                        }
                }
            }
        }
        for i in 0..<gridSize {
            for j in 0..<gridSize {
                calcForTile(indexI: i, indexJ: j)
            }
        }
    }
    
    func uncoverCell(indexI: Int, indexJ: Int) -> Bool {
        if indexI < 0 || indexI >= gridSize || indexJ < 0 || indexJ >= gridSize || cells[indexI][indexJ].flagged || cells[indexI][indexJ].uncovered {
            return false
        }
        if cells[indexI][indexJ].isMine {
            gameIsOver = true
            //historyM.saveGame(game: self)
            self.mineSteppedOn = [indexI, indexJ]
            return true
        }
        cells[indexI][indexJ].uncovered = true
        numUncovered += 1
        if (numUncovered + numOfMines) == (gridSize * gridSize) {
            gameWin = true
            gameIsOver = true
            //historyM.saveGame(game: self)
            return true
        }
        if cells[indexI][indexJ].minesAdjacent == 0 {
            if indexI < gridSize - 1 {
                if indexJ < gridSize - 1 {
                    uncoverCell(indexI: indexI + 1, indexJ: indexJ + 1)
                }
                
                if indexJ > 0 {
                    uncoverCell(indexI: indexI + 1, indexJ: indexJ - 1)
                }
                
                uncoverCell(indexI: indexI + 1, indexJ: indexJ)
            }
            
            if indexI > 0 {
                if indexJ < gridSize - 1 {
                    uncoverCell(indexI: indexI - 1, indexJ: indexJ + 1)
                }
                
                if indexJ > 0 {
                    uncoverCell(indexI: indexI - 1, indexJ: indexJ - 1)
                }
                
                uncoverCell(indexI: indexI - 1, indexJ: indexJ)
            }
            
            if indexJ < gridSize - 1 {
                uncoverCell(indexI: indexI, indexJ: indexJ + 1)
            }
            
            if indexJ > 0 {
                uncoverCell(indexI: indexI, indexJ: indexJ - 1)
            }
        }
        return true
    }
    
    func flagCell(indexI: Int, indexJ: Int) -> Bool {
        if cells[indexI][indexJ].uncovered {
            return false
        }
        cells[indexI][indexJ].flagged.toggle()
        return true
    }
    
    func calcForTile(indexI: Int, indexJ: Int) {
        if !cells[indexI][indexJ].isMine {
            if indexI < gridSize - 1 {
                if indexJ < gridSize - 1 {
                    if cells[indexI + 1][indexJ + 1].isMine {
                        cells[indexI][indexJ].minesAdjacent += 1
                    }
                }
                
                if indexJ > 0 {
                    if cells[indexI + 1][indexJ - 1].isMine {
                        cells[indexI][indexJ].minesAdjacent += 1
                    }
                }
                
                if cells[indexI + 1][indexJ].isMine {
                    cells[indexI][indexJ].minesAdjacent += 1
                }
            }
            
            if indexI > 0 {
                if indexJ < gridSize - 1 {
                    if cells[indexI - 1][indexJ + 1].isMine {
                        cells[indexI][indexJ].minesAdjacent += 1
                    }
                }
                
                if indexJ > 0 {
                    if cells[indexI - 1][indexJ - 1].isMine {
                        cells[indexI][indexJ].minesAdjacent += 1
                    }
                }
                
                if cells[indexI - 1][indexJ].isMine {
                    cells[indexI][indexJ].minesAdjacent += 1
                }
            }
            
            if indexJ < gridSize - 1 {
                if cells[indexI][indexJ + 1].isMine {
                    cells[indexI][indexJ].minesAdjacent += 1
                }
            }
            
            if indexJ > 0 {
                if cells[indexI][indexJ - 1].isMine {
                    cells[indexI][indexJ].minesAdjacent += 1
                }
            }
        }
    }
    
    func firstTurnHelper() {
        for i in 0..<gridSize {
            for j in 0..<gridSize {
                if cells[i][j].isPicked {
                    uncoverCell(indexI: i, indexJ: j)
                }
            }
        }
    }
    
    // to be called only once
    func firstTurn(indexI: Int, indexJ: Int) {
        if gridSize > 4 {
            cells[indexI][indexJ].isPicked = true
            if indexI > 0 {
                cells[indexI - 1][indexJ].isPicked = true
            }
            if indexI < gridSize - 1 {
                cells[indexI + 1][indexJ].isPicked = true
            }
            if indexJ > 0 {
                cells[indexI][indexJ - 1].isPicked = true
            }
            if indexJ < gridSize - 1 {
                cells[indexI][indexJ + 1].isPicked = true
            }
        } else {
            cells[indexI][indexJ].isPicked = true
        }
        configMines()
        firstTurnHelper()
    }
}
