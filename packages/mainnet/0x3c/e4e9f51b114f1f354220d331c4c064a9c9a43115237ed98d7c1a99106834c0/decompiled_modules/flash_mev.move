module 0xf9fb721962251aa3587d9b570543efcd04b43c6e95e7afd5a1bdc202354f1eb7::flash_mev {
    struct FlashJitResult has copy, drop {
        flash_amount_a: u64,
        swap_amount_a: u64,
        tick_lower: u32,
        tick_upper: u32,
        liquidity: u128,
        liquidity_paid_a: u64,
        liquidity_paid_b: u64,
        collected_fee_a: u64,
        collected_fee_b: u64,
        removed_a: u64,
        removed_b: u64,
        swap_repaid_a: u64,
        loan_repaid_a: u64,
        original_b: u64,
        final_a_profit: u64,
        final_b_profit: u64,
    }

    struct FlashJitProbeResult has copy, drop {
        flash_liquidity_a: u64,
        swap_amount_a: u64,
        tick_lower: u32,
        tick_upper: u32,
        liquidity: u128,
        original_a: u64,
        original_b: u64,
        liquidity_paid_a: u64,
        liquidity_paid_b: u64,
        collected_fee_a: u64,
        collected_fee_b: u64,
        removed_a: u64,
        removed_b: u64,
        swap_repaid_a: u64,
        loan_repaid_a: u64,
        final_a: u64,
        final_b: u64,
    }

    struct BaselineSwapProbeResult has copy, drop {
        swap_amount_a: u64,
        original_a: u64,
        swap_repaid_a: u64,
        output_b: u64,
        final_a: u64,
        final_b: u64,
    }

    fun assert_active_one_spacing<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u32, arg2: u32) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg1);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg2);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg0))), v1), 1);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v2, v0) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v2, v1), 2);
    }

    public entry fun baseline_swap_probe<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg2, 4295048017, arg7);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::coin::into_balance<T0>(arg3);
        0x2::balance::join<T0>(&mut v5, v0);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        assert!(0x2::balance::value<T0>(&v5) >= v6, 8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v5, v6), 0x2::balance::zero<T1>(), v3);
        let v7 = 0x2::balance::value<T0>(&v5);
        let v8 = 0x2::balance::value<T1>(&v4);
        assert!(v7 >= arg4, 4);
        assert!(v8 >= arg5, 5);
        let v9 = BaselineSwapProbeResult{
            swap_amount_a : arg2,
            original_a    : 0x2::coin::value<T0>(&arg3),
            swap_repaid_a : v6,
            output_b      : v8,
            final_a       : v7,
            final_b       : v8,
        };
        0x2::event::emit<BaselineSwapProbeResult>(v9);
        transfer_nonzero<T0>(v5, arg6, arg8);
        transfer_nonzero<T1>(v4, arg6, arg8);
    }

    public entry fun flash_jit<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: u64, arg4: u64, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: address, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > arg4 && arg4 > 0, 0);
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg5);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg6);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg1))), v1), 1);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v2, v0) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v2, v1), 2);
        let v3 = 0x2::coin::value<T1>(&arg7);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg3);
        let v7 = v4;
        0x2::balance::destroy_zero<T1>(v5);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, arg5, arg6, arg12);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, &mut v8, arg3 - arg4, true, arg11);
        let (v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v9);
        assert!(0x2::balance::value<T0>(&v7) >= v10, 6);
        let v12 = 0x2::coin::into_balance<T1>(arg7);
        assert!(0x2::balance::value<T1>(&v12) >= v11, 7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v7, v10), 0x2::balance::split<T1>(&mut v12, v11), v9);
        let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg4, 4295048017, arg11);
        let v16 = v15;
        let (v17, v18) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg0, arg1, &v8, false);
        let v19 = v18;
        let v20 = v17;
        let v21 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v8);
        let (v22, v23) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg1, &mut v8, v21, arg11);
        let v24 = v23;
        let v25 = v22;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg0, arg1, v8);
        0x2::balance::join<T0>(&mut v7, v13);
        0x2::balance::join<T0>(&mut v7, v20);
        0x2::balance::join<T0>(&mut v7, v25);
        0x2::balance::join<T1>(&mut v12, v14);
        0x2::balance::join<T1>(&mut v12, v19);
        0x2::balance::join<T1>(&mut v12, v24);
        let v26 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v16);
        assert!(0x2::balance::value<T0>(&v7) >= v26, 8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v7, v26), 0x2::balance::zero<T1>(), v16);
        let v27 = flash_loan_repay_amount<T0, T1>(arg1, arg3);
        assert!(0x2::balance::value<T0>(&v7) >= v27, 9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v7, v27), 0x2::balance::zero<T1>(), v6);
        let v28 = 0x2::balance::value<T0>(&v7);
        let v29 = 0x2::balance::value<T1>(&v12);
        assert!(v29 >= v3, 3);
        let v30 = v29 - v3;
        assert!(v28 >= arg8, 4);
        assert!(v30 >= arg9, 5);
        let v31 = FlashJitResult{
            flash_amount_a   : arg3,
            swap_amount_a    : arg4,
            tick_lower       : arg5,
            tick_upper       : arg6,
            liquidity        : v21,
            liquidity_paid_a : v10,
            liquidity_paid_b : v11,
            collected_fee_a  : 0x2::balance::value<T0>(&v20),
            collected_fee_b  : 0x2::balance::value<T1>(&v19),
            removed_a        : 0x2::balance::value<T0>(&v25),
            removed_b        : 0x2::balance::value<T1>(&v24),
            swap_repaid_a    : v26,
            loan_repaid_a    : v27,
            original_b       : v3,
            final_a_profit   : v28,
            final_b_profit   : v30,
        };
        0x2::event::emit<FlashJitResult>(v31);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v12, v3), arg12), 0x2::tx_context::sender(arg12));
        transfer_nonzero<T0>(v7, arg10, arg12);
        transfer_nonzero<T1>(v12, arg10, arg12);
        transfer_nonzero<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg0, arg1, &v8, arg2, true, arg11), arg10, arg12);
        transfer_nonzero<T3>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T3>(arg0, arg1, &v8, arg2, true, arg11), arg10, arg12);
    }

    public entry fun flash_jit_probe<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u32, arg5: u32, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: address, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg3 > 0, 0);
        assert_active_one_spacing<T0, T1>(arg1, arg4, arg5);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg0, arg1, true, arg2);
        let v3 = v0;
        0x2::balance::destroy_zero<T1>(v1);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, arg4, arg5, arg12);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, &mut v4, arg2, true, arg11);
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v5);
        assert!(0x2::balance::value<T0>(&v3) >= v6, 6);
        let v8 = 0x2::coin::into_balance<T1>(arg7);
        assert!(0x2::balance::value<T1>(&v8) >= v7, 7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v3, v6), 0x2::balance::split<T1>(&mut v8, v7), v5);
        let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg3, 4295048017, arg11);
        let v12 = v11;
        let (v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg0, arg1, &v4, false);
        let v15 = v14;
        let v16 = v13;
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v4);
        let (v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg1, &mut v4, v17, arg11);
        let v20 = v19;
        let v21 = v18;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg0, arg1, v4);
        let v22 = 0x2::coin::into_balance<T0>(arg6);
        0x2::balance::join<T0>(&mut v22, v3);
        0x2::balance::join<T0>(&mut v22, v9);
        0x2::balance::join<T0>(&mut v22, v16);
        0x2::balance::join<T0>(&mut v22, v21);
        0x2::balance::join<T1>(&mut v8, v10);
        0x2::balance::join<T1>(&mut v8, v15);
        0x2::balance::join<T1>(&mut v8, v20);
        let v23 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v12);
        assert!(0x2::balance::value<T0>(&v22) >= v23, 8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v22, v23), 0x2::balance::zero<T1>(), v12);
        let v24 = flash_loan_repay_amount<T0, T1>(arg1, arg2);
        assert!(0x2::balance::value<T0>(&v22) >= v24, 9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v22, v24), 0x2::balance::zero<T1>(), v2);
        let v25 = 0x2::balance::value<T0>(&v22);
        let v26 = 0x2::balance::value<T1>(&v8);
        assert!(v25 >= arg8, 4);
        assert!(v26 >= arg9, 5);
        let v27 = FlashJitProbeResult{
            flash_liquidity_a : arg2,
            swap_amount_a     : arg3,
            tick_lower        : arg4,
            tick_upper        : arg5,
            liquidity         : v17,
            original_a        : 0x2::coin::value<T0>(&arg6),
            original_b        : 0x2::coin::value<T1>(&arg7),
            liquidity_paid_a  : v6,
            liquidity_paid_b  : v7,
            collected_fee_a   : 0x2::balance::value<T0>(&v16),
            collected_fee_b   : 0x2::balance::value<T1>(&v15),
            removed_a         : 0x2::balance::value<T0>(&v21),
            removed_b         : 0x2::balance::value<T1>(&v20),
            swap_repaid_a     : v23,
            loan_repaid_a     : v24,
            final_a           : v25,
            final_b           : v26,
        };
        0x2::event::emit<FlashJitProbeResult>(v27);
        transfer_nonzero<T0>(v22, arg10, arg12);
        transfer_nonzero<T1>(v8, arg10, arg12);
    }

    fun flash_loan_repay_amount<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64) : u64 {
        arg1 + ((((arg1 as u128) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0) as u128) + 1000000 - 1) / 1000000) as u64)
    }

    fun transfer_nonzero<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

