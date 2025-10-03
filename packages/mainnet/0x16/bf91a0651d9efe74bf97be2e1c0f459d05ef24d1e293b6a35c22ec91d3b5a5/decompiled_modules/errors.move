module 0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::errors {
    public fun decimals() : u8 {
        6
    }

    public fun is_fresh(arg0: u64, arg1: u64) : bool {
        arg1 >= arg0 && arg1 - arg0 <= 300000
    }

    public fun is_valid_price(arg0: u64) : bool {
        arg0 >= 100000 && arg0 <= 1000000000
    }

    public fun max_age_ms() : u64 {
        300000
    }

    public fun max_price() : u64 {
        1000000000
    }

    public fun min_price() : u64 {
        100000
    }

    public fun not_authorized() : u64 {
        1
    }

    public fun price_invalid() : u64 {
        3
    }

    public fun price_stale() : u64 {
        2
    }

    public fun scale() : u64 {
        1000000
    }

    // decompiled from Move bytecode v6
}

