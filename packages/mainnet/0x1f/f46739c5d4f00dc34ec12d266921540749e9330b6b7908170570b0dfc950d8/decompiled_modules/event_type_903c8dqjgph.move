module 0x1ff46739c5d4f00dc34ec12d266921540749e9330b6b7908170570b0dfc950d8::event_type_903c8dqjgph {
    struct EVENT_TYPE_903C8DQJGPH has drop {
        dummy_field: bool,
    }

    struct EventType_zca3ev0hc48 has store {
        dummy_field: bool,
    }

    fun init(arg0: EVENT_TYPE_903C8DQJGPH, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<EVENT_TYPE_903C8DQJGPH, EventType_zca3ev0hc48>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

