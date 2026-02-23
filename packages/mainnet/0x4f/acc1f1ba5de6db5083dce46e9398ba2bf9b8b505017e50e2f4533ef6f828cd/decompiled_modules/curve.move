module 0x4facc1f1ba5de6db5083dce46e9398ba2bf9b8b505017e50e2f4533ef6f828cd::curve {
    struct Stable {
        dummy_field: bool,
    }

    struct Volatile {
        dummy_field: bool,
    }

    public fun is_curve<T0>() : bool {
        0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::are_types_equal<Volatile, T0>() || 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::are_types_equal<Stable, T0>()
    }

    public fun is_volatile<T0>() : bool {
        0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::are_types_equal<Volatile, T0>()
    }

    // decompiled from Move bytecode v6
}

