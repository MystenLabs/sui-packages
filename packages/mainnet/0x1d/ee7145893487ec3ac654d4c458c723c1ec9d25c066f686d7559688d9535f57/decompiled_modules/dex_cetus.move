module 0x1dee7145893487ec3ac654d4c458c723c1ec9d25c066f686d7559688d9535f57::dex_cetus {
    public fun get_fee_rate() : u64 {
        0x1dee7145893487ec3ac654d4c458c723c1ec9d25c066f686d7559688d9535f57::constants::cetus_fee_rate()
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

