module 0x82a3cd0331a08d7946ef7fa4759732df6d60558696e93f78c005c916032c2508::version_control {
    struct V__1_0_0 has copy, drop, store {
        dummy_field: bool,
    }

    struct V__DUMMY has copy, drop, store {
        dummy_field: bool,
    }

    public fun current_version() : V__1_0_0 {
        V__1_0_0{dummy_field: false}
    }

    public fun previous_version() : V__DUMMY {
        V__DUMMY{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

