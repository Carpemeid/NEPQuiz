//
//  GameContentView.swift
//  NEPQuiz
//
//  Created by Dan Andoni on 01/12/2022.
//

import SwiftUI

private enum GameModel {
    case nameInput
    case scoreInput(name: String)
    case result(name: String, correctAnswersCount: Int)
}

struct GameContentView: View {
    @State private var gameModel: GameModel = .nameInput

    var body: some View {
        switch gameModel {
        case .nameInput:
            NameInputView { name in
                withAnimation {
                    gameModel = .scoreInput(name: name)
                }
            }
            .transition(.move(edge: .leading))
        case .scoreInput(let name):
            ScoreInputView { score in
                withAnimation {
                    gameModel = .result(name: name, correctAnswersCount: score)
                }
            }
            .transition(.move(edge: .leading))
        case .result(let name, let correctAnswersCount):
            ResultView(name: name,
                       score: correctAnswersCount) {
                withAnimation {
                    gameModel = .scoreInput(name: name)
                }
            }
            .transition(.move(edge: .trailing))
        }
    }
}
