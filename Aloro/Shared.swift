import WatchConnectivity
import WidgetKit

final class Shared: NSObject, ObservableObject {
    @Published var username: String?
    var session: WCSession

    init(session: WCSession  = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }

    func fetchData(completion: @escaping (String) -> Void) {
        completion(self.username)
    }
}

extension Shared: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {}

    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String: Any] = [:]) {
        DispatchQueue.main.async {
            self.username = userInfo["username"] as? String
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}
