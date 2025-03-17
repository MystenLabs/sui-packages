module 0xcce57582126dc77e86696bf67a9ede1e404d806971c10fb761f66308cde89a07::grow_usd {
    struct GROW_USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROW_USD, arg1: &mut 0x2::tx_context::TxContext) {
        0xcce57582126dc77e86696bf67a9ede1e404d806971c10fb761f66308cde89a07::constructor::create_coin<GROW_USD>(arg0, b"USD", b"Grow USD yield-bearing stablecoin", b"https://example.com/usd.png", arg1);
    }

    // decompiled from Move bytecode v6
}

