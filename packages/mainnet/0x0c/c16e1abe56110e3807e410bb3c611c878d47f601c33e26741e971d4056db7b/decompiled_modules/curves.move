module 0x6079a109382facb4767a25ad52b3f69536e82ce38fe6553899432a4fa83b2414::curves {
    public fun calculate_add_liquidity_cost(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg1 - arg2;
        assert!(v0 > 0, 503);
        let v1 = mul_div(arg0, arg1, v0);
        assert!(v1 >= arg0, 502);
        v1 - arg0
    }

    public fun calculate_remove_liquidity_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 <= 18446744073709551615 - arg0, 501);
        let v0 = mul_div(arg1, arg0, arg0 + arg2);
        assert!(v0 <= arg1, 502);
        arg1 - v0
    }

    public fun calculate_token_amount_received(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 <= 18446744073709551615 - arg0, 501);
        let v0 = mul_div(arg0, arg1, arg0 + arg2);
        assert!(v0 <= arg1, 502);
        arg1 - v0
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(!(v0 > (18446744073709551615 as u128)), 501);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

