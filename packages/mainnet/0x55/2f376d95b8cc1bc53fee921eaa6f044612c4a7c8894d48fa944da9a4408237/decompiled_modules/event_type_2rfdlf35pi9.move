module 0x552f376d95b8cc1bc53fee921eaa6f044612c4a7c8894d48fa944da9a4408237::event_type_2rfdlf35pi9 {
    struct EVENT_TYPE_2RFDLF35PI9 has drop {
        dummy_field: bool,
    }

    struct EventType_io4zf7joud has store {
        dummy_field: bool,
    }

    fun init(arg0: EVENT_TYPE_2RFDLF35PI9, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<EVENT_TYPE_2RFDLF35PI9, EventType_io4zf7joud>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

