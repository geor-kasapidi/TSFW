// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TSFW",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "TSFW",
            targets: ["TSFW"]
        ),
    ],
    targets: [
        .target(
            name: "TSFW",
            dependencies: []
        ),
        .testTarget(
            name: "TSFWTests",
            dependencies: ["TSFW"]
        ),
    ]
)
