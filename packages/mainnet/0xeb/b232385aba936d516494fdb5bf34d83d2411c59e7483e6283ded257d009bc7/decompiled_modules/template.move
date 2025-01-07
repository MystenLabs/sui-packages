module 0xebb232385aba936d516494fdb5bf34d83d2411c59e7483e6283ded257d009bc7::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    struct Template has store {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<TEMPLATE, Template>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

