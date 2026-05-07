module 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::version_control {
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

    // decompiled from Move bytecode v7
}

