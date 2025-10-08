module 0x75f0001cbc3ddfb36dd4d3e99bf99c8864afbc25b24a83cae75149a4b5b0db39::goldman {
    struct GOLDMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDMAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x3ea4a59ebabd8db764bbd1d4d92e45e53a5a15cb58d3826f5e357a6b56876be3::connector_v3::new<GOLDMAN>(arg0, 609660171, b"goldman", b"GOLDMAN", b"goldman by suifun", b"http://127.0.0.1:8000/api/v1/blob/OLvelm89IHWIvUuJ2vj4-Mxn7qEBTiRy8WFy_xNRbSQ", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

