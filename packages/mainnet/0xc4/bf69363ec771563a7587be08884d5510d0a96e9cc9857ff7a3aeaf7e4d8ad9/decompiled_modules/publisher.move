module 0xc4bf69363ec771563a7587be08884d5510d0a96e9cc9857ff7a3aeaf7e4d8ad9::publisher {
    struct PUBLISHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUBLISHER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PUBLISHER>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

