module 0x6690c61e46673046c87c62e1f295fc5a1582bb4be226b5f8fdb63b329a7014ae::math {
    public fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 100);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 101);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

