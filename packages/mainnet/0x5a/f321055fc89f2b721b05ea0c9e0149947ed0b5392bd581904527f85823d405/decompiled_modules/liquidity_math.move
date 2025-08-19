module 0x5af321055fc89f2b721b05ea0c9e0149947ed0b5392bd581904527f85823d405::liquidity_math {
    struct EstimateAmountEvent has copy, drop, store {
        liquidity: u128,
        amount_a: u128,
        amount_b: u128,
    }

    public fun adjust_for_slippage(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u128 {
        assert!(arg2 > 0, 105);
        assert!(arg1 <= arg2, 104);
        if (arg3) {
            arg0 * (arg2 + arg1) / arg2
        } else {
            arg0 * arg2 / (arg2 + arg1)
        }
    }

    public fun estimate_token(arg0: u32, arg1: u32, arg2: u128, arg3: u128, arg4: bool) : (u128, u128, u128) {
        estimate_token_in_given_out(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1), arg2, arg3, arg4)
    }

    public fun estimate_token_a_given_token_b(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128, arg3: u128) : u128 {
        let v0 = 0x5af321055fc89f2b721b05ea0c9e0149947ed0b5392bd581904527f85823d405::tick_math::get_sqrt_price_at_tick(arg1);
        get_amount_token_a_from_liquidity(get_liquidity_from_token_b(arg3, arg2, v0), 0x5af321055fc89f2b721b05ea0c9e0149947ed0b5392bd581904527f85823d405::tick_math::get_sqrt_price_at_tick(arg0), v0)
    }

    public fun estimate_token_b_given_token_a(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128, arg3: u128) : u128 {
        let v0 = 0x5af321055fc89f2b721b05ea0c9e0149947ed0b5392bd581904527f85823d405::tick_math::get_sqrt_price_at_tick(arg1);
        get_amount_token_b_from_liquidity(get_liquidity_from_token_a(arg3, 0x5af321055fc89f2b721b05ea0c9e0149947ed0b5392bd581904527f85823d405::tick_math::get_sqrt_price_at_tick(arg0), v0), arg2, v0)
    }

    public fun estimate_token_in_given_out(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: u128, arg3: u128, arg4: bool) : (u128, u128, u128) {
        let v0 = 0x5af321055fc89f2b721b05ea0c9e0149947ed0b5392bd581904527f85823d405::tick_math::get_sqrt_price_at_tick(arg0);
        let v1 = 0x5af321055fc89f2b721b05ea0c9e0149947ed0b5392bd581904527f85823d405::tick_math::get_sqrt_price_at_tick(arg1);
        assert!(v1 > v0, 102);
        if (arg2 <= v0) {
            assert!(!arg4, 103);
            let v5 = get_liquidity_from_token_b(arg3, v0, v1);
            (v5, get_amount_token_a_from_liquidity(v5, v0, v1), arg3)
        } else if (arg2 >= v1) {
            assert!(arg4, 103);
            let v6 = get_liquidity_from_token_a(arg3, v0, v1);
            (v6, arg3, get_amount_token_b_from_liquidity(v6, v0, arg2))
        } else if (arg4) {
            let v7 = get_liquidity_from_token_a(arg3, arg2, v1);
            (v7, arg3, get_amount_token_b_from_liquidity(v7, v0, arg2))
        } else {
            let v8 = get_liquidity_from_token_b(arg3, v0, arg2);
            (v8, get_amount_token_a_from_liquidity(v8, arg2, v1), arg3)
        }
    }

    public fun get_amount_token_a_from_liquidity(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > arg1, 102);
        assert!(arg1 > 0, 100);
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(18446744073709551616, 18446744073709551616, arg1);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(18446744073709551616, 18446744073709551616, arg2);
        assert!(v0 >= v1, 102);
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(arg0, v0 - v1, 18446744073709551616)
    }

    public fun get_amount_token_b_from_liquidity(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > arg1, 102);
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(arg0, arg2 - arg1, 18446744073709551616)
    }

    public fun get_liquidity_from_token_a(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > arg1, 102);
        let v0 = arg2 - arg1;
        assert!(v0 > 0, 100);
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(arg0, arg1, 18446744073709551616), arg2, 18446744073709551616), 18446744073709551616, v0)
    }

    public fun get_liquidity_from_token_b(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > arg1, 102);
        let v0 = arg2 - arg1;
        assert!(v0 > 0, 100);
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(arg0, 18446744073709551616, v0)
    }

    public entry fun tesing_estimate_token(arg0: u32, arg1: u32, arg2: u128, arg3: u128, arg4: bool) {
        let (v0, v1, v2) = estimate_token_in_given_out(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1), arg2, arg3, arg4);
        let v3 = EstimateAmountEvent{
            liquidity : v0,
            amount_a  : v1,
            amount_b  : v2,
        };
        0x2::event::emit<EstimateAmountEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

