module 0x41b3713f630b638bdf8a42786eed42002822b2b67bb23a1b778857e412a8047b::demo_event_type {
    struct DEMO_EVENT_TYPE has drop {
        dummy_field: bool,
    }

    struct DemoEventType has store {
        dummy_field: bool,
    }

    fun init(arg0: DEMO_EVENT_TYPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<DEMO_EVENT_TYPE, DemoEventType>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

