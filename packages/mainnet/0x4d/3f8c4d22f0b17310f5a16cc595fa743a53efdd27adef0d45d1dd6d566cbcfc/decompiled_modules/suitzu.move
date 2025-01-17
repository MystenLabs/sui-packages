module 0x4d3f8c4d22f0b17310f5a16cc595fa743a53efdd27adef0d45d1dd6d566cbcfc::suitzu {
    struct SUITZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITZU, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUITZU>(arg0, 18147698748113361994, b"SUITZU JITZU", b"SUITZU", b"He gonna maim u, he gonna shame u, he gonna frame u.", b"https://images.hop.ag/ipfs/QmQj6q3sM1a7Rh41seFrdGdccVUez8HqPS4PhZVP865A5x", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

