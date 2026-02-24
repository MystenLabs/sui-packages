module 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::curves {
    struct Volatile {
        dummy_field: bool,
    }

    struct Stable {
        dummy_field: bool,
    }

    fun are_equal<T0, T1>() : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<T1>()
    }

    public fun assert_curve<T0>() {
        assert!(is_curve<T0>(), 0x429dbf2fc849c0b4146db09af38c104ae7a3ed746baf835fa57fee27fa5ff382::errors::invalid_curve());
    }

    public fun is_curve<T0>() : bool {
        is_volatile<T0>() || is_stable<T0>()
    }

    public fun is_stable<T0>() : bool {
        are_equal<T0, Stable>()
    }

    public fun is_volatile<T0>() : bool {
        are_equal<T0, Volatile>()
    }

    // decompiled from Move bytecode v6
}

