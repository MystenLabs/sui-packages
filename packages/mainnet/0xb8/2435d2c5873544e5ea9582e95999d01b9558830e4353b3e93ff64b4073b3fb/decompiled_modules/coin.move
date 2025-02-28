module 0xb82435d2c5873544e5ea9582e95999d01b9558830e4353b3e93ff64b4073b3fb::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<COIN> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

