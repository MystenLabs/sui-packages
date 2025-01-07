module 0x5bb24124c2b09a6b438ddd96bf32596e206e91fef1db757a1fa023627bfeec6e::event_type_bbfupl231st {
    struct EVENT_TYPE_BBFUPL231ST has drop {
        dummy_field: bool,
    }

    struct EventType_jr27u867wtl has store {
        dummy_field: bool,
    }

    fun init(arg0: EVENT_TYPE_BBFUPL231ST, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<EVENT_TYPE_BBFUPL231ST, EventType_jr27u867wtl>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

