module 0x834df46be28b98727ac7fa106160967964e259de8bccc87700aabf4cef7f5cd::version_control {
    struct V__0_2_0 has copy, drop, store {
        dummy_field: bool,
    }

    struct V__DUMMY has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun current_version() : V__0_2_0 {
        V__0_2_0{dummy_field: false}
    }

    public(friend) fun previous_version() : V__DUMMY {
        V__DUMMY{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

