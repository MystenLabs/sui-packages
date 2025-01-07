module 0x5d4e9012b920143b2e54c9222b5e0d86a81225a309f3d37415d6a1baff8e2dfd::publisher {
    struct PUBLISHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUBLISHER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PUBLISHER>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

