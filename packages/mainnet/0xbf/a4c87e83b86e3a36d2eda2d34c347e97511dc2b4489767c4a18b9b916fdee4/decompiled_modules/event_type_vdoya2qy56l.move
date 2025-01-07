module 0xbfa4c87e83b86e3a36d2eda2d34c347e97511dc2b4489767c4a18b9b916fdee4::event_type_vdoya2qy56l {
    struct EVENT_TYPE_VDOYA2QY56L has drop {
        dummy_field: bool,
    }

    struct EventType_2l1ig4bwdds has store {
        dummy_field: bool,
    }

    fun init(arg0: EVENT_TYPE_VDOYA2QY56L, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<EVENT_TYPE_VDOYA2QY56L, EventType_2l1ig4bwdds>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

