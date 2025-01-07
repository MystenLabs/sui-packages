module 0xba07818511b2e18527a2cc52346c69ebce86043e067d69c4ee7122c2751830eb::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 2567121359188871196, b"HOP THE FROG", b"HopFrog", b"First Frog on Hop Fun", b"https://images.hop.ag/ipfs/QmfWL1NMzgFkfNqx21bUfJxWaZyqigkykvsSv9MYDGNvPE", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

