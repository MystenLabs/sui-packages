module 0x725c6cb7f6c80e59527f64cbd965a4e3a1baab5f42bd7804d7b788f80c685910::bonding_math {
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

