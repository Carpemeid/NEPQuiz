//
//  NameInputView.swift
//  NEPQuiz
//
//  Created by Dan Andoni on 01/12/2022.
//

import SwiftUI

struct NameInputView: View {
    let nameChanged: (String) -> Void

    @State private var textInput: String = ""
    @FocusState private var showsKeyboard: Bool

    var body: some View {
            VStack {
                Spacer()
                TextField("Type your nickname",
                          text: $textInput)
                .focused($showsKeyboard)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
                .onSubmit {
                    guard !textInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                        return
                    }

                    nameChanged(textInput)
                }
                .padding()
                Spacer()
                Spacer()
                Spacer()
                // using spacers to allign the textfield vertically at 2/5 of screen's height
            }
            .ignoresSafeArea(.keyboard)
            .onAppear {
                showsKeyboard = true
            }

    }
}
