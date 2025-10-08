module 0x7f458b86d1ec02d5ae416dcf7d34ef4cf8f472f990f15c6b0b7dd3012ed4c8ba::andreas {
    struct ANDREAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDREAS, arg1: &mut 0x2::tx_context::TxContext) {
        0x3ea4a59ebabd8db764bbd1d4d92e45e53a5a15cb58d3826f5e357a6b56876be3::connector_v3::new<ANDREAS>(arg0, 511942388, b"andreas", b"ANDREAS", b"andreas by suifun", b"http://127.0.0.1:8000/api/v1/blob/bHmegIX2U2YDbchoV3KOIfxqCGuAAy-SV1P2QxIZK0E", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

