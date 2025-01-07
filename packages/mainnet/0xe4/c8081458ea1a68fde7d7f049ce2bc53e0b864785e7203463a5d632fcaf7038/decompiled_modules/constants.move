module 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::constants {
    public fun get_default_fee() : (u64, u64) {
        (50, 250)
    }

    public fun get_fee_base_of_percentage() : u64 {
        100000
    }

    public fun get_max_fee() : u64 {
        1000
    }

    public fun get_min_lp_value() : u64 {
        1000
    }

    // decompiled from Move bytecode v6
}

