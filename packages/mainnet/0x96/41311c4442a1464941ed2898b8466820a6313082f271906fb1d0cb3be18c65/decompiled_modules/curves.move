module 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::curves {
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
        assert!(is_curve<T0>(), 0x9641311c4442a1464941ed2898b8466820a6313082f271906fb1d0cb3be18c65::errors::invalid_curve());
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

