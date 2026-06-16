module 0x65626bac42a446a5f9942bc876d9dfe888d37b1e62812efc5631b24580e8ffa0::package {
    struct PACKAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PACKAGE>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

