module 0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_turbos {
    public fun get_fee_rate() : u64 {
        0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::constants::turbos_fee_rate()
    }

    public fun get_package_address() : address {
        @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
    }

    public fun real_swap(arg0: u64) : u64 {
        simulate_swap(arg0)
    }

    public fun simulate_swap(arg0: u64) : u64 {
        arg0 * 997 / 1000
    }

    // decompiled from Move bytecode v6
}

