import SwiftUI

struct ContentView: View {
    
    @State var timerValue: String = ""
    @State private var validInput: Bool = true
    @State private var actionSuccesful: Bool = false
    let noSleepApp = NoSleepApp()
    
    var body: some View {
        VStack {
            TextField(
                "Enter a value",
                text: self.$timerValue
            )
            .onChange(of: timerValue) {
                newValue in actionSuccesful = false
            }
            .padding(.all)
            if (!validInput) {
                Label("Please enter numbers only.", systemImage: "exclamationmark.triangle.fill")
                    .foregroundColor(.red)
                    .font(.caption)
            }
            Text(
                "Enter no. of minutes less than your system's sleep timer"
            )
            .padding(.init(top: 0, leading: 0, bottom: 5, trailing: 0))
            Text(
                "Please keep the app running in background"
            )
            .colorMultiply(.secondary)
            .padding(.bottom)
            Button(
                action: {
                    validInput = isValidInput(self.$timerValue.wrappedValue)
                    if (validInput) {
                        print("Setting no sleep limit")
                        let result = noSleepApp.scheduleChangeMouseLocation(timerValue)
                        if(!result) {
                            print("Error setting no sleep limit")
                        } else {
                            actionSuccesful = true
                        }
                    }
                }
            ){
                Text ("Set No Sleep Limit")
                    .foregroundColor(.white)
            }
            .alert("No-Sleep timer set successfully!", isPresented: $actionSuccesful) {
                Button("OK", role: .cancel) {}
            }
            .buttonStyle(.borderedProminent)
            .tint(.accentColor)
        }
        .padding()
    }
    
    private func isValidInput(_ text: String) -> Bool {
        if (text.isEmpty) {
            return false
        }
        // Check if the input contains only digits
        if text.range(of: "^[0-9]*$", options: .regularExpression) == nil {
            return false
        } else {
            return true
        }
    }
    
}

#Preview {
    ContentView()
}
