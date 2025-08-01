module 0xc5c27874c0b6863ec224c1da034fc35f1093295c30e5239530c98726fcafa5c1::genesis {
    struct GENESIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENESIS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<GENESIS>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

