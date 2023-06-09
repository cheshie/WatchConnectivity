import SwiftUI
import WidgetKit

struct ContentView: View {
    var shared = Shared()
    var body: some View {
        VStack {
            Button {
                self.sendMessage(username: "David")
            } label: { HStack {Text("David").font(.title).padding()} }
            Button {
                self.sendMessage(username: "John")
            } label: { HStack {Text("John").font(.title).padding()} }
        }
        .padding()
    }

    private func sendMessage(username: String) {
        self.shared.session.transferCurrentComplicationUserInfo(["username": username])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
