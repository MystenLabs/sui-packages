module 0xa2cdc598aefef643ee1e532b815d7743134991285e7eadbd941e65ff4068583b::grow_sui {
    struct GROW_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROW_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        0xa2cdc598aefef643ee1e532b815d7743134991285e7eadbd941e65ff4068583b::constructor::create_coin<GROW_SUI>(arg0, b"SUI", b"Grow SUI yield-bearing stablecoin", b"https://example.com/sui.png", arg1);
    }

    // decompiled from Move bytecode v6
}

