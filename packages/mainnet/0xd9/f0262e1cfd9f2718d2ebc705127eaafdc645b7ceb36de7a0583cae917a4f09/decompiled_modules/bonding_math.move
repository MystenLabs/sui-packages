module 0xd9f0262e1cfd9f2718d2ebc705127eaafdc645b7ceb36de7a0583cae917a4f09::bonding_math {
    public fun k(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun sui_out(arg0: u64, arg1: u64, arg2: u64, arg3: u128) : u64 {
        let v0 = (arg1 as u128) + (arg2 as u128);
        assert!(v0 > 0, 0);
        (((arg0 as u128) - arg3 / v0) as u64)
    }

    public fun tokens_out(arg0: u64, arg1: u64, arg2: u64, arg3: u128) : u64 {
        let v0 = (arg0 as u128) + (arg2 as u128);
        assert!(v0 > 0, 0);
        (((arg1 as u128) - arg3 / v0) as u64)
    }

    // decompiled from Move bytecode v7
}

