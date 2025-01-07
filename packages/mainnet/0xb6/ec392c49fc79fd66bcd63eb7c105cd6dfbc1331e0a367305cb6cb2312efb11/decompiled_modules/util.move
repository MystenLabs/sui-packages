module 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::util {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 0xb6ec392c49fc79fd66bcd63eb7c105cd6dfbc1331e0a367305cb6cb2312efb11::error_code::mul_div_overflow());
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

