module 0xa2d916119996e5113a7f1fa934702f9e13099c494152e1f8a828fbfd46ec15c7::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<FROG>(arg0, 6675049693833947261, b"HopFrog", b"FROG", b"HopFrog Live", b"https://images.hop.ag/ipfs/QmUMMAuMjAeAnCTQKVcavhXtHXCuC61oEcZ9Vp5Xb4DGZK", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

