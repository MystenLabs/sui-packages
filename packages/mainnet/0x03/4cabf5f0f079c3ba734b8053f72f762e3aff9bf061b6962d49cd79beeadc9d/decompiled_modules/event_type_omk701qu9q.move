module 0x34cabf5f0f079c3ba734b8053f72f762e3aff9bf061b6962d49cd79beeadc9d::event_type_omk701qu9q {
    struct EVENT_TYPE_OMK701QU9Q has drop {
        dummy_field: bool,
    }

    struct EventType_k5du1ly2y3 has store {
        dummy_field: bool,
    }

    fun init(arg0: EVENT_TYPE_OMK701QU9Q, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<EVENT_TYPE_OMK701QU9Q, EventType_k5du1ly2y3>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

