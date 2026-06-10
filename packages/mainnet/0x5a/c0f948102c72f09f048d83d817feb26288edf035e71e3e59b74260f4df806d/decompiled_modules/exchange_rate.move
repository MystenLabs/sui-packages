module 0x5ac0f948102c72f09f048d83d817feb26288edf035e71e3e59b74260f4df806d::exchange_rate {
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

    public(friend) fun sam(arg0: ExchangeRate) : u64 {
        (arg0.sam as u64)
    }

    public(friend) fun sub_sam_down(arg0: &mut ExchangeRate, arg1: u64) : u64 {
        let v0 = to_coin_in_down(arg0, arg1);
        arg0.coin_in = arg0.coin_in - (v0 as u128);
        arg0.sam = arg0.sam - (arg1 as u128);
        v0
    }

    public(friend) fun to_coin_in_down(arg0: &ExchangeRate, arg1: u64) : u64 {
        (0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::u128::mul_div_down((arg1 as u128), arg0.coin_in + 1, arg0.sam + 1) as u64)
    }

    public(friend) fun to_sam_down(arg0: &ExchangeRate, arg1: u64) : u64 {
        (0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::u128::mul_div_down((arg1 as u128), arg0.sam + 1, arg0.coin_in + 1) as u64)
    }

    // decompiled from Move bytecode v7
}

