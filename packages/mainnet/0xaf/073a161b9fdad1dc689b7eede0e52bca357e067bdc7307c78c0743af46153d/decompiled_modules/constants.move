module 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants {
    public fun basis_points_denominator() : u64 {
        10000
    }

    public fun max_lockup_duration_seconds() : u64 {
        2592000
    }

    public fun max_multiplier() : u64 {
        2000
    }

    public fun max_penalty_bps() : u64 {
        10000
    }

    public fun milliseconds_per_second() : u64 {
        1000
    }

    public fun min_multiplier() : u64 {
        100
    }

    public fun multiplier_precision() : u64 {
        100
    }

    public fun precision() : u256 {
        1000000000000000000
    }

    public fun version() : u64 {
        3
    }

    // decompiled from Move bytecode v6
}

