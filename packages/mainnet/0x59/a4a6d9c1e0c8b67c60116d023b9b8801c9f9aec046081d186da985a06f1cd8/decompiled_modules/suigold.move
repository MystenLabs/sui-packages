module 0x59a4a6d9c1e0c8b67c60116d023b9b8801c9f9aec046081d186da985a06f1cd8::suigold {
    struct SUIGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        0x3ea4a59ebabd8db764bbd1d4d92e45e53a5a15cb58d3826f5e357a6b56876be3::connector_v3::new<SUIGOLD>(arg0, 689880234, b"suigold", b"SUIGOLD", b"suigold by suifun", b"http://127.0.0.1:8000/api/v1/blob/bHmegIX2U2YDbchoV3KOIfxqCGuAAy-SV1P2QxIZK0E", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

