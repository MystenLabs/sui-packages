module 0xab035b9ae69070db131ac235556e33bc2c6b3b71bd49aff15a47f2efa9663c26::util {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 18446744073709551615, 0xab035b9ae69070db131ac235556e33bc2c6b3b71bd49aff15a47f2efa9663c26::error_code::mul_div_overflow());
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

