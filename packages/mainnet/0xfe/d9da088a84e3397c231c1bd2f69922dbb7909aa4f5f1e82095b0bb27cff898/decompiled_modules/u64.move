module 0xfed9da088a84e3397c231c1bd2f69922dbb7909aa4f5f1e82095b0bb27cff898::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xfed9da088a84e3397c231c1bd2f69922dbb7909aa4f5f1e82095b0bb27cff898::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

