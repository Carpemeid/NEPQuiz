//
//  TimerView.swift
//  NEPQuiz
//
//  Created by Dan Andoni on 01/12/2022.
//

import SwiftUI

struct TimerView: View {
    private static let maxSeconds: Int = 45
    private static let twoDigitTextWidth: CGFloat = 25

    @Binding var timerStopped: Bool

    @State private var timer: Timer?
    @State private var timeFormatter: DateComponentsFormatter = {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.unitsStyle = .positional
        dateComponentsFormatter.allowedUnits = [.minute, .second]
        dateComponentsFormatter.zeroFormattingBehavior = .pad
        return dateComponentsFormatter
    }()

    @State private var startDate: Date = Date()
    @State private var startTime = "00:00:00"
    @State private var seconds = "00"
    @State private var milliseconds = "00"

    var body: some View {
        HStack {
            Text(seconds)
                .frame(width: TimerView.twoDigitTextWidth)
            Text(":")
            Text(milliseconds)
                .frame(width: TimerView.twoDigitTextWidth)
        }
        .onAppear {
            let localTimer = Timer(timeInterval: 0.01, repeats: true) { timerArgument in
                let (secondsNumericValue, secondsStringValue, millisecondsStringValue) = currentTimeString(startDate, timeFormatter: timeFormatter)

                guard secondsNumericValue < TimerView.maxSeconds else {
                    seconds = String(TimerView.maxSeconds)
                    milliseconds = "00"
                    timerStopped = true
                    return
                }

                seconds = secondsStringValue
                milliseconds = millisecondsStringValue
            }

            timer = localTimer
            // avoiding timer to be stopped by user interactions
            RunLoop.current.add(localTimer, forMode: .common)
        }
        .onChange(of: timerStopped) { hasStopped in
            guard hasStopped else {
                return
            }

            stopTimer()
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

private func currentTimeString(_ startDate: Date,
                               timeFormatter: DateComponentsFormatter) -> (secondsNumericValue: Int, secondsStringValue: String, millisecondsStringValue: String) {
    let currentDate = Date()

    guard let timeString = timeFormatter.string(from: startDate, to: currentDate),
          let seconds = timeString.components(separatedBy: ":").last else {
        return (0, "--","--")
    }

    let timeInterval = currentDate.timeIntervalSince(startDate)
    let ms = Int(timeInterval.truncatingRemainder(dividingBy: 1) * 100)

    let milliseconds = ms < 10 ? "0\(ms)" : ms > 99 ? "00" : "\(ms)"

    return (Int(timeInterval), seconds, milliseconds)
}
