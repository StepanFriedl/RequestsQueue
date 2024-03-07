// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RequestsQueue",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RequestsQueue",
            targets: ["RequestsQueue"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ashleymills/Reachability.swift.git", from: "5.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "RequestsQueue",
        dependencies: [
            .product(name: "Reachability", package: "Reachability.swift")
        ]
        ),
        .testTarget(
            name: "RequestsQueueTests",
            dependencies: ["RequestsQueue"]),
    ]
)
