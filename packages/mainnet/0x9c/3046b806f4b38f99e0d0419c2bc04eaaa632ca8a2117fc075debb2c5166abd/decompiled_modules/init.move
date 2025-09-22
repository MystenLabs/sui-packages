module 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::create_package_admin_cap_and_keep<INIT>(&arg0, arg1);
        0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

