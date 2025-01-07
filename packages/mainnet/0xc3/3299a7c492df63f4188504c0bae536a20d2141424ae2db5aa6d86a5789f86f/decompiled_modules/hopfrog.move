module 0xc33299a7c492df63f4188504c0bae536a20d2141424ae2db5aa6d86a5789f86f::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 13272355415374143330, b"Hop Frog On Sui", b"HOPFROG", b"Bonding", b"https://images.hop.ag/ipfs/QmSmdDtnR8MgnwnmRJJcqdxiHBXLTPhZBdTFB5ydATCCvW", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

