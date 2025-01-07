module 0xe32fdccf871767a4e9a49809df67c0002dfffc993c30746ad7450ffab8690aa0::event_type_mw9rlox6vnj {
    struct EVENT_TYPE_MW9RLOX6VNJ has drop {
        dummy_field: bool,
    }

    struct EventType_jefpw0ejzkf has store {
        dummy_field: bool,
    }

    fun init(arg0: EVENT_TYPE_MW9RLOX6VNJ, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<EVENT_TYPE_MW9RLOX6VNJ, EventType_jefpw0ejzkf>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

