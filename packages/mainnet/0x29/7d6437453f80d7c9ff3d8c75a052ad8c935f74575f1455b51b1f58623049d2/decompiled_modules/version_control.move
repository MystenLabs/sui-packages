module 0x297d6437453f80d7c9ff3d8c75a052ad8c935f74575f1455b51b1f58623049d2::version_control {
    struct V__1_0_0 has copy, drop, store {
        dummy_field: bool,
    }

    struct V__1_1_0 has copy, drop, store {
        dummy_field: bool,
    }

    struct V__DUMMY has copy, drop, store {
        dummy_field: bool,
    }

    public fun current_version() : V__1_1_0 {
        V__1_1_0{dummy_field: false}
    }

    public fun previous_version() : V__1_0_0 {
        V__1_0_0{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

