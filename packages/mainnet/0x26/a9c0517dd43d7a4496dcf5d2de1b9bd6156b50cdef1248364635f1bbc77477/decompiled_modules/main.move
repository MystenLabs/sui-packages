module 0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::main {
    struct MAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MAIN>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

