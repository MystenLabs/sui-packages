module 0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::dex_aftermath {
    public fun get_fee_rate() : u64 {
        0xb40b415111167089e874146503c52fb762a1f27f2911e0dbfc6614529ee798c6::constants::aftermath_fee_rate()
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

