module 0xb7569ca1a45a4f1de0168fb0f14914f17efeb4b2bbe0b9e2d6555d7dfb8e6353::hfrog {
    struct HFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HFROG>(arg0, 12554047282182567998, b"HopFrog", b"HFROG", b"First Frog on Hop Fun", b"https://images.hop.ag/ipfs/QmUxugtFwfRN2WVLSW9BTrKqM9c6udo7bM7aU81NkhTcUr", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

