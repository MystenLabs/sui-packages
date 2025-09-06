module 0x744c23ee325aa3eb85bc1636604975af8a615fb8b5182999faf247d3cbd9e3b7::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5168f47f1dfcc2cfbd94876454c90ace20490b5f272b61e753f1e739d252c789::connector_v3::new<HI>(arg0, 165555352, b"hi", b"HI", b"hi by suifun", b"http://127.0.0.1:8000/api/v1/blob/OLvelm89IHWIvUuJ2vj4-Mxn7qEBTiRy8WFy_xNRbSQ", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

