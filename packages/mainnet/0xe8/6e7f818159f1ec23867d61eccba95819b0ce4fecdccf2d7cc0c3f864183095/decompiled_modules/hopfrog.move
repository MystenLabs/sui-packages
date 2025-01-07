module 0xe86e7f818159f1ec23867d61eccba95819b0ce4fecdccf2d7cc0c3f864183095::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 5911342671295025944, b"Hopfrog Sui", b"HOPFROG", x"546f64617920697320746865206461792120f09f90b8", b"https://images.hop.ag/ipfs/QmXCXYSbvteuGnfC4hGL8KH1GNf5nsNnhN5AU3iuNfjRwG", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

