module 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::shares {
    public fun mint(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        assert!(arg2 > 0, 100);
        0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::math::mul_div(arg0, arg1, arg2)
    }

    public fun redeem(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 <= arg1, 101);
        if (arg0 == 0) {
            return 0
        };
        0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::math::mul_div(arg0, arg2, arg1)
    }

    // decompiled from Move bytecode v7
}

