module 0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0xb7fec5725f25e7d7869b939a8bc398306c83506506f5bd7934b24444a3b2d16::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

