module 0xe40db5d0ac8535cab571ce9d5a24abb2b9c9aa9f9fa51aa63dfaf3ac8faa400e::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<FROG>(arg0, 4221756383430253387, b"Hopfrog Sui", b"Frog", x"f09f90b822486f702046726f672053746172746572205061636b222020f09f90b80a0a2020202020202020202020202020526f6c65782053687572696b656e200a2020202020202020202020202020537569206865616462616e64200a20202020202020202020202020204d6f6e657920227363726f6c6c22200a20202020202020202020202020204c6564676572202273776f726422", b"https://images.hop.ag/ipfs/QmXCXYSbvteuGnfC4hGL8KH1GNf5nsNnhN5AU3iuNfjRwG", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

