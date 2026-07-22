module 0x2c580f5f0bcc341e0e7a656f5661e8b8ad90c53cc1e26b7c08284c14dd4ddf38::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2c580f5f0bcc341e0e7a656f5661e8b8ad90c53cc1e26b7c08284c14dd4ddf38::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

