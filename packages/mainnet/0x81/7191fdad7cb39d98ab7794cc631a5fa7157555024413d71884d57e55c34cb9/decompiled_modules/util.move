module 0x817191fdad7cb39d98ab7794cc631a5fa7157555024413d71884d57e55c34cb9::util {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 18446744073709551615, 0x817191fdad7cb39d98ab7794cc631a5fa7157555024413d71884d57e55c34cb9::error_code::mul_div_overflow());
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

