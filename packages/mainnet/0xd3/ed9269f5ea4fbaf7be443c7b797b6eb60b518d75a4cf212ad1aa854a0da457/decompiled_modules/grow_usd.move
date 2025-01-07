module 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_usd {
    struct GROW_USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROW_USD, arg1: &mut 0x2::tx_context::TxContext) {
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::constructor::create_coin<GROW_USD>(arg0, b"USD", b"Grow USD yield-bearing stablecoin", b"https://example.com/usd.png", arg1);
    }

    // decompiled from Move bytecode v6
}

