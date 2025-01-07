module 0x82e41e26606e7142ef83b9103ae339a1b1d1c1a9bc232ac764ff30346ac39aad::trmu {
    struct TRMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMU, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TRMU>(arg0, 16412031864788168084, b"TRUMPMUSK", b"TRMU", b"The mos important people in the earth", b"https://images.hop.ag/ipfs/QmSViCB7xoZH4dQhhKDbbDAQun4utPmTPqXYFTUmizidwD", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

