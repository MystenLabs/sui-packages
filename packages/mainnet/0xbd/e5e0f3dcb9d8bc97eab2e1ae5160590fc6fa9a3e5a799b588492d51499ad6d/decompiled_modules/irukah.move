module 0xbde5e0f3dcb9d8bc97eab2e1ae5160590fc6fa9a3e5a799b588492d51499ad6d::irukah {
    struct IRUKAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRUKAH, arg1: &mut 0x2::tx_context::TxContext) {
        0x3ea4a59ebabd8db764bbd1d4d92e45e53a5a15cb58d3826f5e357a6b56876be3::connector_v3::new<IRUKAH>(arg0, 268919661, b"irukah", b"IRUKAH", b"irukah one and only online cdn by suifun", b"http://127.0.0.1:8000/api/v1/blob/JVygCKfqLDURz9L6VDwJbpmuWwTfJ9ZsWw5ktrLhdso", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

