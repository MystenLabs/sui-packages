module 0xfd0d10a05b9e4651c647adab3596fe0075b3ce26a7fe3b97c302a604da3a646a::staking_math {
    public fun compute_weight(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg1 >= arg2 && arg1 <= arg3, 1);
        let v0 = mul_factor(arg0, arg1, arg3);
        assert!(v0 > 0, 2);
        v0
    }

    public fun mul_factor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        ((((arg0 as u256) * (arg1 as u256) + (arg2 as u256) / 2) / (arg2 as u256)) as u64)
    }

    public fun mul_factor_u256(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 > 0, 0);
        (arg0 * arg1 + arg2 / 2) / arg2
    }

    // decompiled from Move bytecode v6
}

