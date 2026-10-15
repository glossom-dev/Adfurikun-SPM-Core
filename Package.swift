// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AdfurikunCore",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "AdfurikunSDK", targets: ["AdfurikunSDKTarget"])
    ],
    targets: [
        .binaryTarget(
            name: "ADFMovieReward",
            url: "https://github.com/glossom-dev/Adfurikun-SPM-Core/releases/download/4.5.0-alpha.4/ADFMovieReward.xcframework.zip",
            checksum: "ee37c891e5aba858c7faa7a48cc42b3f16b117cf33ebc17a57f28c110ff50321"
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
