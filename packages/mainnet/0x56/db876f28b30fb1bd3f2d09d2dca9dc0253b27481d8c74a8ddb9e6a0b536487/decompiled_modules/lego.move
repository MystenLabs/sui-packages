module 0x56db876f28b30fb1bd3f2d09d2dca9dc0253b27481d8c74a8ddb9e6a0b536487::lego {
    struct LEGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<LEGO>(arg0, 7173139947695464662, b"Lego", b"LEGO", x"4c65676f204d656d65636f696e206973206120706c617966756c2063727970746f206f6e2074686520537569204e6574776f726b2c20696e737069726564206279206275696c64696e6720626c6f636b732e204c6574e2809973206275696c6420796f75722063727970746f20776f726c642c206f6e6520626c6f636b20617420612074696d6521", b"https://images.hop.ag/ipfs/QmTCtqYebEq8NDKm19HazSS5KkBgknzzPMqjyagJM26U52", 0x1::string::utf8(b"https://x.com/legonsui"), 0x1::string::utf8(b"https://suilego.fun/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

