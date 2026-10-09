module 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::shares {
    public fun mint(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        assert!(arg2 > 0, 100);
        0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div(arg0, arg1, arg2)
    }

    public fun redeem(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 <= arg1, 101);
        if (arg0 == 0) {
            return 0
        };
        0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div(arg0, arg2, arg1)
    }

    // decompiled from Move bytecode v7
}

