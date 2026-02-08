// swift-tools-version: 5.4

import PackageDescription

let package = Package(
    name: "DictionaryKit",
    platforms: [
        .macOS(.v10_13)
    ],
    products: [
        .library(
            name: "DictionaryKit",
            targets: ["DictionaryKit"]
        ),
    ],
    targets: [
        .target(
            name: "DictionaryKit"
        ),
        .executableTarget(
            name: "DictionaryKitExample",
            dependencies: ["DictionaryKit"],
            path: "Examples"
        )
    ]
)
