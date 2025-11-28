module 0xf192a8b05a4fcb766f95a998e6fbe1075e6cdfd09a08e51e44e7fb5fce7da31d::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0xf192a8b05a4fcb766f95a998e6fbe1075e6cdfd09a08e51e44e7fb5fce7da31d::pyth::create_pyth_integration_object_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

