module 0x9f835c3c57d800778a002a873c17b73403ed5231c4c60f46f0fe3e492c566d8a::suigold {
    struct SUIGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        0xa391020a5b8cf54c903b11d6c436bfa2803f1bc32d0a4bde7d2a610104bbab46::connector_v3::new<SUIGOLD>(arg0, 1000, b"suigold", b"SUIGOLD", b"suigold by suifun", b"http://127.0.0.1:8000/api/v1/blob/uiZ7nQO4FFHUvTUuYBp4pEPONjh4K57RYLm2u4yaQhg", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

