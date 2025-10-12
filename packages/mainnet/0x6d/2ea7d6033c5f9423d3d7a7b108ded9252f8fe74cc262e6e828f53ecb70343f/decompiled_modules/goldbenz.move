module 0x6d2ea7d6033c5f9423d3d7a7b108ded9252f8fe74cc262e6e828f53ecb70343f::goldbenz {
    struct GOLDBENZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDBENZ, arg1: &mut 0x2::tx_context::TxContext) {
        0xcc2240a338a87725aaef79a4dda232876bd517aff8e760cdb5c3152932fb8852::connector_v3::new<GOLDBENZ>(arg0, 51166047, b"goldbenz", b"GOLDBENZ", b"Goldbenz Launch by suifun", b"http://127.0.0.1:8000/api/v1/blob/D7iOvneOUR3SMxd3Ni_ixLOaL9fBJtfyUI0CbapxfEM", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

