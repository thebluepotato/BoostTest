// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BoostTest",
    products: [
        .executable(
            name: "BoostTest",
            targets: ["BoostTest"]),
    ],
    targets: [
        .target(
            name: "CXXBoost",
            exclude: ["include"], // will be fixed with PR-2814
            cxxSettings: [.unsafeFlags(["-I", "/usr/local/include"])]
        ),
        .target(
            name: "CWrapper",
            dependencies: ["CXXBoost"],
            cxxSettings: [.unsafeFlags(["-I", "/usr/local/include"])]),
        .target(
            name: "BoostTest",
            dependencies: ["CWrapper"])
    ]
)
