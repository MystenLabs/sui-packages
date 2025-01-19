module 0x9193d45dad53d69b83728cc015e398196fc7a35c06f1e758dfd5f71c51cf6edc::math {
    public fun compute_net_multiplier(arg0: u64, arg1: u64) : u64 {
        mul_factor(arg0, arg1, 1000000000)
    }

    public fun compute_stake_weight(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u128, u64, u64) {
        let v0 = compute_time_multiplier(arg1, arg2, arg3, arg4);
        let v1 = compute_net_multiplier(v0, arg5);
        let v2 = mul_factor_u128((arg0 as u128), (v1 as u128), (1000000000 as u128));
        assert!(v2 < 340282366920938463463374607431768211455, 2);
        assert!(v2 > 0, 2);
        assert!(v1 > 0, 2);
        assert!(v0 > 0, 2);
        (v2, v1, v0)
    }

    public fun compute_time_multiplier(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 >= arg1 && arg0 <= arg2, 1);
        mul_factor(arg3, arg0, arg2)
    }

    public fun mul_factor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        ((((arg0 as u128) * (arg1 as u128) + (arg2 as u128) / 2) / (arg2 as u128)) as u64)
    }

    public fun mul_factor_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 0);
        (arg0 * arg1 + arg2 / 2) / arg2
    }

    public fun multiplier_scale() : u64 {
        1000000000
    }

    // decompiled from Move bytecode v6
}

