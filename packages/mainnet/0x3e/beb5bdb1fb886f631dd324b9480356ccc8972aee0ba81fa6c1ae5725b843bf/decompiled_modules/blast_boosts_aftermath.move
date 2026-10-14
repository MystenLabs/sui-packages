module 0x4f46747d8cb5ea590953ff1847301dfe5a287519d32c1610b35810aab082e50::blast_boosts_aftermath {
    struct BLAST_BOOSTS_AFTERMATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST_BOOSTS_AFTERMATH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<BLAST_BOOSTS_AFTERMATH>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

