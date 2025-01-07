module 0xfae73f5d7c5ade6ea2264f4d2d611129595a621d99373cf4021ac061e8d426c3::math {
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

