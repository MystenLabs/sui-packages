module 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve {
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

