module 0x27efa6c287080c01354c0218d327bad51664f13dfc24b8ca60c4e0ee9d5e8ac0::bigadreas {
    struct BIGADREAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGADREAS, arg1: &mut 0x2::tx_context::TxContext) {
        0x3ea4a59ebabd8db764bbd1d4d92e45e53a5a15cb58d3826f5e357a6b56876be3::connector_v3::new<BIGADREAS>(arg0, 986867960, b"bigadreas", b"BIGADREAS", b"BigAdreas by suifun", b"http://127.0.0.1:8000/api/v1/blob/OLvelm89IHWIvUuJ2vj4-Mxn7qEBTiRy8WFy_xNRbSQ", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

