// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ShimmerPlaceholder",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "ShimmerPlaceholder",
            targets: ["ShimmerPlaceholder"]
        )
    ],
    targets: [
        .target(
            name: "ShimmerPlaceholder"
        ),
        .testTarget(
            name: "ShimmerPlaceholderTests",
            dependencies: ["ShimmerPlaceholder"]
        )
    ]
)
