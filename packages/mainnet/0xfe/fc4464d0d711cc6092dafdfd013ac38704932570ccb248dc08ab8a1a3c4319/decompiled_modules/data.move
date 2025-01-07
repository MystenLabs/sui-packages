module 0x51c8d6fee9336237cd56584aecaef70479a8ea23ee1245788680900ca38d7026::data {
    struct InputArb has copy, drop {
        from: u64,
        limit_length: u64,
        iterations: u64,
        sqrt_price_limit: u128,
        profit_threshold: u128,
        delta: u64,
        max_step: u64,
        coinInValue: u64,
    }

    struct DataArb has copy, drop {
        inputs: InputArb,
        route: vector<0x51c8d6fee9336237cd56584aecaef70479a8ea23ee1245788680900ca38d7026::paths::PriceNode>,
        sqrt_price_init: u128,
        amounts_in: vector<u64>,
        sqrt_price_end: u128,
        profit: u64,
        fee: u64,
    }

    public(friend) fun data_arb_new(arg0: InputArb, arg1: vector<0x51c8d6fee9336237cd56584aecaef70479a8ea23ee1245788680900ca38d7026::paths::PriceNode>, arg2: u128, arg3: vector<u64>, arg4: u128, arg5: u64, arg6: u64) : DataArb {
        DataArb{
            inputs          : arg0,
            route           : arg1,
            sqrt_price_init : arg2,
            amounts_in      : arg3,
            sqrt_price_end  : arg4,
            profit          : arg5,
            fee             : arg6,
        }
    }

    public(friend) fun emit_data(arg0: DataArb) {
        0x2::event::emit<DataArb>(arg0);
    }

    public(friend) fun input_arb_new(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64) : InputArb {
        InputArb{
            from             : arg0,
            limit_length     : arg1,
            iterations       : arg2,
            sqrt_price_limit : arg3,
            profit_threshold : arg4,
            delta            : arg5,
            max_step         : arg6,
            coinInValue      : arg7,
        }
    }

    // decompiled from Move bytecode v6
}

