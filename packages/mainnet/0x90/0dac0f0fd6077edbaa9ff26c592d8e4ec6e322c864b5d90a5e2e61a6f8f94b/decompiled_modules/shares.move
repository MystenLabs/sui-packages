module 0x900dac0f0fd6077edbaa9ff26c592d8e4ec6e322c864b5d90a5e2e61a6f8f94b::shares {
    public fun mint(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        assert!(arg2 > 0, 100);
        0x900dac0f0fd6077edbaa9ff26c592d8e4ec6e322c864b5d90a5e2e61a6f8f94b::math::mul_div(arg0, arg1, arg2)
    }

    public fun redeem(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 <= arg1, 101);
        if (arg0 == 0) {
            return 0
        };
        0x900dac0f0fd6077edbaa9ff26c592d8e4ec6e322c864b5d90a5e2e61a6f8f94b::math::mul_div(arg0, arg2, arg1)
    }

    // decompiled from Move bytecode v7
}

