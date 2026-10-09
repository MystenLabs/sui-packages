module 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::curve_math {
    struct BuyQuote has copy, drop {
        tokens_out: u64,
        net_in: u64,
        fee: u64,
        gross_in: u64,
        sells_out: bool,
        new_x: u64,
        new_y: u64,
    }

    public fun fee(arg0: &BuyQuote) : u64 {
        arg0.fee
    }

    public fun graduation_split(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64) {
        let v0 = 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::bps_of(arg0, arg2);
        (0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::bps_of(arg0, arg1), v0, 0x1::u64::min(v0, arg3))
    }

    public fun gross_in(arg0: &BuyQuote) : u64 {
        arg0.gross_in
    }

    public fun initial_virtual_quote(arg0: u64) : u64 {
        0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div(arg0, 25, 74)
    }

    public fun initial_virtual_tokens(arg0: u64) : u64 {
        0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div(arg0, 99, 74)
    }

    public fun k_of(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun net_in(arg0: &BuyQuote) : u64 {
        arg0.net_in
    }

    public fun new_x(arg0: &BuyQuote) : u64 {
        arg0.new_x
    }

    public fun new_y(arg0: &BuyQuote) : u64 {
        arg0.new_y
    }

    public fun price_buy(arg0: u128, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : BuyQuote {
        let v0 = 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div_up(arg4, arg5, 10000);
        assert!(arg4 > v0, 101);
        let v1 = arg4 - v0;
        let v2 = arg1 + v1;
        let v3 = 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::to_u64(0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::div_up_u128(arg0, (v2 as u128)));
        let v4 = arg2 - v3;
        if (v4 < arg3) {
            return BuyQuote{
                tokens_out : v4,
                net_in     : v1,
                fee        : v0,
                gross_in   : arg4,
                sells_out  : false,
                new_x      : v2,
                new_y      : v3,
            }
        };
        let v5 = arg2 - arg3;
        let v6 = 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::to_u64(0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::div_up_u128(arg0, (v5 as u128)));
        let v7 = v6 - arg1;
        let v8 = 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div_up(v7, arg5, 10000 - arg5);
        BuyQuote{
            tokens_out : arg3,
            net_in     : v7,
            fee        : v8,
            gross_in   : v7 + v8,
            sells_out  : true,
            new_x      : v6,
            new_y      : v5,
        }
    }

    public fun price_sell(arg0: u128, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, u64, u64, u64) {
        assert!(arg3 > 0, 101);
        let v0 = arg2 + arg3;
        let v1 = 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::to_u64(0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::div_up_u128(arg0, (v0 as u128)));
        let v2 = arg1 - v1;
        let v3 = 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div_up(v2, arg4, 10000);
        assert!(v2 > v3, 101);
        (v2, v3, v2 - v3, v1, v0)
    }

    public fun sells_out(arg0: &BuyQuote) : bool {
        arg0.sells_out
    }

    public fun snipe_fee_bps(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 >= arg3) {
            return arg1
        };
        arg0 - 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::mul_div(arg0 - arg1, arg2, arg3)
    }

    public fun tokens_out(arg0: &BuyQuote) : u64 {
        arg0.tokens_out
    }

    public fun with_tax_bps(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 + arg1;
        if (v0 > arg2) {
            0x1::u64::max(arg2, arg0)
        } else {
            v0
        }
    }

    // decompiled from Move bytecode v7
}

