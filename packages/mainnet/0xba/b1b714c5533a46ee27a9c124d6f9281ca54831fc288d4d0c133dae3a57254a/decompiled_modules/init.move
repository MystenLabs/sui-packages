module 0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0xbab1b714c5533a46ee27a9c124d6f9281ca54831fc288d4d0c133dae3a57254a::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

