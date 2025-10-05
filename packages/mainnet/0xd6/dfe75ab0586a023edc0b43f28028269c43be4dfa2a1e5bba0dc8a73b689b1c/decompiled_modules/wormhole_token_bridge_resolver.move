module 0xd6dfe75ab0586a023edc0b43f28028269c43be4dfa2a1e5bba0dc8a73b689b1c::wormhole_token_bridge_resolver {
    struct WORMHOLE_TOKEN_BRIDGE_RESOLVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORMHOLE_TOKEN_BRIDGE_RESOLVER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<WORMHOLE_TOKEN_BRIDGE_RESOLVER>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

