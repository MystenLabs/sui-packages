module 0x8e24834bbf8d66e62d0860cc7f333416828c8e116988b1ea2cb4f94197e18638::clmm {
    struct SwapStepResult has copy, drop {
        current_sqrt_price: u128,
        target_sqrt_price: u128,
        current_liquidity: u128,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        remainder_amount: u64,
    }

    struct SwapState has copy, drop {
        amount_specified_remaining: u64,
        amount_calculated: u64,
        sqrt_price_x64: u128,
        tick: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        liquidity: u128,
    }

    struct CalculatedSwapResult has copy, drop {
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
    }

    struct SwapStep has copy, drop {
        sqrt_price_next_x64: u128,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
    }

    public(friend) fun compute_swap(arg0: u128, arg1: u128, arg2: u64, arg3: u128, arg4: u64, arg5: bool, arg6: bool, arg7: vector<0x8e24834bbf8d66e62d0860cc7f333416828c8e116988b1ea2cb4f94197e18638::tick::Tick>) : (u64, u64) {
        let v0 = SwapState{
            amount_specified_remaining : arg2,
            amount_calculated          : 0,
            sqrt_price_x64             : arg0,
            tick                       : 0x8e24834bbf8d66e62d0860cc7f333416828c8e116988b1ea2cb4f94197e18638::tick_math::get_tick_at_sqrt_price(arg0),
            liquidity                  : arg1,
        };
        let v1 = CalculatedSwapResult{
            amount_in  : 0,
            amount_out : 0,
            fee_amount : 0,
        };
        while (0x1::vector::is_empty<0x8e24834bbf8d66e62d0860cc7f333416828c8e116988b1ea2cb4f94197e18638::tick::Tick>(&arg7) == false) {
            let v2 = 0x1::vector::pop_back<0x8e24834bbf8d66e62d0860cc7f333416828c8e116988b1ea2cb4f94197e18638::tick::Tick>(&mut arg7);
            let v3 = 0x8e24834bbf8d66e62d0860cc7f333416828c8e116988b1ea2cb4f94197e18638::tick_math::get_sqrt_price_at_tick(0x8e24834bbf8d66e62d0860cc7f333416828c8e116988b1ea2cb4f94197e18638::tick::tick_index(&v2));
            let v4 = if (arg5 && v3 < arg3 || !arg5 && v3 > arg3) {
                arg3
            } else {
                v3
            };
            let (v5, v6, v7, v8) = 0x8e24834bbf8d66e62d0860cc7f333416828c8e116988b1ea2cb4f94197e18638::clmm_math::compute_swap_step(v0.sqrt_price_x64, v4, v0.liquidity, v0.amount_specified_remaining, arg4, arg6, arg5);
            let v9 = SwapStep{
                sqrt_price_next_x64 : v7,
                amount_in           : v5,
                amount_out          : v6,
                fee_amount          : v8,
            };
            if (arg6) {
                v0.amount_calculated = v0.amount_calculated + v9.amount_in;
                v0.amount_specified_remaining = v0.amount_specified_remaining - v9.amount_in - v9.fee_amount;
            } else {
                v0.amount_calculated = v0.amount_calculated + v9.amount_out + v9.fee_amount;
                v0.amount_specified_remaining = v0.amount_specified_remaining - v9.amount_out;
            };
            v1.amount_in = v1.amount_in + v9.amount_in;
            v1.amount_out = v1.amount_out + v9.amount_out;
            v1.fee_amount = v1.fee_amount + v9.fee_amount;
            v0.sqrt_price_x64 = v9.sqrt_price_next_x64;
            if (v0.sqrt_price_x64 == v3) {
                let v10 = if (arg5) {
                    0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::neg(0x8e24834bbf8d66e62d0860cc7f333416828c8e116988b1ea2cb4f94197e18638::tick::liquidity_net(&v2))
                } else {
                    0x8e24834bbf8d66e62d0860cc7f333416828c8e116988b1ea2cb4f94197e18638::tick::liquidity_net(&v2)
                };
                if (!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::is_neg(v10)) {
                    v0.liquidity = v0.liquidity + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::abs_u128(v10);
                    continue
                };
                v0.liquidity = v0.liquidity - 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i128::abs_u128(v10);
                v0.sqrt_price_x64 = v3;
                v0.tick = 0x8e24834bbf8d66e62d0860cc7f333416828c8e116988b1ea2cb4f94197e18638::tick::tick_index(&v2);
            } else {
                v0.sqrt_price_x64 = v9.sqrt_price_next_x64;
            };
            if (v0.amount_specified_remaining == 0 || v0.sqrt_price_x64 == arg3) {
                break
            };
        };
        (v1.amount_in, v1.amount_out)
    }

    // decompiled from Move bytecode v6
}

