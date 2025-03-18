module 0x1df8f1e1f626d1b077fda4de72fbb22e866b5206fbe3736aae51cf21298071d7::scallop_math_u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x1df8f1e1f626d1b077fda4de72fbb22e866b5206fbe3736aae51cf21298071d7::scallop_math_u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 9223372101279285249);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

