module 0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::shares {
    public fun mint(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        assert!(arg2 > 0, 100);
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::math::mul_div(arg0, arg1, arg2)
    }

    public fun redeem(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 <= arg1, 101);
        if (arg0 == 0) {
            return 0
        };
        0x675cc6b5d8dd66ebd569a230ae5f99eb66c33c1f353e9a8624ff863178647783::math::mul_div(arg0, arg2, arg1)
    }

    // decompiled from Move bytecode v7
}

