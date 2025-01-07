module 0x1885e32a73d35c4c71c10be780d13bb90e5420a335cc244ac81db07a92468795::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FROG>(arg0, 3656283901856691181, b"HopFrog", b"FROG", b"First Frog on Hop Fun", b"https://images.hop.ag/ipfs/QmUxugtFwfRN2WVLSW9BTrKqM9c6udo7bM7aU81NkhTcUr", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

