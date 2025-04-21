module 0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::exchange_rate {
    struct ExchangeRate has copy, drop, store {
        sam: u128,
        coin_in: u128,
    }

    public(friend) fun empty() : ExchangeRate {
        ExchangeRate{
            sam     : 0,
            coin_in : 0,
        }
    }

    public(friend) fun add_coin_in_down(arg0: &mut ExchangeRate, arg1: u64) : u64 {
        let v0 = to_sam_down(arg0, arg1);
        arg0.coin_in = arg0.coin_in + (arg1 as u128);
        arg0.sam = arg0.sam + (v0 as u128);
        v0
    }

    public(friend) fun add_earnings(arg0: &mut ExchangeRate, arg1: u64) {
        arg0.coin_in = arg0.coin_in + (arg1 as u128);
    }

    public(friend) fun coin_in(arg0: ExchangeRate) : u64 {
        (arg0.coin_in as u64)
    }

    public(friend) fun is_empty(arg0: ExchangeRate) : bool {
        arg0.coin_in == 0
    }

    public(friend) fun new(arg0: u64, arg1: u64) : ExchangeRate {
        ExchangeRate{
            sam     : (arg1 as u128),
            coin_in : (arg0 as u128),
        }
    }

    public(friend) fun sam(arg0: ExchangeRate) : u64 {
        (arg0.sam as u64)
    }

    public(friend) fun sub_coin_in_down(arg0: &mut ExchangeRate, arg1: u64) : u64 {
        let v0 = to_sam_down(arg0, arg1);
        arg0.coin_in = arg0.coin_in - (arg1 as u128);
        arg0.sam = arg0.sam - (v0 as u128);
        v0
    }

    public(friend) fun sub_coin_in_up(arg0: &mut ExchangeRate, arg1: u64) : u64 {
        let v0 = to_sam_up(arg0, arg1);
        arg0.coin_in = arg0.coin_in - (arg1 as u128);
        arg0.sam = arg0.sam - (v0 as u128);
        v0
    }

    public(friend) fun sub_sam_down(arg0: &mut ExchangeRate, arg1: u64) : u64 {
        let v0 = to_coin_in_down(arg0, arg1);
        arg0.coin_in = arg0.coin_in - (v0 as u128);
        arg0.sam = arg0.sam - (arg1 as u128);
        v0
    }

    public(friend) fun to_coin_in_down(arg0: &ExchangeRate, arg1: u64) : u64 {
        if (arg0.sam == 0) {
            return arg1
        };
        (0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::u128::mul_div_down((arg1 as u128), arg0.coin_in, arg0.sam) as u64)
    }

    public(friend) fun to_coin_in_up(arg0: &ExchangeRate, arg1: u64) : u64 {
        if (arg0.sam == 0) {
            return arg1
        };
        (0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::u128::mul_div_up((arg1 as u128), arg0.coin_in, arg0.sam) as u64)
    }

    public(friend) fun to_sam_down(arg0: &ExchangeRate, arg1: u64) : u64 {
        if (arg0.coin_in == 0) {
            return arg1
        };
        (0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::u128::mul_div_down((arg1 as u128), arg0.sam, arg0.coin_in) as u64)
    }

    public(friend) fun to_sam_up(arg0: &ExchangeRate, arg1: u64) : u64 {
        if (arg0.coin_in == 0) {
            return arg1
        };
        (0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::u128::mul_div_up((arg1 as u128), arg0.sam, arg0.coin_in) as u64)
    }

    // decompiled from Move bytecode v6
}

