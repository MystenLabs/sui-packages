module 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::curves {
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
        if (is_weighted<T0>()) {
            true
        } else if (is_stable<T0>()) {
            true
        } else {
            is_curved<T0>()
        }
    }

    public entry fun is_weighted<T0>() : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<Weighted>()
    }

    // decompiled from Move bytecode v6
}

