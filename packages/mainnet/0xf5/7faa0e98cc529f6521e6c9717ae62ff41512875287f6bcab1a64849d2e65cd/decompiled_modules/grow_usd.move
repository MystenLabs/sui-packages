module 0xf57faa0e98cc529f6521e6c9717ae62ff41512875287f6bcab1a64849d2e65cd::grow_usd {
    struct GROW_USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROW_USD, arg1: &mut 0x2::tx_context::TxContext) {
        0xf57faa0e98cc529f6521e6c9717ae62ff41512875287f6bcab1a64849d2e65cd::constructor::create_coin<GROW_USD>(arg0, b"USD", b"Grow USD yield-bearing stablecoin", b"https://example.com/usd.png", arg1);
    }

    // decompiled from Move bytecode v6
}

