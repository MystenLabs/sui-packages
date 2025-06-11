module 0x1573ae1086d9b62cf34044f626d9dfcc910dae7c0db9e2d951edde75b0c7847a::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x1573ae1086d9b62cf34044f626d9dfcc910dae7c0db9e2d951edde75b0c7847a::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

