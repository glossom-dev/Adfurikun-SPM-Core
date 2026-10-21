#!/bin/sh
# ADFSwiftRuntimeHelper.xcframework.zip をビルドする。
# usage: DEVELOPER_DIR=/Applications/Xcode-26.5.0.app/Contents/Developer ./build_xcframework.sh <出力ディレクトリ>
#
# 必ず Xcode 26.3 以降でビルドすること（Xcode 26.2 以前だと旧方式の V2 になり、逆効果になる）。
# 対応OSは Core と同じ iOS 13.0。iOS 13 向けのため AbstractV2 は生成されないが、
# 新方式の V2 が先に採用されれば AbstractV2 が新旧どちらでもクラッシュしない。
set -eu

OUT="${1:?出力ディレクトリを指定してください}"
SRC="$(cd "$(dirname "$0")" && pwd)/ADFSwiftRuntimeHelper.swift"
WORK="$(mktemp -d "${TMPDIR:-/tmp}/adf_swift_runtime_helper.XXXXXX")"
trap 'rm -rf "$WORK"' EXIT

compile() {
    xcrun --sdk "$1" swiftc -target "$2" -O -parse-as-library \
        -module-name ADFSwiftRuntimeHelper -module-cache-path "$WORK/ModuleCache" \
        -c "$SRC" -o "$3"
}

mkdir -p "$WORK/device" "$WORK/simulator" "$OUT"
compile iphoneos arm64-apple-ios13.0 "$WORK/device/helper.o"
compile iphonesimulator arm64-apple-ios13.0-simulator "$WORK/simulator/helper_arm64.o"
compile iphonesimulator x86_64-apple-ios13.0-simulator "$WORK/simulator/helper_x86_64.o"

xcrun libtool -static -o "$WORK/device/libADFSwiftRuntimeHelper.a" "$WORK/device/helper.o"
xcrun libtool -static -o "$WORK/simulator/libADFSwiftRuntimeHelper.a" \
    "$WORK/simulator/helper_arm64.o" "$WORK/simulator/helper_x86_64.o"

xcodebuild -create-xcframework \
    -library "$WORK/device/libADFSwiftRuntimeHelper.a" \
    -library "$WORK/simulator/libADFSwiftRuntimeHelper.a" \
    -output "$WORK/ADFSwiftRuntimeHelper.xcframework"

# 実機用に新方式の V2（ccmp 命令を含む）が入っていることを確認する
BODY="$(cd "$WORK/device" && xcrun objdump -d --no-show-raw-insn helper.o \
    | awk '$2=="<___swift_instantiateConcreteTypeFromMangledNameV2>:"{f=1;next} f&&/^$/{exit} f{print}')"
if ! echo "$BODY" | grep -q ccmp; then
    echo "error: 新方式の V2 が生成されていません。Xcode 26.3 以降でビルドしてください。" >&2
    exit 1
fi

(cd "$WORK" && ditto -c -k --norsrc --noextattr --keepParent \
    ADFSwiftRuntimeHelper.xcframework "$OUT/ADFSwiftRuntimeHelper.xcframework.zip")
echo "checksum: $(shasum -a 256 "$OUT/ADFSwiftRuntimeHelper.xcframework.zip" | cut -d' ' -f1)"
