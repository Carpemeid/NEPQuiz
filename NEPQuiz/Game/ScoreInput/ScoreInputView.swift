//
//  ScoreInputView.swift
//  NEPQuiz
//
//  Created by Dan Andoni on 01/12/2022.
//

import SwiftUI

struct ScoreInputView: View {
    private enum Constants {
        static let answersRange = 1...4
        static let elementPadding: CGFloat = 20
        static let answersCornerRadius: CGFloat = 5
        static let answersBorderWidth: CGFloat = 3
        static let correctAnswerShowTime: TimeInterval = 2
        static let correctAnswerScore = 1
        static let wrongAnswerScore = 0
    }

    let scoreChanged: (Int) -> Void

    @State private var timerStopped = false
    @State private var correctAnswer = Int.random(in: Constants.answersRange)
    @State private var selectedAnswer: Int?
    @State private var showTimeOutAlert: Bool = false

    var body: some View {
        VStack(spacing: Constants.elementPadding) {
            TimerView(timerStopped: $timerStopped)
            Text("Can you guess the number?")

            VStack {
                ForEach(Range<Int>(Constants.answersRange)) { answerValue in
                    RoundedRectangle(cornerRadius: Constants.answersCornerRadius)
                        .stroke(answerViewStrokeColor(answerValue), lineWidth: Constants.answersBorderWidth)
                        .contentShape(Rectangle())
                        .overlay {
                            Text(String(answerValue))
                        }
                        .onTapGesture {
                            // avoiding multiple answers after the first one
                            // and avoiding the stopped timer
                            guard selectedAnswer == .none && !timerStopped else {
                                return
                            }

                            selectedAnswer = answerValue
                        }
                }
            }
        }
        .padding()
        .onChange(of: selectedAnswer) { newValue in
            guard let selectedAnswer = selectedAnswer else {
                return
            }

            timerStopped = true

            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.correctAnswerShowTime) {
                scoreChanged(correctAnswer == selectedAnswer ? Constants.correctAnswerScore : Constants.wrongAnswerScore)
            }
        }
        .onChange(of: timerStopped) { newValue in
            guard selectedAnswer == .none else {
                return
            }

            showTimeOutAlert = true
        }
        .alert("Time is out. The correct answer is \(correctAnswer)",
               isPresented: $showTimeOutAlert) {
            Button("Ok", role: .cancel) {
                scoreChanged(Constants.wrongAnswerScore)
            }
        }
    }

    private func answerViewStrokeColor(_ value: Int) -> Color {
        guard let selectedAnswer = selectedAnswer else {
            return .gray
        }

        if selectedAnswer == value && selectedAnswer != correctAnswer {
            return .red
        }

        if correctAnswer == value {
            return .green
        }

        return .gray
    }
}
