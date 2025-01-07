module 0x496f35b2153a9e72bf6bd842f735877361b0f5bb58bc96e7fba731ff38778a1c::util {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 18446744073709551615, 0x496f35b2153a9e72bf6bd842f735877361b0f5bb58bc96e7fba731ff38778a1c::error_code::mul_div_overflow());
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

