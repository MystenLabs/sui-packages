module 0x225b0bbc845bf006ecbc38d4298b73e561702f1aa2e349fbacac442cb857064e::mouse {
    struct MOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MOUSE>(arg0, 1590583920060070085, b"Stuart Little", b"MOUSE", b"One and only $MOUSE on Sui network, here to catch the maximum gains from the markets hodling, the meme coin that brings the legendary little mouse from the classic movie to the world of Sui!", b"https://images.hop.ag/ipfs/QmYFhyTGFCCbV99Tn4YatrLj4CXfEYAnoHdyoVe8PTyBT9", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

