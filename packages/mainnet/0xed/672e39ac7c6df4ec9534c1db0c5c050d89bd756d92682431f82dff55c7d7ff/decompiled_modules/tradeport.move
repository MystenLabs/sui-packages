module 0xed672e39ac7c6df4ec9534c1db0c5c050d89bd756d92682431f82dff55c7d7ff::tradeport {
    struct TRADEPORT has drop {
        dummy_field: bool,
    }

    struct UC has drop, store {
        dummy_field: bool,
    }

    fun init(arg0: TRADEPORT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<TRADEPORT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

