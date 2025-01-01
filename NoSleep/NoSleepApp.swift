import IOKit.pwr_mgt
import Foundation
import SwiftUI

@main
struct NoSleepApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private var assertionID: UnsafeMutablePointer<IOPMAssertionID> = UnsafeMutablePointer<IOPMAssertionID>.allocate(capacity: 1)
    private let assertionType = kIOPMAssertionTypePreventUserIdleDisplaySleep as CFString
    private let assertionReason = "Resetting Sleep Timer" as CFString
    
    func scheduleChangeMouseLocation(_ timerValue: String) -> Bool {
        if(timerValue.isEmpty) {
            print("Input is empty")
            return false
        }
        if(!isValidInput(timerValue)) {
            print("Invalid input")
            return false
        }
        let timeInSeconds = Double.init(timerValue)! * 60
        Timer.scheduledTimer(withTimeInterval: timeInSeconds, repeats: true) { _ in
            self.resetTimer()
            print("Sleep timer reset at \(Date())")
        }
        return true
    }
    
    private func createAssertion() {
        assertionID.pointee = 0
        let result = IOPMAssertionCreateWithName(
            assertionType,
            IOPMAssertionLevel(kIOPMAssertionLevelOn),
            assertionReason,
            assertionID
        )
        
        if result == kIOReturnSuccess {
            print("Sleep timer reset assertion created successfully.")
        } else {
            print("Failed to create sleep timer assertion. Error code: \(result)")
        }
    }
    
    private func releaseAssertion() {
        let result = IOPMAssertionRelease(assertionID.pointee)
        if result == kIOReturnSuccess {
            print("Sleep timer assertion released successfully.")
        } else {
            // Should fail when the app is launched for the first time since there are no assertions with the given ID created
            print("Failed to release sleep timer assertion. Error code: \(result)")
        }
    }
    
    private func isValidInput(_ text: String) -> Bool {
        // Check if the input contains only digits
        if text.range(of: "^[0-9]*$", options: .regularExpression) == nil {
            return false
        } else {
            return true
        }
    }
    
    func resetTimer() {
        releaseAssertion()
        createAssertion()
    }

}
