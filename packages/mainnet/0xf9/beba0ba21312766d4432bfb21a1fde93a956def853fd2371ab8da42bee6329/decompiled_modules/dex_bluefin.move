module 0xf9beba0ba21312766d4432bfb21a1fde93a956def853fd2371ab8da42bee6329::dex_bluefin {
    public fun get_fee_rate() : u64 {
        0xf9beba0ba21312766d4432bfb21a1fde93a956def853fd2371ab8da42bee6329::constants::bluefin_fee_rate()
    }

    public fun get_package_address() : address {
        @0x6c796c3ab3421a68158e0df18e4657b2827b1f8fed5ed4b82dba9c935988711b
    }

    public fun real_swap(arg0: u64) : u64 {
        simulate_swap(arg0)
    }

    public fun simulate_swap(arg0: u64) : u64 {
        arg0 * 997 / 1000
    }

    // decompiled from Move bytecode v6
}

