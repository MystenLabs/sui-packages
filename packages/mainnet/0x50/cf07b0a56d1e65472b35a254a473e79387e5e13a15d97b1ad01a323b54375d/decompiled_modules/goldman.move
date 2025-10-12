module 0x50cf07b0a56d1e65472b35a254a473e79387e5e13a15d97b1ad01a323b54375d::goldman {
    struct GOLDMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDMAN, arg1: &mut 0x2::tx_context::TxContext) {
        0xcc2240a338a87725aaef79a4dda232876bd517aff8e760cdb5c3152932fb8852::connector_v3::new<GOLDMAN>(arg0, 188207571, b"goldman", b"GOLDMAN", b"Goldman by suifun", b"http://127.0.0.1:8000/api/v1/blob/D7iOvneOUR3SMxd3Ni_ixLOaL9fBJtfyUI0CbapxfEM", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

