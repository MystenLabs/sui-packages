module 0x618c6bd6dfb6be7993c842e22824cc86ac3e6c9d84a1964bcee72cc0148c358f::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        0x7900760f212a32fa1368ea3122f30e3e3d46b9384f4f5c93a826418fbdda06ee::connector_v3::new<HI>(arg0, 585597743, b"hi", b"HI", b"hi by suifun", b"http://127.0.0.1:8000/api/v1/blob/OLvelm89IHWIvUuJ2vj4-Mxn7qEBTiRy8WFy_xNRbSQ", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

