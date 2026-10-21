# ADFSwiftRuntimeHelper

Swiftコンパイラが生成するヘルパー関数 `___swift_instantiateConcreteTypeFromMangledNameV2` の、新方式（Xcode 26.3以降）の実装を提供する静的ライブラリです。

## 目的

静的リンクされた各SDKに含まれる同名のヘルパー関数は、アプリ全体で、最初にリンクされたものに統合されます。
Xcode 26.2以前（旧方式）と Xcode 26.3以降（新方式）でビルドされたSDKが混在すると、
`V2` が旧方式、`AbstractV2` が新方式の組み合わせになった場合に `EXC_BAD_ACCESS` でクラッシュします
（例: DT Exchange SDK のリモート設定のデコード中 `DTXRemoteConfigDTO.Spot.init`）。

Core は全アダプターの依存として最初にリンクされるため、ここから新方式の `V2` を提供することで、
`AbstractV2` が新旧どちらの実装になってもクラッシュしないようにします。

## ビルド

```sh
DEVELOPER_DIR=/Applications/Xcode-26.5.0.app/Contents/Developer ./build_xcframework.sh <出力ディレクトリ>
```

- 必ず Xcode 26.3 以降でビルドしてください（Xcode 26.2 以前だと旧方式になり、逆効果です）。
- 対応OSは Core と同じ iOS 13.0 です。iOS 13 向けのため `AbstractV2` は含まれません。
- 出力された zip をリリースに添付し、表示された checksum を `Package.swift` に反映してください。

## 注意

- `Sources/AdfurikunSDK.m` からクラス `ADFSwiftRuntimeHelperAnchor` を参照しているため、削除しないでください。
- アプリ本体のターゲットが、Xcode 26.2以前でビルドした Swift のコードで `V2` だけを持つ場合は、アプリ本体の旧方式の `V2` が優先されるため、この対策は効きません。
