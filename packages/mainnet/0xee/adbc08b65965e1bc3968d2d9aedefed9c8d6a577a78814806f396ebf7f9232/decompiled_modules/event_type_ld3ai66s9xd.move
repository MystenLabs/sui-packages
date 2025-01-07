module 0xeeadbc08b65965e1bc3968d2d9aedefed9c8d6a577a78814806f396ebf7f9232::event_type_ld3ai66s9xd {
    struct EVENT_TYPE_LD3AI66S9XD has drop {
        dummy_field: bool,
    }

    struct EventType_ytwfa6oks9h has store {
        dummy_field: bool,
    }

    fun init(arg0: EVENT_TYPE_LD3AI66S9XD, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<EVENT_TYPE_LD3AI66S9XD, EventType_ytwfa6oks9h>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

