module 0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x4832f08c0e5834edb73c8bfd2e5bae8af0be925d63e2e95df8434c2a5d7fd625::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

