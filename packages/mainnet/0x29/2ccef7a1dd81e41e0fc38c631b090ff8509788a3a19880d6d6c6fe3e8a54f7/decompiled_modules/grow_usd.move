module 0x292ccef7a1dd81e41e0fc38c631b090ff8509788a3a19880d6d6c6fe3e8a54f7::grow_usd {
    struct GROW_USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROW_USD, arg1: &mut 0x2::tx_context::TxContext) {
        0x292ccef7a1dd81e41e0fc38c631b090ff8509788a3a19880d6d6c6fe3e8a54f7::constructor::create_coin<GROW_USD>(arg0, b"USD", b"Grow USD yield-bearing stablecoin", b"https://example.com/usd.png", arg1);
    }

    // decompiled from Move bytecode v6
}

