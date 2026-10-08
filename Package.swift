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
            url: "https://github.com/glossom-dev/Adfurikun-SPM-Core/releases/download/4.5.0-alpha.1/ADFMovieReward.xcframework.zip",
            checksum: "cb4b612eca32f6799f7e4d1ee44490c278dd2f50daad9bce7388ab0d1b2406bd"
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
