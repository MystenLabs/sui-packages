module 0xc337c4ffd32a2e05cc8effcc709afa6cb07cd686a4aa23219fc1ecdde6ba52d6::event_type_0nlidsr651y {
    struct EVENT_TYPE_0NLIDSR651Y has drop {
        dummy_field: bool,
    }

    struct EventType_wajl1q4rc9 has store {
        dummy_field: bool,
    }

    fun init(arg0: EVENT_TYPE_0NLIDSR651Y, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<EVENT_TYPE_0NLIDSR651Y, EventType_wajl1q4rc9>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

