module 0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

