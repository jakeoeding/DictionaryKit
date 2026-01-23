// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "DictionaryKit",
    products: [
        .library(
            name: "DictionaryKit",
            targets: ["DictionaryKit"]
        ),
    ],
    targets: [
        .target(
            name: "DictionaryKit",
        ),
        .executableTarget(
            name: "DictionaryKitExample",
            dependencies: ["DictionaryKit"],
            path: "Examples"
        )
    ]
)
