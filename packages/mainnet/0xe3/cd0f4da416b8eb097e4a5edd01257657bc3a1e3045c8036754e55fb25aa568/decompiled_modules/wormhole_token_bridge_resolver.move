module 0xe3cd0f4da416b8eb097e4a5edd01257657bc3a1e3045c8036754e55fb25aa568::wormhole_token_bridge_resolver {
    struct WORMHOLE_TOKEN_BRIDGE_RESOLVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORMHOLE_TOKEN_BRIDGE_RESOLVER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<WORMHOLE_TOKEN_BRIDGE_RESOLVER>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

