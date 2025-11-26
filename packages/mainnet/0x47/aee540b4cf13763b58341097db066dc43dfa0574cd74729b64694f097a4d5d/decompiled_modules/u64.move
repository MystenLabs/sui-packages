module 0x47aee540b4cf13763b58341097db066dc43dfa0574cd74729b64694f097a4d5d::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x47aee540b4cf13763b58341097db066dc43dfa0574cd74729b64694f097a4d5d::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

