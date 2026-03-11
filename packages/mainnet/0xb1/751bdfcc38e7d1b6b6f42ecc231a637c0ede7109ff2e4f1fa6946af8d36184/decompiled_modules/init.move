module 0xb1751bdfcc38e7d1b6b6f42ecc231a637c0ede7109ff2e4f1fa6946af8d36184::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0xb1751bdfcc38e7d1b6b6f42ecc231a637c0ede7109ff2e4f1fa6946af8d36184::pyth_lazer_rolling::create_pyth_lazer_rolling_integration_object_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

