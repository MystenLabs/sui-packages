module 0xcf0b0803ba11a0c59d241e14e0dd682af207f853b50f5303c2ea081bb4d28251::atoma {
    struct ATOMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATOMA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ATOMA>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

