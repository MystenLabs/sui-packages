module 0xe0c2ed9cff8395b7de922da350145c5e3e9b13a4a39656476b6e6165f9d7f9cd::package {
    struct PACKAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PACKAGE>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

