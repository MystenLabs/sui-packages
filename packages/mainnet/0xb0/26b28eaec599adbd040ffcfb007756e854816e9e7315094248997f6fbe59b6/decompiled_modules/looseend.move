module 0xb026b28eaec599adbd040ffcfb007756e854816e9e7315094248997f6fbe59b6::looseend {
    struct LOOSEEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOSEEND, arg1: &mut 0x2::tx_context::TxContext) {
        0xa391020a5b8cf54c903b11d6c436bfa2803f1bc32d0a4bde7d2a610104bbab46::connector_v3::new<LOOSEEND>(arg0, 1000, b"looseend", b"LOOSEEND", b"looseend by suifun", b"http://127.0.0.1:8000/api/v1/blob/TCfJ_iPZ3lioCJbtwm3tyggED6FBas10aHicminRQdY", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

