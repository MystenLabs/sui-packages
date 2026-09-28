module 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::curve {
    public fun initial_k(arg0: u64, arg1: u64) : u128 {
        assert!(arg0 > 0 && arg1 > 0, 202);
        (arg0 as u128) * (arg1 as u128)
    }

    public fun price_buy(arg0: u128, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64) {
        assert!(arg3 > 0, 200);
        let v0 = arg1 + arg3;
        let v1 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::math::to_u64(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::math::div_up_u128(arg0, (v0 as u128)));
        assert!(v1 >= 1, 201);
        let v2 = arg2 - v1;
        assert!(v2 > 0, 200);
        (v2, v0, v1)
    }

    public fun price_sell(arg0: u128, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, u64) {
        assert!(arg3 > 0, 200);
        let v0 = arg2 + arg3;
        let v1 = 0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::math::to_u64(0xeaf57ece0d79e45ec36723c2433445078cf1556e625df6d9e05d3664d6d20191::math::div_up_u128(arg0, (v0 as u128)));
        assert!(v1 >= arg4, 202);
        let v2 = arg1 - v1;
        assert!(v2 > 0, 200);
        (v2, v1, v0)
    }

    public fun spot_shares_e9(arg0: u64, arg1: u64) : u128 {
        assert!(arg1 > 0, 202);
        (arg0 as u128) * 1000000000 / (arg1 as u128)
    }

    // decompiled from Move bytecode v7
}

