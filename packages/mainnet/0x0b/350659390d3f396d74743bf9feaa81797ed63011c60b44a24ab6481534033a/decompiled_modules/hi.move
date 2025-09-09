module 0xb350659390d3f396d74743bf9feaa81797ed63011c60b44a24ab6481534033a::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        0x98818ad5ab74cd76aea7dd4ad9deabff55a83a28b919a5cb16cc088c1af91f0b::connector_v3::new<HI>(arg0, 328614444, b"hi", b"HI", b"hi by suifun", b"http://127.0.0.1:8000/api/v1/blob/OLvelm89IHWIvUuJ2vj4-Mxn7qEBTiRy8WFy_xNRbSQ", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

