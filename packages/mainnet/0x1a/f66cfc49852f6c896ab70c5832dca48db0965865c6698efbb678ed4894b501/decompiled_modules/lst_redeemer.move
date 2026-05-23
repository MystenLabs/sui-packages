module 0x1af66cfc49852f6c896ab70c5832dca48db0965865c6698efbb678ed4894b501::lst_redeemer {
    struct LstRedemption has copy, drop {
        lst_type: 0x1::ascii::String,
        lst_amount: u64,
        sui_received: u64,
        exchange_rate_x64: u128,
    }

    public fun compute_spring_sui_output(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / 1000000000;
        ((v0 - v0 * (arg2 as u128) / 10000) as u64)
    }

    public fun emit_redemption(arg0: 0x1::ascii::String, arg1: u64, arg2: u64, arg3: u128) {
        let v0 = LstRedemption{
            lst_type          : arg0,
            lst_amount        : arg1,
            sui_received      : arg2,
            exchange_rate_x64 : arg3,
        };
        0x2::event::emit<LstRedemption>(v0);
    }

    // decompiled from Move bytecode v7
}

