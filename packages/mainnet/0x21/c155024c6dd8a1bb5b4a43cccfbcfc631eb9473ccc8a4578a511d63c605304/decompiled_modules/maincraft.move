module 0x21c155024c6dd8a1bb5b4a43cccfbcfc631eb9473ccc8a4578a511d63c605304::maincraft {
    struct MAINCRAFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAINCRAFT, arg1: &mut 0x2::tx_context::TxContext) {
        0xa391020a5b8cf54c903b11d6c436bfa2803f1bc32d0a4bde7d2a610104bbab46::connector_v3::new<MAINCRAFT>(arg0, 1000, b"maincraft", b"MAINCRAFT", b"maincraft is the in thing for nft by suifun", b"http://127.0.0.1:8000/api/v1/blob/uiZ7nQO4FFHUvTUuYBp4pEPONjh4K57RYLm2u4yaQhg", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

