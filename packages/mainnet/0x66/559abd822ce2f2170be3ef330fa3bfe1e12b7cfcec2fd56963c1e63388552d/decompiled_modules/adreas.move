module 0x66559abd822ce2f2170be3ef330fa3bfe1e12b7cfcec2fd56963c1e63388552d::adreas {
    struct ADREAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADREAS, arg1: &mut 0x2::tx_context::TxContext) {
        0x3ea4a59ebabd8db764bbd1d4d92e45e53a5a15cb58d3826f5e357a6b56876be3::connector_v3::new<ADREAS>(arg0, 17167444, b"adreas", b"ADREAS", b"adreas by suifun", b"http://127.0.0.1:8000/api/v1/blob/JVygCKfqLDURz9L6VDwJbpmuWwTfJ9ZsWw5ktrLhdso", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

