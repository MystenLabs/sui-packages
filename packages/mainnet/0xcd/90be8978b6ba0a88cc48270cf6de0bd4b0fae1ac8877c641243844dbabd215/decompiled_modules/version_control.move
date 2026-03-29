module 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::version_control {
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

