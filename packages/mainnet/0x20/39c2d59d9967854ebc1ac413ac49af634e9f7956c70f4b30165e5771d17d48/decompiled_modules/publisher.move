module 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::publisher {
    struct PUBLISHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUBLISHER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PUBLISHER>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

