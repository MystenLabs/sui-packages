module 0x23cdf2e9788c27208c48087efc5b39c718c86df4254d656602788d32a708c671::goldman {
    struct GOLDMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDMAN, arg1: &mut 0x2::tx_context::TxContext) {
        0xcc2240a338a87725aaef79a4dda232876bd517aff8e760cdb5c3152932fb8852::connector_v3::new<GOLDMAN>(arg0, 984975997, b"goldman", b"GOLDMAN", b"Goldman Is launching  by suifun", b"http://127.0.0.1:8000/api/v1/blob/D7iOvneOUR3SMxd3Ni_ixLOaL9fBJtfyUI0CbapxfEM", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

