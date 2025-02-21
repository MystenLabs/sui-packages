module 0x607c04cb1dbc5a9375ae6021947cfe62cea54df2d6395999809b1a64219f9285::curves {
    public fun calculate_add_liquidity_cost(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg1 - arg2;
        assert!(v0 > 0, 100);
        mul_div(arg0, arg1, v0) - arg0
    }

    public fun calculate_remove_liquidity_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg1 - mul_div(arg1, arg0, arg0 + arg2)
    }

    public fun calculate_token_amount_received(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg1 - mul_div(arg0, arg1, arg0 + arg2)
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(!(v0 > (18446744073709551615 as u128)), 501);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

