module 0x6e8a2d35ea74504284f9b86fa258f741a776b731aee47892c26c88c136e31247::shares {
    public fun mint(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        assert!(arg2 > 0, 100);
        0x6e8a2d35ea74504284f9b86fa258f741a776b731aee47892c26c88c136e31247::math::mul_div(arg0, arg1, arg2)
    }

    public fun redeem(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 <= arg1, 101);
        if (arg0 == 0) {
            return 0
        };
        0x6e8a2d35ea74504284f9b86fa258f741a776b731aee47892c26c88c136e31247::math::mul_div(arg0, arg2, arg1)
    }

    // decompiled from Move bytecode v7
}

