// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "FixedList",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        .library(
            name: "FixedList",
            targets: ["FixedList"]
        ),
    ],
    targets: [
        .target(
            name: "FixedList",
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
            ]
        ),
    ]
)
