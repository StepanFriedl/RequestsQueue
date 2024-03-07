import SwiftUI
import Reachability

public class NetworkMonitor: ObservableObject {
    static public let shared = NetworkMonitor()
    
    public var connectionChangedToOnlineAction: () -> Void = {}
    public var connectionChangedToOfflineAction: () -> Void = {}
    
    var reachability = try? Reachability()
    
    @Published var isOnline: Bool = true {
        didSet {
            isOnline ? connectionChangedToOnlineAction() : connectionChangedToOfflineAction()
        }
    }
    @Published public var requestsQueueManager = RequestsQueueManager()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachablityChanged(notification: )), name: .reachabilityChanged, object: reachability)
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start reachability notifier")
        }
    }
    
    @objc func reachablityChanged(notification: Notification) {
        if let reachability = notification.object as? Reachability {
            isOnline = reachability.connection != .unavailable
            if isOnline {
                requestsQueueManager.processRequests()
            }
        }
    }
}
