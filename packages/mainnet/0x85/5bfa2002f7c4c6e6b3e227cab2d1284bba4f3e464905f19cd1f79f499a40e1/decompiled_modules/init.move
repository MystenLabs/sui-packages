module 0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0xab489625e5e6739c43340e24d5c9ca476a24194fac08c3cc09449df5c50da776::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

