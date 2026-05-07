module 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::version_control {
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

