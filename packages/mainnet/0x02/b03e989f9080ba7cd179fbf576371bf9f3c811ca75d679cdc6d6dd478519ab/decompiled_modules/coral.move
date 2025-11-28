module 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral {
    struct CORAL_XCH has drop {
        dummy_field: bool,
    }

    public(friend) fun make_witness() : CORAL_XCH {
        CORAL_XCH{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

