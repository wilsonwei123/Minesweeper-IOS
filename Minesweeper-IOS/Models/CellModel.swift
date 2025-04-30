//
//  CellModel.swift
//  Minesweeper-IOS
//
//  Created by Wilson Wei on 28/04/2025.
//

import Foundation

struct Cell: Identifiable {
    var id = UUID()
    var isMine = false
    var uncovered = false
    var flagged = false
    var isPicked = false
    var minesAdjacent = 0
}
