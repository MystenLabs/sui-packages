module 0x3a93d96ca9f2cf20317667cdef73dbf74d4fbaf9cd6e09cba54bf8fbd6116455::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

