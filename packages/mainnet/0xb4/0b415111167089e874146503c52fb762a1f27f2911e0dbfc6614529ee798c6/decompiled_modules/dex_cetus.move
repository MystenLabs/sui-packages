module 0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_cetus {
    public fun get_fee_rate() : u64 {
        0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::constants::cetus_fee_rate()
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

