module 0x56356fa3b26718d5a9b5336d6041faa1da8492f101d91c2031d8f3a86db3a4b4::mames {
    struct MAMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMES, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MAMES>(arg0, 8654359993824658728, b"NOMAMES", b"MAMES", b"NOMAMESWEY", b"https://images.hop.ag/ipfs/QmRoJZhqqB5oLFYX5i3ezYncgY4WEMKPavc7m4vdTmsCcf", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

