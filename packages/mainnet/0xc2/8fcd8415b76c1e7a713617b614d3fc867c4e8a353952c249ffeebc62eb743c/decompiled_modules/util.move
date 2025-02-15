module 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::util {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 18446744073709551615, 0xc28fcd8415b76c1e7a713617b614d3fc867c4e8a353952c249ffeebc62eb743c::error_code::mul_div_overflow());
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

