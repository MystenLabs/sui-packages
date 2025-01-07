module 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::atoma {
    struct ATOMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATOMA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ATOMA>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

