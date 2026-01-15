module 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::math {
    public fun div(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) / (arg1 as u128)) as u64)
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

