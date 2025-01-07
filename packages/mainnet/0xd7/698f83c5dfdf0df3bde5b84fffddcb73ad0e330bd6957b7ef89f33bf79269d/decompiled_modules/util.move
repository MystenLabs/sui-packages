module 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::util {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 18446744073709551615, 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::error_code::mul_div_overflow());
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

