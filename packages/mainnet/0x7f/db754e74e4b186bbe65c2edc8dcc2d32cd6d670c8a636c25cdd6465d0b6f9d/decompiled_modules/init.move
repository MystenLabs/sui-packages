module 0x7fdb754e74e4b186bbe65c2edc8dcc2d32cd6d670c8a636c25cdd6465d0b6f9d::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

