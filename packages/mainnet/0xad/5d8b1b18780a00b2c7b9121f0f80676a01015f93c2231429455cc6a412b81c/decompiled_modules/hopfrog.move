module 0xad5d8b1b18780a00b2c7b9121f0f80676a01015f93c2231429455cc6a412b81c::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 1668241842230635056, b"Hop Frog Sui", b"HOPFROG", x"726561647920f09f90b820212121", b"https://images.hop.ag/ipfs/QmXmmpgWbSniRVV4e7cgUgfxanjsTojqvFTp1HKSPKTZfe", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

