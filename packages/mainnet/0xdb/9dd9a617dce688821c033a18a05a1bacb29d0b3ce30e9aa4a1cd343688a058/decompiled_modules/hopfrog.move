module 0xdb9dd9a617dce688821c033a18a05a1bacb29d0b3ce30e9aa4a1cd343688a058::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 10948473468568452171, b"Frog Senpai On Hop", b"HOPFROG", b"First Frog on Hop Fun", b"https://images.hop.ag/ipfs/QmeBvJLiKpydNp9PdAavxAP5UBBqZ51GEBt7VwfVvxi82A", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

