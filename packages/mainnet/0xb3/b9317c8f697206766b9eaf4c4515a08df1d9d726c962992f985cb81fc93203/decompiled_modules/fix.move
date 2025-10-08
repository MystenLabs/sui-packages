module 0xb3b9317c8f697206766b9eaf4c4515a08df1d9d726c962992f985cb81fc93203::fix {
    struct FIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIX, arg1: &mut 0x2::tx_context::TxContext) {
        0x3ea4a59ebabd8db764bbd1d4d92e45e53a5a15cb58d3826f5e357a6b56876be3::connector_v3::new<FIX>(arg0, 345993479, b"fix", b"FIX", b"fix by suifun", b"http://127.0.0.1:8000/api/v1/blob/JVygCKfqLDURz9L6VDwJbpmuWwTfJ9ZsWw5ktrLhdso", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

