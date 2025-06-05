module 0xf9beba0ba21312766d4432bfb21a1fde93a956def853fd2371ab8da42bee6329::dex_cetus {
    public fun get_fee_rate() : u64 {
        0xf9beba0ba21312766d4432bfb21a1fde93a956def853fd2371ab8da42bee6329::constants::cetus_fee_rate()
    }

    public fun get_package_address() : address {
        @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb
    }

    public fun real_swap(arg0: u64) : u64 {
        simulate_swap(arg0)
    }

    public fun simulate_swap(arg0: u64) : u64 {
        arg0 * 997 / 1000
    }

    // decompiled from Move bytecode v6
}

