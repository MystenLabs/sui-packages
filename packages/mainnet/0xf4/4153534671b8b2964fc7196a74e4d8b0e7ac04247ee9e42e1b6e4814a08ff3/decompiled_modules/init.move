module 0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

