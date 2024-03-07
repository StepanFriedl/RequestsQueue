# Swift RequestsQueue Package
## Overview
The Swift RequestsQueue package is designed to simplify network request handling by providing a mechanism to observe the internet connection status. It includes a function to wrap network request functions, ensuring they are executed immediately if the internet connection is available. If the connection is not available, the package stores the request and executes it automatically when the connection is restored.
## Installation
To integrate the Swift NetworkObserver package into your project, use Swift Package Manager.
## Usage
### Import the Package
```Swift
import RequestsQueue
```
### Wrap you network request into addRequest() function, which can be called from NetworkManager.shared’s requestsQueueManager. Example:
```Swift
NetworkMonitor.shared.requestsQueueManager.addRequest {
    print(wholeURL)
    URLSession.shared.dataTask(with: wholeURL) { data, response, error in
        // Your network request logic here
    }.resume()
}
```
This code will check the internet connection. If the connection is available, the network request will be executed immediately. If the connection is not available, the request will be stored, and the package will automatically execute it when the connection is restored.
## License
The Swift NetworkObserver package is released under the MIT License. See the LICENSE file for details.
## Contributions
Contributions are welcome! If you have any ideas, bug reports, or feature requests, please open an issue on the GitHub repository.
