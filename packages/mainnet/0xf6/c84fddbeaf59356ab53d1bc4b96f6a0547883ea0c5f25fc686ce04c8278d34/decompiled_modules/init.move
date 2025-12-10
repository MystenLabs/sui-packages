module 0xf6c84fddbeaf59356ab53d1bc4b96f6a0547883ea0c5f25fc686ce04c8278d34::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0xf6c84fddbeaf59356ab53d1bc4b96f6a0547883ea0c5f25fc686ce04c8278d34::stork::create_stork_integration_object_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

