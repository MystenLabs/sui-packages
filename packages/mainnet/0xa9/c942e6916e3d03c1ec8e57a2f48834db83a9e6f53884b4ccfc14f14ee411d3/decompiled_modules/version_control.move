module 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::version_control {
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

