module 0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::curve {
    struct Stable {
        dummy_field: bool,
    }

    struct Volatile {
        dummy_field: bool,
    }

    public fun is_curve<T0>() : bool {
        0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::utils::are_types_equal<Volatile, T0>() || 0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::utils::are_types_equal<Stable, T0>()
    }

    public fun is_volatile<T0>() : bool {
        0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::utils::are_types_equal<Volatile, T0>()
    }

    // decompiled from Move bytecode v6
}

