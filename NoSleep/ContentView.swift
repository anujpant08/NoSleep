//
//  ContentView.swift
//  NoSleep
//
//  Created by Anuj Pant on 29/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var buttonPressed: Bool = false
    @State var textValue: String = ""
    
    var body: some View {
        VStack {
            TextField(
                "Enter a value",
                text: self.$textValue
            )
            .padding(.all)
            Text(
                "Enter a value less than your system's sleep timer"
            )
            .padding(.init(top: 0, leading: 0, bottom: 5, trailing: 0))
            Text(
                "Please keep the app running in background"
            )
            .colorMultiply(.secondary)
            .padding(.bottom)
            Button(
                "Set No Sleep Limit"
            ){
                print("Setting no sleep limit")
                buttonPressed = true
            }
            .buttonStyle(.borderedProminent)
            .tint(.accentColor)
            if (buttonPressed) {
                Text("No sleep limit set to " + textValue)
                // Logic to avoid sleep...
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
