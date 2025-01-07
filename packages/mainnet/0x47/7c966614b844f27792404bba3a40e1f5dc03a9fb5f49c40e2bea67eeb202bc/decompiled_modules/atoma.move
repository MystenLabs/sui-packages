module 0x477c966614b844f27792404bba3a40e1f5dc03a9fb5f49c40e2bea67eeb202bc::atoma {
    struct ATOMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATOMA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ATOMA>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

