// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Adfurikun-SPM-Core",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "AdfurikunSDK", targets: ["AdfurikunSDKTarget"])
    ],
    targets: [
        .binaryTarget(
            name: "ADFMovieReward",
            url: "https://github.com/glossom-dev/Adfurikun-SPM-Core/releases/download/4.5.0-alpha.3/ADFMovieReward.xcframework.zip",
            checksum: "6f6736d9a2ad7ba60db60d1b19fa39a0022c97e8ef528a6c5b7d95f5278e0877"
        ),
        .target(
            name: "AdfurikunSDKTarget",
            dependencies: ["ADFMovieReward"],
            path: "Sources",
            publicHeadersPath: ".",
            linkerSettings: [
                .linkedLibrary("z"),
                .linkedFramework("AdSupport"),
                .linkedFramework("AppTrackingTransparency"),
                .linkedFramework("AVFoundation"),
                .linkedFramework("CoreGraphics"),
                .linkedFramework("CoreMedia"),
                .linkedFramework("CoreTelephony"),
                .linkedFramework("MediaPlayer"),
                .linkedFramework("SafariServices"),
                .linkedFramework("StoreKit"),
                .linkedFramework("SystemConfiguration"),
                .linkedFramework("UIKit"),
                .linkedFramework("WebKit"),
            ]
        )
    ]
)
