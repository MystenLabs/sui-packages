module 0xd4fb2e437fced7e72980f9c6f9a86935b3d3b7f533ef4b3af07a8ce003f80d1d::package {
    struct PACKAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PACKAGE>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

