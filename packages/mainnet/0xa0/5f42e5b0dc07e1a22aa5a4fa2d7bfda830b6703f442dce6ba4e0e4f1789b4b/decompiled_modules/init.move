module 0xa05f42e5b0dc07e1a22aa5a4fa2d7bfda830b6703f442dce6ba4e0e4f1789b4b::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

