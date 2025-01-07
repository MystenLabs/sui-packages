module 0x9f1105f1c9d0120a50f154525ee4cbc3ac4387ee6fa078613139e76f2bbe78a4::curves {
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
        assert!(is_curve<T0>(), 0x9f1105f1c9d0120a50f154525ee4cbc3ac4387ee6fa078613139e76f2bbe78a4::errors::invalid_curve());
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

