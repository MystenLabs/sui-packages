module 0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x6890ed5cf666a6eb6a6ee5a858be7e52f3e1ae3f91a5e2d2baf159e25d0f78b3::pyth_lazer_rolling::create_pyth_lazer_rolling_integration_object_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

