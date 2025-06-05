module 0x1dee7145893487ec3ac654d4c458c723c1ec9d25c066f686d7559688d9535f57::dex_bluefin {
    public fun get_fee_rate() : u64 {
        0x1dee7145893487ec3ac654d4c458c723c1ec9d25c066f686d7559688d9535f57::constants::bluefin_fee_rate()
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

