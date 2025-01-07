module 0x1939468d0ac082ad8f8079342549e365642ef558c6280907598fbd771e2a16c1::trump_87 {
    struct TRUMP_87 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP_87, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TRUMP_87>(arg0, 13635638641175874875, b"suitrump", b"trump87", b"trump87", b"https://images.hop.ag/ipfs/QmZnJJ1YUpvjYyaL4sA1YzBywWb6HwEwpoCScAj5CC5VDf", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

