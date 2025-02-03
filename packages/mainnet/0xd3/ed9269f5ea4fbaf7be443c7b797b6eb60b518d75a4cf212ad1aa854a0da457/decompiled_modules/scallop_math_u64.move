module 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::scallop_math_u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::scallop_math_u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 9223372101279285249);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

