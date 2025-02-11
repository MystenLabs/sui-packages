module 0x9ad77a598af06fe3f0d9e2c93bef764c75146f35f4e37551664b861d25561e74::grow_usd {
    struct GROW_USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROW_USD, arg1: &mut 0x2::tx_context::TxContext) {
        0x9ad77a598af06fe3f0d9e2c93bef764c75146f35f4e37551664b861d25561e74::constructor::create_coin<GROW_USD>(arg0, b"USD", b"Grow USD yield-bearing stablecoin", b"https://example.com/usd.png", arg1);
    }

    // decompiled from Move bytecode v6
}

