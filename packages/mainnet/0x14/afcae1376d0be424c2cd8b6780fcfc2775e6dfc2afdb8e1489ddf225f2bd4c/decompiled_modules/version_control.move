module 0x14afcae1376d0be424c2cd8b6780fcfc2775e6dfc2afdb8e1489ddf225f2bd4c::version_control {
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

