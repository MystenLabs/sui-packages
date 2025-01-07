module 0xc917320536bfa8355c57469afc545a31fbcd85ae841b4946d9212cf8b7926ee3::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 8961911230157088555, b"HopFrog", b"HOPFROG", b"First Frog on Hop Fun", b"https://images.hop.ag/ipfs/QmUxugtFwfRN2WVLSW9BTrKqM9c6udo7bM7aU81NkhTcUr", 0x1::string::utf8(b"https://twitter.com/HopFrogSui"), 0x1::string::utf8(b"https://t.co/OHQecoSeN7"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

