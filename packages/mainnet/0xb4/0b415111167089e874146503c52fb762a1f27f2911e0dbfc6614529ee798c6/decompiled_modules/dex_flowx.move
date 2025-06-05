module 0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_flowx {
    public fun get_fee_rate() : u64 {
        0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::constants::flowx_fee_rate()
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

