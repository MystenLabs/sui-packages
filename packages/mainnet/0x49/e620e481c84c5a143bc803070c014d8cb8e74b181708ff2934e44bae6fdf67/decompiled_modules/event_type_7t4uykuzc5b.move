module 0x49e620e481c84c5a143bc803070c014d8cb8e74b181708ff2934e44bae6fdf67::event_type_7t4uykuzc5b {
    struct EVENT_TYPE_7T4UYKUZC5B has drop {
        dummy_field: bool,
    }

    struct EventType_s2qnn6v9y5k has store {
        dummy_field: bool,
    }

    fun init(arg0: EVENT_TYPE_7T4UYKUZC5B, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<EVENT_TYPE_7T4UYKUZC5B, EventType_s2qnn6v9y5k>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

