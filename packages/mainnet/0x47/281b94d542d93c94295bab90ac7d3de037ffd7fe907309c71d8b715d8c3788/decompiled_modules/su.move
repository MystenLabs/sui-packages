module 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su {
    struct SU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SU, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SU>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

