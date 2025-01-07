module 0xc102ccf184b17a41f45831ae6b160dc100c4735e9fcff5097ea7f1212285a30c::event_type_1i510yll8sc {
    struct EVENT_TYPE_1I510YLL8SC has drop {
        dummy_field: bool,
    }

    struct EventType_9zy8dw323ej has store {
        dummy_field: bool,
    }

    fun init(arg0: EVENT_TYPE_1I510YLL8SC, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<EVENT_TYPE_1I510YLL8SC, EventType_9zy8dw323ej>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

