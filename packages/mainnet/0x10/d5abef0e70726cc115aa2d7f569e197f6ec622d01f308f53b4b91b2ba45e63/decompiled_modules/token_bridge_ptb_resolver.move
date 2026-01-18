module 0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::token_bridge_ptb_resolver {
    struct TOKEN_BRIDGE_PTB_RESOLVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_BRIDGE_PTB_RESOLVER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<TOKEN_BRIDGE_PTB_RESOLVER>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

