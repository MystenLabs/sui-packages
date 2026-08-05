module 0xcfd4f8b854a7ff873e5c08b4db2055675e0bc3b2780acaffc2358a47eddafb7d::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

