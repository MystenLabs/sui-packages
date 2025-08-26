module 0x609ec81afbcd3e56f62a9c61660d2922d2bcc2f00d4fa7d9af38e0336126c01d::good {
    struct GOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOD, arg1: &mut 0x2::tx_context::TxContext) {
        0xa391020a5b8cf54c903b11d6c436bfa2803f1bc32d0a4bde7d2a610104bbab46::connector_v3::new<GOOD>(arg0, 1000, b"good", b"GOOD", b"good by suifun", b"http://127.0.0.1:8000/api/v1/blob/c_kJMpkGhaBdQRRv2yCBtuxan_N4AirqlHq022o1afk", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

