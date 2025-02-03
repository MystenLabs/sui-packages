module 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::version_control {
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

