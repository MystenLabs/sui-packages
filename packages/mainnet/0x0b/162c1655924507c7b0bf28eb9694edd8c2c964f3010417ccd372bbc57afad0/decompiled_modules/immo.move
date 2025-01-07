module 0xb162c1655924507c7b0bf28eb9694edd8c2c964f3010417ccd372bbc57afad0::immo {
    struct IMMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMMO, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<IMMO>(arg0, 4534591899401560470, b"immortal jellyfish", b"IMMO", x"54686520776f726c64206973206d65616e696e676c6573732c20636f6d6d756e697479206973206d65616e696e676c6573732c2066696e616e6365206973206d65616e696e676c6573732c206d656d657320617265206d65616e696e676c6573732e0a492077696c6c20616c7761797320626520666c6f6174696e6720696e207468652063727970746f20776f726c642c20736c6565706c6573732e", b"https://images.hop.ag/ipfs/QmQnKHGv8bnqqH3RoPcoEhg4Utss7t9ypfujW3zkJUn2gG", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"https://en.wikipedia.org/wiki/Turritopsis_dohrnii"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

