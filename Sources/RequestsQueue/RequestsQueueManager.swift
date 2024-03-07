import Foundation

public class RequestsQueueManager: ObservableObject {
    private var requestsQueue: [String:() -> Void] = [:]
    
    public func addRequest(requestID: String, _ request: @escaping () -> Void) {
        if NetworkMonitor.shared.reachability?.connection != .unavailable {
            request()
        } else {
            requestsQueue[requestID] = request
        }
    }
    
    public func processRequests() {
        while !requestsQueue.isEmpty {
            if let requestKey = requestsQueue.keys.first, 
                NetworkMonitor.shared.isOnline,
                let request = requestsQueue[requestKey] {
                if requestsQueue.values.count > 0 {
                    DispatchQueue.main.async {
                        request()
                    }
                    
                    requestsQueue[requestKey] = nil
                }
            }
        }
    }
}
