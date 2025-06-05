module 0x1dee7145893487ec3ac654d4c458c723c1ec9d25c066f686d7559688d9535f57::dex_aftermath {
    public fun get_fee_rate() : u64 {
        0x1dee7145893487ec3ac654d4c458c723c1ec9d25c066f686d7559688d9535f57::constants::aftermath_fee_rate()
    }

    public fun get_package_address() : address {
        @0x538a63ce76fde26c90874ab1e7640b07a5422e03dad1011628debf3f0fb26a56
    }

    public fun real_swap(arg0: u64) : u64 {
        simulate_swap(arg0)
    }

    public fun simulate_swap(arg0: u64) : u64 {
        arg0 * 997 / 1000
    }

    // decompiled from Move bytecode v6
}

