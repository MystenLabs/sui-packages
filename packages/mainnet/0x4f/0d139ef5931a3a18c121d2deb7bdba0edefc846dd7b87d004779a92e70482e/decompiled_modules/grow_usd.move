module 0x4f0d139ef5931a3a18c121d2deb7bdba0edefc846dd7b87d004779a92e70482e::grow_usd {
    struct GROW_USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROW_USD, arg1: &mut 0x2::tx_context::TxContext) {
        0x4f0d139ef5931a3a18c121d2deb7bdba0edefc846dd7b87d004779a92e70482e::constructor::create_coin<GROW_USD>(arg0, b"USD", b"Grow USD yield-bearing stablecoin", b"https://example.com/usd.png", arg1);
    }

    // decompiled from Move bytecode v6
}

