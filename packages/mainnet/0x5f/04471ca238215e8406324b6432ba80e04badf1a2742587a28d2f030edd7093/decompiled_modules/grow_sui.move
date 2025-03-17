module 0x5f04471ca238215e8406324b6432ba80e04badf1a2742587a28d2f030edd7093::grow_sui {
    struct GROW_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROW_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5f04471ca238215e8406324b6432ba80e04badf1a2742587a28d2f030edd7093::constructor::create_coin<GROW_SUI>(arg0, b"SUI", b"Grow SUI yield-bearing stablecoin", b"https://example.com/sui.png", arg1);
    }

    // decompiled from Move bytecode v6
}

