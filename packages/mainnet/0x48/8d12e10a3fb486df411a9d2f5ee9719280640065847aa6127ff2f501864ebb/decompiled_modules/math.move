module 0x488d12e10a3fb486df411a9d2f5ee9719280640065847aa6127ff2f501864ebb::math {
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

