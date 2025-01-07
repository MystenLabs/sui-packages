module 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

