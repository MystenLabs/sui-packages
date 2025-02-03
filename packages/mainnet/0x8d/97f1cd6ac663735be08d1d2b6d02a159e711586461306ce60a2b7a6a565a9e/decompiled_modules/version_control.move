module 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::version_control {
    struct V__0_1_1 has copy, drop, store {
        dummy_field: bool,
    }

    struct V__DUMMY has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun current_version() : V__0_1_1 {
        V__0_1_1{dummy_field: false}
    }

    public(friend) fun previous_version() : V__DUMMY {
        V__DUMMY{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

