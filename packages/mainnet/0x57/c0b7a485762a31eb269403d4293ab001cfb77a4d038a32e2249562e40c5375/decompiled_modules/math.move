module 0x57c0b7a485762a31eb269403d4293ab001cfb77a4d038a32e2249562e40c5375::math {
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

