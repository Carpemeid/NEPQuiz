//
//  ResultView.swift
//  NEPQuiz
//
//  Created by Dan Andoni on 01/12/2022.
//

import SwiftUI

struct ResultView: View {
    private static let textElementsPadding: CGFloat = 16

    let name: String
    let score: Int
    let finished: () -> Void

    var body: some View {
        VStack(spacing: ResultView.textElementsPadding) {
            if score > 0 {
                Text("Congratulations \(name) !🎉🎉🎉")
                    .font(.title)
            } else {
                Text("Tomorrow is another day \(name) 😎")
                    .font(.title)
            }

            Text("You have a score of \(score) correct answers")
                .padding(.bottom)

            Button("It was fun! I want to play again", action: finished)
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}
