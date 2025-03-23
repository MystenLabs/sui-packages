module 0xc99218b5e309135a1671a8f8c31cb56df08e8f892bfae6d7769cb48531c0e30b::grow_sui {
    struct GROW_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROW_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        0xc99218b5e309135a1671a8f8c31cb56df08e8f892bfae6d7769cb48531c0e30b::constructor::create_coin<GROW_SUI>(arg0, b"SUI", b"Grow SUI yield-bearing stablecoin", b"https://example.com/sui.png", arg1);
    }

    // decompiled from Move bytecode v6
}

