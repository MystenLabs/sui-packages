module 0x14a4350a95c434c3b1f3913cc0a35d67e220d40623db677dd16108a9ce3574ed::atoma {
    struct ATOMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATOMA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ATOMA>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

