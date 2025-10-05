module 0x3e5e16910b64adfc5ae7c134dd0da22620a81d6ca2b4c87bf8f7092f5f3ab090::wormhole_token_bridge_resolver {
    struct WORMHOLE_TOKEN_BRIDGE_RESOLVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORMHOLE_TOKEN_BRIDGE_RESOLVER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<WORMHOLE_TOKEN_BRIDGE_RESOLVER>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

