module 0xb1ffb3a87ad3cd8e05767e48447cb946d82714790c889f2b818feec6d87a7927::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0xb1ffb3a87ad3cd8e05767e48447cb946d82714790c889f2b818feec6d87a7927::dev::create_dev_integration_object_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

