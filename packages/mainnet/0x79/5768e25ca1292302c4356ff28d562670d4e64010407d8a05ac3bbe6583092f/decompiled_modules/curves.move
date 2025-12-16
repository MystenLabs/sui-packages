module 0x795768e25ca1292302c4356ff28d562670d4e64010407d8a05ac3bbe6583092f::curves {
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

    public fun is_curved<T0>() : bool {
        0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<Curved>()
    }

    public fun is_stable<T0>() : bool {
        0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<Stable>()
    }

    public fun is_valid_curve<T0>() : bool {
        if (is_weighted<T0>()) {
            true
        } else if (is_stable<T0>()) {
            true
        } else {
            is_curved<T0>()
        }
    }

    public fun is_weighted<T0>() : bool {
        0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<Weighted>()
    }

    // decompiled from Move bytecode v6
}

