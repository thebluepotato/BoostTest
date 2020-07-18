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
        /// An tentative `.systemLibrary` to import the Boost headers. Because Boost doesn't provide a `.pc` file, we cannot use pkg-config here
        /// The modulemap/shim combo doesn't help, Xcode still can't find the headers... Is the target `.systemLibrary` only meant for importing C in *Swift* and not to other C targets? Having `CXXBoost` as only dependency for the Swift `BoostTest` target erors out because:
        /// 1. it can't find the headers
        /// 2. even with the unsafe include flag, it cannot use the headers because it reads them as C, not C++
        /// This seems to confirm that `.systemLibrary` is not the right option here / only tries to expose C to Swift
        .systemLibrary(
            name: "CXXBoost",
            providers: [
                .brew(["boost"])
            ]
        ),
        /// The C++ library
        .target(
            name: "CXXLib",
            dependencies: ["CXXBoost"],
            exclude: ["include"] // will be fixed with PR-2814
            /// This unsafe flag is required for Xcode to find the Boost headers. `swift build` doesn't need it.
            //, cxxSettings: [.unsafeFlags(["-I", "/usr/local/include"])]
        ),
        /// The C wrapper
        .target(
            name: "CWrapper",
            dependencies: ["CXXLib"]
            /// Because the `.cpp` wrapper includes `CXXLib`'s header, it needs to find Boost as well, so we have to duplicate that flag (it is not "imported" from the `CXXLib` target). `swift build` doesn't need it.
            //, cxxSettings: [.unsafeFlags(["-I", "/usr/local/include"])]
        ),
        .target(
            name: "BoostTest",
            dependencies: ["CWrapper"])
    ]
)
