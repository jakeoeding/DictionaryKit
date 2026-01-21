// swift-tools-version: 6.2

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
    ]
)
