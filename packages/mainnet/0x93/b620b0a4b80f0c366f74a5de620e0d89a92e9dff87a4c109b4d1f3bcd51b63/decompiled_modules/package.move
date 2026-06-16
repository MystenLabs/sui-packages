module 0x93b620b0a4b80f0c366f74a5de620e0d89a92e9dff87a4c109b4d1f3bcd51b63::package {
    struct PACKAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PACKAGE>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

