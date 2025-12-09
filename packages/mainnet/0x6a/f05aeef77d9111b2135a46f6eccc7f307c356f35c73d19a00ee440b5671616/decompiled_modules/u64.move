module 0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x6af05aeef77d9111b2135a46f6eccc7f307c356f35c73d19a00ee440b5671616::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

