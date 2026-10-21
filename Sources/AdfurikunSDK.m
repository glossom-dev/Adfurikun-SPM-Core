// Core placeholder

// ADFSwiftRuntimeHelper を確実にリンクさせるための参照。
// 静的ライブラリは参照されないとリンクされないため、-ObjC 未設定のアプリでも
// ADFSwiftRuntimeHelper の新方式の V2 が他のSDKより先に採用されるようにする。
extern char ADFSwiftRuntimeHelperAnchorClass __asm("_OBJC_CLASS_$_ADFSwiftRuntimeHelperAnchor");
__attribute__((used)) static const void *ADFForceLoadSwiftRuntimeHelper = &ADFSwiftRuntimeHelperAnchorClass;
