module 0x6d2f8a3ad69d155806abb4297b748673e24e236ebfb1fb887c91cdfc0791765c::math {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 501);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

