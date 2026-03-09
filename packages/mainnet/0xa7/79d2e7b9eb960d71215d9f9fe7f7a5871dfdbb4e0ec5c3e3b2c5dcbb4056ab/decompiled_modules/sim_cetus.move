module 0xc5baa691ecbed8575d4bff750b80791d638ce1d1a5cb1942d85d4f6e9b7e808c::sim_cetus {
    struct SimResult has copy, drop {
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        final_sqrt_price: u128,
        exceeded: bool,
    }

    public fun sim_amount_in(arg0: &SimResult) : u64 {
        arg0.amount_in
    }

    public fun sim_amount_out(arg0: &SimResult) : u64 {
        arg0.amount_out
    }

    public fun sim_exceeded(arg0: &SimResult) : bool {
        arg0.exceeded
    }

    public fun sim_fee(arg0: &SimResult) : u64 {
        arg0.fee
    }

    public fun sim_total_cost(arg0: &SimResult) : u64 {
        arg0.amount_in + arg0.fee
    }

    public fun simulate_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : SimResult {
        if (arg2 == 0) {
            return SimResult{
                amount_in        : 0,
                amount_out       : 0,
                fee              : 0,
                final_sqrt_price : 0,
                exceeded         : true,
            }
        };
        let v0 = if (arg1) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_manager<T0, T1>(arg0);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::first_score_for_swap(v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0), arg1);
        let v5 = arg2;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = false;
        let v10 = 0;
        let v11 = 50;
        loop {
            let v12 = if (v5 > 0) {
                if (v1 != v0) {
                    v10 < v11
                } else {
                    false
                }
            } else {
                false
            };
            if (v12) {
                v10 = v10 + 1;
                if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_none(&v4)) {
                    v9 = true;
                    break
                };
                let (v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::borrow_tick_for_swap(v3, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v4), arg1);
                v4 = v14;
                let v15 = if (arg1) {
                    0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::max(v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::sqrt_price(v13))
                } else {
                    0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::math_u128::min(v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::sqrt_price(v13))
                };
                let (v16, v17, v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::compute_swap_step(v1, v15, v2, v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0), arg1, true);
                if (v16 != 0 || v19 != 0) {
                    let v20 = v5 - v16;
                    v5 = v20 - v19;
                    v6 = v6 + v16;
                    v7 = v7 + v17;
                    v8 = v8 + v19;
                };
                if (v18 == v15) {
                    v1 = v15;
                    let v21 = if (arg1) {
                        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::neg(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_net(v13))
                    } else {
                        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick::liquidity_net(v13)
                    };
                    if (!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::is_neg(v21)) {
                        v2 = v2 + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::abs_u128(v21);
                        continue
                    };
                    v2 = v2 - 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::abs_u128(v21);
                    continue
                };
                v1 = v18;
            } else {
                break
            };
        };
        if (v5 > 0 && v10 >= v11) {
            v9 = true;
        };
        SimResult{
            amount_in        : v6,
            amount_out       : v7,
            fee              : v8,
            final_sqrt_price : v1,
            exceeded         : v9,
        }
    }

    // decompiled from Move bytecode v6
}

