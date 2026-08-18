module 0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x3c3bc5109d45e29c159e64d46daed137156e5c1584147a55eb057231715a9f0a::config::create_config_and_share<INIT>(&arg0, arg1);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

