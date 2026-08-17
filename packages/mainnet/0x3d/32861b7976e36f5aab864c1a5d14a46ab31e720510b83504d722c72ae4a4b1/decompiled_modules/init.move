module 0x3d32861b7976e36f5aab864c1a5d14a46ab31e720510b83504d722c72ae4a4b1::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x3d32861b7976e36f5aab864c1a5d14a46ab31e720510b83504d722c72ae4a4b1::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

