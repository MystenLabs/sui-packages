module 0x63e1b7987dbba7d0ac46f175808c9997ed45b7313b6a76267307c42bf41068d9::fffffff {
    struct FFFFFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFFFFF, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FFFFFFF>(arg0, 10827071831421939934, b"FFFFF", b"FFFFFFF", b"FFF", b"https://images.hop.ag/ipfs/QmeLHTqR7qbKUarBntrptLPSxYASjoKiajXV8dKvgPQDqt", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

