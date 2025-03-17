module 0x2222d919c2a34bcc7a7cfac7f519b909d44320ce79e500193acc17b618e1aa84::grow_sui {
    struct GROW_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROW_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2222d919c2a34bcc7a7cfac7f519b909d44320ce79e500193acc17b618e1aa84::constructor::create_coin<GROW_SUI>(arg0, b"SUI", b"Grow SUI yield-bearing stablecoin", b"https://example.com/sui.png", arg1);
    }

    // decompiled from Move bytecode v6
}

