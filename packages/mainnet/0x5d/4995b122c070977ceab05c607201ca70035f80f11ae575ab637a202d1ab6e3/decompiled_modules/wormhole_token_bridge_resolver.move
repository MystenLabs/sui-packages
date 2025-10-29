module 0x5d4995b122c070977ceab05c607201ca70035f80f11ae575ab637a202d1ab6e3::wormhole_token_bridge_resolver {
    struct WORMHOLE_TOKEN_BRIDGE_RESOLVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORMHOLE_TOKEN_BRIDGE_RESOLVER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<WORMHOLE_TOKEN_BRIDGE_RESOLVER>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

