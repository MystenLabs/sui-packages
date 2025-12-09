module 0x2481944ed83176cf7e63308cce283e2134a35b18630863720429709122f5ccf4::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2481944ed83176cf7e63308cce283e2134a35b18630863720429709122f5ccf4::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

