//
//  ContentView.swift
//  VC Button
//
//  Created by Chandan Kumar Dash on 20/09/24.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var isPresenting = false
    @State private var isCaptured = false

    var body: some View {
        ZStack {
            VStack {
                if !isCaptured {
                    Button(action: {
                        isPresenting = true
                    }) {
                        Text("ହଊ ଭାଈ ହଊ")
                            .frame(width: 150, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    .sheet(isPresented: $isPresenting) {
                        NewView()
                    }
                } else {
                    Text("Sensitive content hidden")
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .onAppear {
            setupScreenshotPrevention()
        }
        .onDisappear {
            removeScreenshotPrevention()
        }
    }

    private func setupScreenshotPrevention() {
        NotificationCenter.default.addObserver(forName: UIScreen.capturedDidChangeNotification, object: nil, queue: .main) { _ in
            isCaptured = UIScreen.main.isCaptured
        }

        // Set the initial state
        isCaptured = UIScreen.main.isCaptured
    }

    private func removeScreenshotPrevention() {
        NotificationCenter.default.removeObserver(self, name: UIScreen.capturedDidChangeNotification, object: nil)
    }
}

struct NewView: View {
    @State private var showAlert = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("ଏଇଟା ଗୋଟିଏ ନୂଆ ଦୃଶ୍ୟ !")
                .font(.largeTitle)
                .padding()
            
            Button("ହଉ ଭାଇ ବଡ ଲୋକ") {
                dismiss()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .onAppear {
            showAlert = true
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("ସ୍ବାଗତଂ!"),
                message: Text("ଆପଣ ଗୋଟିଏ ନୂଆ ଦୃଶ୍ୟ ରେ ଅଛନ୍ତି "),
                dismissButton: .default(Text("ଠିକ ଅଛି"))
            )
        }
    }
}
