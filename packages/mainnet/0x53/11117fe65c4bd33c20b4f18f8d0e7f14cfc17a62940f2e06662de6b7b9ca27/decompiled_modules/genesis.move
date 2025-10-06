module 0x5311117fe65c4bd33c20b4f18f8d0e7f14cfc17a62940f2e06662de6b7b9ca27::genesis {
    struct GENESIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENESIS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<GENESIS>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

