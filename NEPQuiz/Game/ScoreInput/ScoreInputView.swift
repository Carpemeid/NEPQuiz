//
//  ScoreInputView.swift
//  NEPQuiz
//
//  Created by Dan Andoni on 01/12/2022.
//

import SwiftUI

struct ScoreInputView: View {
    let scoreSchanged: (Int) -> Void

    var body: some View {
        VStack {
            
        }

        Button("Done score") {
            scoreSchanged(1)
        }
    }
}
