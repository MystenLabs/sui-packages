module 0x78c2a704f1d2491e261cd64e7a163bccd4677d0db132b75338a8b51c12af548f::genesis {
    struct GENESIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENESIS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<GENESIS>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

