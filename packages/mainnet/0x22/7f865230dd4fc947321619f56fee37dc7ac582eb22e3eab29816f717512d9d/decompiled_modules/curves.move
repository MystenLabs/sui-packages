module 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves {
    struct Uncorrelated {
        dummy_field: bool,
    }

    struct Stable {
        dummy_field: bool,
    }

    public fun assert_valid_curve<T0>() {
        assert!(is_valid_curve<T0>(), 10001);
    }

    public fun get_type_name<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    public fun is_stable<T0>() : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<Stable>()
    }

    public fun is_uncorrelated<T0>() : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<Uncorrelated>()
    }

    public fun is_valid_curve<T0>() : bool {
        is_uncorrelated<T0>() || is_stable<T0>()
    }

    // decompiled from Move bytecode v6
}

