// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AdfurikunCore",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "AdfurikunSDK", targets: ["AdfurikunSDKTarget"])
    ],
    targets: [
        // Swiftコンパイラが生成するヘルパー関数 ___swift_instantiateConcreteTypeFromMangledNameV2 の
        // 新方式（Xcode 26.3以降）の実装を提供する静的ライブラリ。
        // 静的リンクされた各SDKの同名関数は最初にリンクされたものに統合されるため、
        // 全SDKより先にリンクされる Core から新方式の V2 を提供し、
        // 旧方式（Xcode 26.2以前）の V2 を持つSDKとの混在によるクラッシュを防ぐ。
        // ビルド手順は Tools/ADFSwiftRuntimeHelper/README.md を参照。
        .binaryTarget(
            name: "ADFSwiftRuntimeHelper",
            url: "https://github.com/glossom-dev/Adfurikun-SPM-Core/releases/download/4.5.0/ADFSwiftRuntimeHelper.xcframework.zip",
            checksum: "6787cc6179668b924300190f010451488a60139682a47ee327bace5ac9506586"
        ),
        .binaryTarget(
            name: "ADFMovieReward",
            url: "https://github.com/glossom-dev/Adfurikun-SPM-Core/releases/download/4.5.0/ADFMovieReward.xcframework.zip",
            checksum: "f78599b86affd35ea35ffe22efa40ff51143699f8ad52a52bb2b01803b4d1a41"
        ),
        .target(
            name: "AdfurikunSDKTarget",
            // ADFSwiftRuntimeHelper を先頭に置き、他のSDKより先にリンクさせる
            dependencies: ["ADFSwiftRuntimeHelper", "ADFMovieReward"],
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
