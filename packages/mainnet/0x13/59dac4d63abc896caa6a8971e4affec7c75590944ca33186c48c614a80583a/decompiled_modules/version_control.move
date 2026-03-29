module 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::version_control {
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

