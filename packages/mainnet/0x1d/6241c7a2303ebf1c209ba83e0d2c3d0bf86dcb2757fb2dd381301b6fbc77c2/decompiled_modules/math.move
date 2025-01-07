module 0x1d6241c7a2303ebf1c209ba83e0d2c3d0bf86dcb2757fb2dd381301b6fbc77c2::math {
    public(friend) fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 501);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

