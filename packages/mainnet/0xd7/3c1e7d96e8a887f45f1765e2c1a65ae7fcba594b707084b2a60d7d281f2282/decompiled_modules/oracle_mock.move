module 0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::oracle_mock {
    public fun convert_sui_to_buck(arg0: u64) : u64 {
        arg0 * 1500 / 1000
    }

    public fun get_sui_price_buck() : u64 {
        1500
    }

    // decompiled from Move bytecode v6
}

