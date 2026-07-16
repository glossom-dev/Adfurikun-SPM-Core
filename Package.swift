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
            url: "https://github.com/glossom-dev/Adfurikun-SPM-Core/releases/download/4.4.0/ADFMovieReward.xcframework.zip",
            checksum: "27164cb5b445a53f06f39649aab271b6bdc10e250e2d758994fc506d8595a9f1"
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
