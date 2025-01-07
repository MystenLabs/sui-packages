module 0x72593aa898381db72dc55d78ebfe4a016f3261f0c9b10f74e35fd4e3a995400a::math {
    public fun calculate_buy_amount(arg0: u64, arg1: u64) : u64 {
        arg1 / (100 + arg0 / 1000 * 1)
    }

    public fun calculate_sell_amount(arg0: u64, arg1: u64) : u64 {
        let v0 = 100;
        let v1 = 1;
        arg1 * (v0 + arg0 / 1000 * v1 + v0 + (arg0 + arg1) / 1000 * v1) / 2
    }

    public fun get_token_price(arg0: u64) : u64 {
        100 + arg0 / 1000 * 1
    }

    // decompiled from Move bytecode v6
}

