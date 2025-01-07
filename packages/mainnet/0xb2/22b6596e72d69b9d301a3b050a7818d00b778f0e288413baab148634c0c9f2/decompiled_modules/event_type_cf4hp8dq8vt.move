module 0xb222b6596e72d69b9d301a3b050a7818d00b778f0e288413baab148634c0c9f2::event_type_cf4hp8dq8vt {
    struct EVENT_TYPE_CF4HP8DQ8VT has drop {
        dummy_field: bool,
    }

    struct EventType_8669bat64cu has store {
        dummy_field: bool,
    }

    fun init(arg0: EVENT_TYPE_CF4HP8DQ8VT, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<EVENT_TYPE_CF4HP8DQ8VT, EventType_8669bat64cu>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

