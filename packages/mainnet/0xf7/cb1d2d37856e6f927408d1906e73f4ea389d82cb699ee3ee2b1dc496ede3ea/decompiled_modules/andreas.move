module 0xf7cb1d2d37856e6f927408d1906e73f4ea389d82cb699ee3ee2b1dc496ede3ea::andreas {
    struct ANDREAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDREAS, arg1: &mut 0x2::tx_context::TxContext) {
        0x3ea4a59ebabd8db764bbd1d4d92e45e53a5a15cb58d3826f5e357a6b56876be3::connector_v3::new<ANDREAS>(arg0, 114701916, b"andreas", b"ANDREAS", b"andreas by suifun", b"http://127.0.0.1:8000/api/v1/blob/JVygCKfqLDURz9L6VDwJbpmuWwTfJ9ZsWw5ktrLhdso", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

