module 0xd0f056e19ebc2443293c0da0b530ebd9cca91c38b0dbdbd57143f482b5f8078f::goldman {
    struct GOLDMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDMAN, arg1: &mut 0x2::tx_context::TxContext) {
        0xcc2240a338a87725aaef79a4dda232876bd517aff8e760cdb5c3152932fb8852::connector_v3::new<GOLDMAN>(arg0, 537652344, b"goldman", b"GOLDMAN", b"Goldman Launch by suifun", b"http://127.0.0.1:8000/api/v1/blob/D7iOvneOUR3SMxd3Ni_ixLOaL9fBJtfyUI0CbapxfEM", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

