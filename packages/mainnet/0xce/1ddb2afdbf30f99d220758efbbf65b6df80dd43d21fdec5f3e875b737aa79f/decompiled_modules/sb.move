module 0xce1ddb2afdbf30f99d220758efbbf65b6df80dd43d21fdec5f3e875b737aa79f::sb {
    struct SB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SB, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SB>(arg0, 1088330066960916108, x"5355c4b020424f54", b"SB", b"ai chat bot", b"https://images.hop.ag/ipfs/QmQnzKoNK7BU66yX3jx2TJ5pwZhtg8d1Ekr2y433oekdsj", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

