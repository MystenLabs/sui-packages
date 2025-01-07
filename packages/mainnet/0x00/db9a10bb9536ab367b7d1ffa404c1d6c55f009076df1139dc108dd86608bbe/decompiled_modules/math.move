module 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math {
    public fun mul_factor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        ((((arg0 as u128) * (arg1 as u128) + (arg2 as u128) / 2) / (arg2 as u128)) as u64)
    }

    public fun mul_factor_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 0);
        (arg0 * arg1 + arg2 / 2) / arg2
    }

    // decompiled from Move bytecode v6
}

