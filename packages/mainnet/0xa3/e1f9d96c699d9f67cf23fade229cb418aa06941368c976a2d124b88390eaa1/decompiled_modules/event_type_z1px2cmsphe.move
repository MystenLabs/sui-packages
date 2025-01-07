module 0xa3e1f9d96c699d9f67cf23fade229cb418aa06941368c976a2d124b88390eaa1::event_type_z1px2cmsphe {
    struct EVENT_TYPE_Z1PX2CMSPHE has drop {
        dummy_field: bool,
    }

    struct EventType_h6a6s4r8w6 has store {
        dummy_field: bool,
    }

    fun init(arg0: EVENT_TYPE_Z1PX2CMSPHE, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<EVENT_TYPE_Z1PX2CMSPHE, EventType_h6a6s4r8w6>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

