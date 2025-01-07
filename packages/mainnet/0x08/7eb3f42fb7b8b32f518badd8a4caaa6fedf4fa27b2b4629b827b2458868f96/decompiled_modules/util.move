module 0x87eb3f42fb7b8b32f518badd8a4caaa6fedf4fa27b2b4629b827b2458868f96::util {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 18446744073709551615, 0x87eb3f42fb7b8b32f518badd8a4caaa6fedf4fa27b2b4629b827b2458868f96::error_code::mul_div_overflow());
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

