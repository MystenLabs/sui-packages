module 0xea944e9046d6f67140709bff9015d0dca1cd489020caa6bcb735fa80b0dbeb93::suigold {
    struct SUIGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        0x3ea4a59ebabd8db764bbd1d4d92e45e53a5a15cb58d3826f5e357a6b56876be3::connector_v3::new<SUIGOLD>(arg0, 106568403, b"suigold", b"SUIGOLD", b"suigold by suifun", b"http://127.0.0.1:8000/api/v1/blob/bHmegIX2U2YDbchoV3KOIfxqCGuAAy-SV1P2QxIZK0E", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

