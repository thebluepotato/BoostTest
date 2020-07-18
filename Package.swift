// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "BoostTest",
    products: [
        .executable(
            name: "BoostTest",
            targets: ["BoostTest"]),
    ],
    targets: [
        /// Because Boost doesn't provide a `.pc` file, we cannot use pkg-config here
        /// However, the modulemap/shim combo doesn't help, Xcode still can't find the headers (I guess Xcode looks for the headers of the modulemap within the SDK, but what point would there be for  `.systemLibrary` then? Or is that kind of target meant mostly for C -> Swift?
        .systemLibrary(
            name: "CXXBoost",
            providers: [
                .brew(["boost"])
            ]
        ),
        .target(
            name: "CXXLib",
            dependencies: ["CXXBoost"],
            exclude: ["include"] // will be fixed with PR-2814
            /// This unsafe flag is required for Xcode to find the Boost headers. `swift build` doesn't.
            //, cxxSettings: [.unsafeFlags(["-I", "/usr/local/include"])]
        ),
        .target(
            name: "CWrapper",
            dependencies: ["CXXLib"]
            /// Because the `.cpp` wrapper includes `CXXLib`'s header, it needs to find Boost as well, so we have to duplicate that flag (it is not "imported" from the `CXXLib` target). `swift build` doesn't.
            //, cxxSettings: [.unsafeFlags(["-I", "/usr/local/include"])]
        ),
        .target(
            name: "BoostTest",
            dependencies: ["CWrapper"])
    ]
)
