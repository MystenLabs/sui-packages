module 0x8d64bd26919b6bf6d8c4c76baef29a64640bb0970a680e814bd9c3a99eed7555::math {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

