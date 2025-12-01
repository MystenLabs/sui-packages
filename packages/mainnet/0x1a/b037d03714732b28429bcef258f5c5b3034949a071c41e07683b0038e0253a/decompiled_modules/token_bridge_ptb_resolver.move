module 0x1ab037d03714732b28429bcef258f5c5b3034949a071c41e07683b0038e0253a::token_bridge_ptb_resolver {
    struct TOKEN_BRIDGE_PTB_RESOLVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_BRIDGE_PTB_RESOLVER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<TOKEN_BRIDGE_PTB_RESOLVER>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

