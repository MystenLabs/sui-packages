module 0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

