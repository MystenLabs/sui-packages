module 0xf9dacb778acd871ca929c7c6c71db90c086634018dcdb20bd820cff3423d0878::curve {
    struct Opening has copy, drop {
        coin_is_a: bool,
        tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        sqrt_open: u128,
        premine: u64,
        float: u64,
        protocol_fee: u64,
        spend: u64,
        liquidity: u128,
        dev_buy_coins: u64,
        quote_deposited: u64,
        quote_refund: u64,
    }

    public fun coin_deposited(arg0: &Opening) : u64 {
        arg0.float - arg0.dev_buy_coins
    }

    public fun coin_is_a(arg0: &Opening) : bool {
        arg0.coin_is_a
    }

    public fun dev_buy_coins(arg0: &Opening) : u64 {
        arg0.dev_buy_coins
    }

    public fun fee_rate_for(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: u32) : u64 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::get_fee_rate(arg1, arg0)
    }

    public fun float(arg0: &Opening) : u64 {
        arg0.float
    }

    public fun liquidity(arg0: &Opening) : u128 {
        arg0.liquidity
    }

    public fun max_aligned_tick(arg0: u32) : u32 {
        assert!(arg0 > 0, 7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::tick_bound() / arg0 * arg0
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun plan(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg7: u32) : Opening {
        assert!(arg1 > 0, 1);
        assert!(arg5 <= 2000, 2);
        let v0 = max_aligned_tick(arg7);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::is_valid_index(arg6, arg7), 3);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(arg6, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(v0)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg6, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v0)), 4);
        let v1 = mul_div(arg1, arg5, 10000);
        let v2 = arg1 - v1;
        let v3 = mul_div(mul_div(arg2, arg3, 1000000), arg4, 10000);
        let v4 = arg2 - v3;
        let v5 = v4 / 1000 + 10;
        assert!(v4 > v5, 5);
        let v6 = v4 - v5;
        let (v7, v8) = if (arg0) {
            (arg6, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v0))
        } else {
            (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(v0), arg6)
        };
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v7);
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v8);
        let (v11, v12, v13, v14) = if (arg0) {
            let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(v9, v10, v2, false);
            let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_next_sqrt_price_b_down(v9, v15, v6, true);
            assert!(v16 > v9, 5);
            assert!(v16 < v10, 6);
            let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_a(v9, v16, v15, false);
            let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_a(v16, v10, v2 - v17, false);
            (v16, v17, v18, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_b(v16, v9, v18, true))
        } else {
            let v19 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_b(v9, v10, v2, false);
            let v20 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_next_sqrt_price_a_up(v10, v19, v6, true);
            assert!(v20 < v10, 5);
            assert!(v20 > v9, 6);
            let v21 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_b(v20, v10, v19, false);
            let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_from_b(v9, v20, v2 - v21, false);
            (v20, v21, v22, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_a(v20, v10, v22, true))
        };
        assert!(v14 <= v4, 5);
        Opening{
            coin_is_a       : arg0,
            tick_lower      : v7,
            tick_upper      : v8,
            sqrt_open       : v11,
            premine         : v1,
            float           : v2,
            protocol_fee    : v3,
            spend           : v6,
            liquidity       : v13,
            dev_buy_coins   : v12,
            quote_deposited : v14,
            quote_refund    : v4 - v14,
        }
    }

    public fun premine(arg0: &Opening) : u64 {
        arg0.premine
    }

    public fun preview(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u32, arg7: u32) : (u32, u32, u128, u64, u64, u64, u64, u128, u64, u64, u64) {
        let v0 = plan(arg0, arg1, arg2, arg3, arg4, arg5, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6), arg7);
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0.tick_lower), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0.tick_upper), v0.sqrt_open, v0.premine, v0.float, v0.protocol_fee, v0.spend, v0.liquidity, v0.dev_buy_coins, v0.quote_deposited, v0.quote_refund)
    }

    public fun protocol_fee(arg0: &Opening) : u64 {
        arg0.protocol_fee
    }

    public fun quote_deposited(arg0: &Opening) : u64 {
        arg0.quote_deposited
    }

    public fun quote_refund(arg0: &Opening) : u64 {
        arg0.quote_refund
    }

    public fun spend(arg0: &Opening) : u64 {
        arg0.spend
    }

    public fun sqrt_open(arg0: &Opening) : u128 {
        arg0.sqrt_open
    }

    public fun tick_lower(arg0: &Opening) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.tick_lower
    }

    public fun tick_upper(arg0: &Opening) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        arg0.tick_upper
    }

    // decompiled from Move bytecode v7
}

