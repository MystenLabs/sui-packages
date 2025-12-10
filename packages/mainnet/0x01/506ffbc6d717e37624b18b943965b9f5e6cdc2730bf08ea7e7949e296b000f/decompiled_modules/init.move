module 0x1506ffbc6d717e37624b18b943965b9f5e6cdc2730bf08ea7e7949e296b000f::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x1506ffbc6d717e37624b18b943965b9f5e6cdc2730bf08ea7e7949e296b000f::dev::create_dev_integration_object_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

