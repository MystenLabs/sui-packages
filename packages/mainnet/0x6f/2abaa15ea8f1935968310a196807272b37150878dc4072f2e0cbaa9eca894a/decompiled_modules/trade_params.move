module 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::trade_params {
    struct TradeParams has copy, drop, store {
        taker_fee: u64,
        maker_fee: u64,
        stake_required: u64,
    }

    public(friend) fun maker_fee(arg0: &TradeParams) : u64 {
        arg0.maker_fee
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64) : TradeParams {
        TradeParams{
            taker_fee      : arg0,
            maker_fee      : arg1,
            stake_required : arg2,
        }
    }

    public(friend) fun stake_required(arg0: &TradeParams) : u64 {
        arg0.stake_required
    }

    public(friend) fun taker_fee(arg0: &TradeParams) : u64 {
        arg0.taker_fee
    }

    public(friend) fun taker_fee_for_user(arg0: &TradeParams, arg1: u64, arg2: u128) : u64 {
        if (arg1 >= arg0.stake_required && arg2 >= (arg0.stake_required as u128)) {
            arg0.taker_fee / 2
        } else {
            arg0.taker_fee
        }
    }

    // decompiled from Move bytecode v6
}

