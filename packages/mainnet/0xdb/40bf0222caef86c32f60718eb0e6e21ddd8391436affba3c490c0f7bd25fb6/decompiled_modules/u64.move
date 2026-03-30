module 0xdb40bf0222caef86c32f60718eb0e6e21ddd8391436affba3c490c0f7bd25fb6::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xdb40bf0222caef86c32f60718eb0e6e21ddd8391436affba3c490c0f7bd25fb6::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

