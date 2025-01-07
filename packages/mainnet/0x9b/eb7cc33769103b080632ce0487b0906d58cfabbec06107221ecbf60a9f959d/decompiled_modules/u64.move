module 0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x9beb7cc33769103b080632ce0487b0906d58cfabbec06107221ecbf60a9f959d::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

