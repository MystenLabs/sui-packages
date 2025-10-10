module 0x4dae80280a095d9319646896ff655d46b62f16781e81528baa48734d91b9dce5::wormhole_token_bridge_resolver {
    struct WORMHOLE_TOKEN_BRIDGE_RESOLVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORMHOLE_TOKEN_BRIDGE_RESOLVER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<WORMHOLE_TOKEN_BRIDGE_RESOLVER>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

