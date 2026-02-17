module 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::cannibal {
    struct CANNIBAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANNIBAL, arg1: &mut 0x2::tx_context::TxContext) {
        0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::admin::create_and_transfer(arg1);
    }

    // decompiled from Move bytecode v6
}

