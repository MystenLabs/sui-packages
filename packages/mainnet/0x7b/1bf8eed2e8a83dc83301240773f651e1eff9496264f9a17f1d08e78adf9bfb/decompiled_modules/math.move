module 0x7b1bf8eed2e8a83dc83301240773f651e1eff9496264f9a17f1d08e78adf9bfb::math {
    public fun compute_weight(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg1 >= arg2 && arg1 <= arg3, 1);
        let v0 = mul_factor(arg0, arg1, arg3);
        assert!(v0 > 0, 2);
        v0
    }

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

