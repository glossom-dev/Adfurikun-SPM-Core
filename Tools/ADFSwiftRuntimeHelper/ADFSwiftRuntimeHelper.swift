import Foundation

// Swiftコンパイラに新方式の ___swift_instantiateConcreteTypeFromMangledNameV2 を生成させるための型。
// （配列プロパティを持つ Codable をデコードする処理から生成される）
// 機能上は使わないが、削除しないこと。
struct ADFSwiftRuntimeHelperDTO: Codable {
    let values: [String]
}

// Objective-C のクラスを同じファイルに置き、Core のソースから参照することで
// 静的ライブラリ内のこのオブジェクトが確実にリンクされるようにする。
@objc(ADFSwiftRuntimeHelperAnchor)
public final class ADFSwiftRuntimeHelperAnchor: NSObject {
    @objc public static func warmUp() {
        let data = Data("{\"values\":[]}".utf8)
        _ = try? JSONDecoder().decode(ADFSwiftRuntimeHelperDTO.self, from: data)
    }
}
