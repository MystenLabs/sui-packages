module 0x5997250c92f47c03c76d1e7ab754173846c4494eb9f19052eb895d9352227ee::hopfrog {
    struct HOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPFROG>(arg0, 10557919190282823523, b"Hop Frog Sui", b"HOPFROG", x"46726f672053656e70616920436f6d6520f09f90b8f09f9087", b"https://images.hop.ag/ipfs/QmXCXYSbvteuGnfC4hGL8KH1GNf5nsNnhN5AU3iuNfjRwG", 0x1::string::utf8(b"https://x.com/HopFrogSui"), 0x1::string::utf8(b"https://hopfrog.fun/"), 0x1::string::utf8(b"https://t.me/HopFrogSui"), arg1);
    }

    // decompiled from Move bytecode v6
}

