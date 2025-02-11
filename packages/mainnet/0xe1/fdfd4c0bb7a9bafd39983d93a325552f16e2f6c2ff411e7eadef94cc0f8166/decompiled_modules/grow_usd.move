module 0xe1fdfd4c0bb7a9bafd39983d93a325552f16e2f6c2ff411e7eadef94cc0f8166::grow_usd {
    struct GROW_USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROW_USD, arg1: &mut 0x2::tx_context::TxContext) {
        0xe1fdfd4c0bb7a9bafd39983d93a325552f16e2f6c2ff411e7eadef94cc0f8166::constructor::create_coin<GROW_USD>(arg0, b"USD", b"Grow USD yield-bearing stablecoin", b"https://example.com/usd.png", arg1);
    }

    // decompiled from Move bytecode v6
}

