module 0xd66ed70218f27a3684ed2461524f05f42c22cf453cdef2e1047bbec9878800c5::curves {
    struct Weighted {
        dummy_field: bool,
    }

    struct Stable {
        dummy_field: bool,
    }

    struct Curved {
        dummy_field: bool,
    }

    public fun assert_valid_curve<T0>() {
        assert!(is_valid_curve<T0>(), 10001);
    }

    public entry fun is_curved<T0>() : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<Curved>()
    }

    public entry fun is_stable<T0>() : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<Stable>()
    }

    public entry fun is_valid_curve<T0>() : bool {
        is_weighted<T0>() || is_stable<T0>() || is_curved<T0>()
    }

    public entry fun is_weighted<T0>() : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<Weighted>()
    }

    // decompiled from Move bytecode v6
}

