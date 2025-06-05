module 0xf9beba0ba21312766d4432bfb21a1fde93a956def853fd2371ab8da42bee6329::dex_flowx {
    public fun get_fee_rate() : u64 {
        0xf9beba0ba21312766d4432bfb21a1fde93a956def853fd2371ab8da42bee6329::constants::flowx_fee_rate()
    }

    public fun get_package_address() : address {
        @0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0
    }

    public fun real_swap(arg0: u64) : u64 {
        simulate_swap(arg0)
    }

    public fun simulate_swap(arg0: u64) : u64 {
        arg0 * 9975 / 10000
    }

    // decompiled from Move bytecode v6
}

