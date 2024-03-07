import Foundation

class RequestsQueueManager: ObservableObject {
    private var requestsQueue: [() -> Void] = []
    
    public func addRequest(_ request: @escaping () -> Void) {
        if NetworkMonitor.shared.reachability?.connection != .unavailable {
            request()
        } else {
            requestsQueue.append(request)
        }
    }
    
    public func processRequests() {
        while !requestsQueue.isEmpty {
            if let request = requestsQueue.first, NetworkMonitor.shared.isOnline {
                if requestsQueue.count > 0 {
                    DispatchQueue.main.async {
                        request()
                    }
                    requestsQueue.removeFirst()
                }
            }
        }
    }
}
