module 0xf14d77359941aa6c9dd348884c78308ed4c695e7fe8e52804176abf79aa8c6c1::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 14462904354011966199, b"HopFrogSui", b"HopFrog", b"First Frog on Hop Fun HopAggregator", b"https://images.hop.ag/ipfs/QmeBvJLiKpydNp9PdAavxAP5UBBqZ51GEBt7VwfVvxi82A", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

