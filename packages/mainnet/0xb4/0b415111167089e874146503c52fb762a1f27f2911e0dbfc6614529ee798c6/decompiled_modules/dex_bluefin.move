module 0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_bluefin {
    public fun get_fee_rate() : u64 {
        0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::constants::bluefin_fee_rate()
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

