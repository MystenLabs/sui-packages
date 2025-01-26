module 0x287035fbd4e768dc31da07a4fb55e9885f3d38dc109bbc4428123f896b0980d6::maddox {
    struct MADDOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADDOX, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MADDOX>(arg0, 8103245009480443343, b"MADDOX", b"MADDOX", b"The best page in the universe!", b"https://images.hop.ag/ipfs/QmeoiaeCpc64985yvU7AQZZFf9RmZwBr9Bk8ycPnyB57VD", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

