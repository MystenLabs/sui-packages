module 0x81659a5248e281fd49d559fafc8c55583fc7f1f49266efab26cd8526ceb60729::building {
    struct BUILDING has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUILDING, arg1: &mut 0x2::tx_context::TxContext) {
        0xa391020a5b8cf54c903b11d6c436bfa2803f1bc32d0a4bde7d2a610104bbab46::connector_v3::new<BUILDING>(arg0, 1000, b"building", b"BUILDING", b"building by suifun", b"http://127.0.0.1:8000/api/v1/blob/c_kJMpkGhaBdQRRv2yCBtuxan_N4AirqlHq022o1afk", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

