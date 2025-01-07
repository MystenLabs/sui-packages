module 0xa9d4ab945276e64cfc25ed5244e79897ea6e2ca83c16cc436c4034b74f882d9b::event_type_4lvudv9xtma {
    struct EVENT_TYPE_4LVUDV9XTMA has drop {
        dummy_field: bool,
    }

    struct EventType_50enzv8ywbc has store {
        dummy_field: bool,
    }

    fun init(arg0: EVENT_TYPE_4LVUDV9XTMA, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<EVENT_TYPE_4LVUDV9XTMA, EventType_50enzv8ywbc>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

