module 0x2ac072e727c618d35fa23dee58b9f2edfa7d1c39125746e878a4eabfb418b76c::util {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 18446744073709551615, 0x2ac072e727c618d35fa23dee58b9f2edfa7d1c39125746e878a4eabfb418b76c::error_code::mul_div_overflow());
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

