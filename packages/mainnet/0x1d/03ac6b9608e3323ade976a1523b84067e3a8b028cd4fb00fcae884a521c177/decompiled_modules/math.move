module 0xd5e2aa1ef1ef77dc37085d0c8f32d4f4863da46cdb430322d2aed41f336d8f4c::math {
    public(friend) fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 501);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

