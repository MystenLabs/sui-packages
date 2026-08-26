module 0x55eda9bb471a873cf8e0ebdfd45b86f34a46b4c7fbfe27d81d391d4b8943f471::era {
    struct RuntimeV1 has drop {
        dummy_field: bool,
    }

    struct WorkAdmissionV1 has copy, drop, store {
        dummy_field: bool,
    }

    struct V1 has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun runtime_v1() : RuntimeV1 {
        RuntimeV1{dummy_field: false}
    }

    public(friend) fun v1() : V1 {
        V1{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

