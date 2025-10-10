module 0x98eee7f80f94590b8ee143cbbaf2137159fc1612f3abf8542bb5b4cfd2be95e4::topofgame {
    struct TOPOFGAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOPOFGAME, arg1: &mut 0x2::tx_context::TxContext) {
        0x3ea4a59ebabd8db764bbd1d4d92e45e53a5a15cb58d3826f5e357a6b56876be3::connector_v3::new<TOPOFGAME>(arg0, 371141747, b"topofgame", b"TOPOFGAME", b"topofgame by suifun", b"http://127.0.0.1:8000/api/v1/blob/JVygCKfqLDURz9L6VDwJbpmuWwTfJ9ZsWw5ktrLhdso", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

