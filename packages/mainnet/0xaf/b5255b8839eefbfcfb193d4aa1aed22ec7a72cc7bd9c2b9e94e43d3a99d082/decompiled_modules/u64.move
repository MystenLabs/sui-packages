module 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

