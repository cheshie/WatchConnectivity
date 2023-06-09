import SwiftUI
import WidgetKit
import ClockKit

struct ContentView: View {
    @ObservedObject var shared = Shared()

    var body: some View {
        VStack {
            HStack {
                if let username = self.shared.username {
                    Text("Hello \(username)")
                } else {
                    Text("Check iPhone app.")
                }
            }
        }
    }
}
