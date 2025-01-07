module 0x8fc663315a07208e86473b808d902c9b97a496a3d2c3779aa6839bd9d26272b8::atoma {
    struct ATOMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATOMA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ATOMA>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

