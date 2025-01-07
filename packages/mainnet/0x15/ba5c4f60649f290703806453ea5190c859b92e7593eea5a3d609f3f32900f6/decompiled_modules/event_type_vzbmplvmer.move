module 0x15ba5c4f60649f290703806453ea5190c859b92e7593eea5a3d609f3f32900f6::event_type_vzbmplvmer {
    struct EVENT_TYPE_VZBMPLVMER has drop {
        dummy_field: bool,
    }

    struct EventType_qafagvjis6a has store {
        dummy_field: bool,
    }

    fun init(arg0: EVENT_TYPE_VZBMPLVMER, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<EVENT_TYPE_VZBMPLVMER, EventType_qafagvjis6a>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

