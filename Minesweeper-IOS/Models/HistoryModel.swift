//
//  HistoryModel.swift
//  Minesweeper-IOS
//
//  Created by Wilson Wei on 30/04/2025.
//

import Foundation

struct HistoryModel {
    var games = UserDefaults.standard.value(forKey: "games") as? [GameViewModel] ?? []
    
    mutating func saveGame(game: GameViewModel) {
        games.append(game)
        UserDefaults.standard.set(games, forKey: "games")
    }
}
