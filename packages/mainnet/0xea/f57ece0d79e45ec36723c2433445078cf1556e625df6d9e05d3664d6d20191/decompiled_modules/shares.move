module 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::shares {
    public fun mint(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        assert!(arg2 > 0, 100);
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::math::mul_div(arg0, arg1, arg2)
    }

    public fun redeem(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 <= arg1, 101);
        if (arg0 == 0) {
            return 0
        };
        0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::math::mul_div(arg0, arg2, arg1)
    }

    // decompiled from Move bytecode v7
}

