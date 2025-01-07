module 0x5e74cc4bdff46653548b6272eab7a9e9f0ef0e3d5461dc660d259cc2026a65c5::event_type_gr7s2wsdgtm {
    struct EVENT_TYPE_GR7S2WSDGTM has drop {
        dummy_field: bool,
    }

    struct EventType_r9w796hzvbm has store {
        dummy_field: bool,
    }

    fun init(arg0: EVENT_TYPE_GR7S2WSDGTM, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<EVENT_TYPE_GR7S2WSDGTM, EventType_r9w796hzvbm>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

