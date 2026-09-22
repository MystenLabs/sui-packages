module 0xe73dbefa2da18eb4cb10e8c902896fa139159c05a3b7c042a028b4c3ee8d475e::blast_boosts_aftermath {
    struct BLAST_BOOSTS_AFTERMATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST_BOOSTS_AFTERMATH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<BLAST_BOOSTS_AFTERMATH>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

