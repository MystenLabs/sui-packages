module 0xd894870b13e89db4fe03f9f2733d05bda973ad9da79c286693792c9d490da531::topofgame {
    struct TOPOFGAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOPOFGAME, arg1: &mut 0x2::tx_context::TxContext) {
        0x3ea4a59ebabd8db764bbd1d4d92e45e53a5a15cb58d3826f5e357a6b56876be3::connector_v3::new<TOPOFGAME>(arg0, 27638172, b"topofgame", b"TOPOFGAME", b"topofgame by suifun", b"http://127.0.0.1:8000/api/v1/blob/JVygCKfqLDURz9L6VDwJbpmuWwTfJ9ZsWw5ktrLhdso", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

