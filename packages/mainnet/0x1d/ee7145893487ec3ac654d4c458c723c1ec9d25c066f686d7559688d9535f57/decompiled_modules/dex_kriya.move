module 0x1dee7145893487ec3ac654d4c458c723c1ec9d25c066f686d7559688d9535f57::dex_kriya {
    public fun get_fee_rate() : u64 {
        0x1dee7145893487ec3ac654d4c458c723c1ec9d25c066f686d7559688d9535f57::constants::kriya_fee_rate()
    }

    public fun get_package_address() : address {
        @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66
    }

    public fun real_swap(arg0: u64) : u64 {
        simulate_swap(arg0)
    }

    public fun simulate_swap(arg0: u64) : u64 {
        arg0 * 9975 / 10000
    }

    // decompiled from Move bytecode v6
}

