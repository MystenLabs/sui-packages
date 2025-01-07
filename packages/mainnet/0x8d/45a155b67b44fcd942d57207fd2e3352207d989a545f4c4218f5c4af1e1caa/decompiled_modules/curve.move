module 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve {
    struct Stable {
        dummy_field: bool,
    }

    struct Volatile {
        dummy_field: bool,
    }

    public fun is_curve<T0>() : bool {
        0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::are_types_equal<Volatile, T0>() || 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::are_types_equal<Stable, T0>()
    }

    public fun is_volatile<T0>() : bool {
        0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::are_types_equal<Volatile, T0>()
    }

    // decompiled from Move bytecode v6
}

