module 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::version_control {
    struct V__0_1_2 has copy, drop, store {
        dummy_field: bool,
    }

    struct V__0_1_1 has copy, drop, store {
        dummy_field: bool,
    }

    struct V__DUMMY has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun current_version() : V__0_1_2 {
        V__0_1_2{dummy_field: false}
    }

    public(friend) fun previous_version() : V__0_1_1 {
        V__0_1_1{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

