module 0xb819e2ff0353349d16a6d585321c9ad7fcab5e8eae1adb3a41031a0125caefe6::atomic_magic {
    struct AtomicMagicResult has copy, drop {
        loan_a: u64,
        loan_b: u64,
        cetus_lp_a: u64,
        cetus_lp_b: u64,
        bluefin_lp_a: u64,
        bluefin_lp_b: u64,
        swap_b_in: u64,
        cetus_a_out: u64,
        bluefin_a_in: u64,
        bluefin_b_out: u64,
        deepbook_a_in: u64,
        deepbook_b_out: u64,
        cetus_fee_a: u64,
        cetus_fee_b: u64,
        bluefin_fee_a: u64,
        bluefin_fee_b: u64,
        cetus_reward: u64,
        bluefin_reward: u64,
        final_a: u64,
        final_b: u64,
        profit_a: u64,
        profit_b: u64,
    }

    fun flash_repay<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64) : u64 {
        arg1 + ((((arg1 as u128) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0) as u128) + 1000000 - 1) / 1000000) as u64)
    }

    public entry fun run<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: u32, arg5: u32, arg6: u64, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg9: u32, arg10: u32, arg11: u64, arg12: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg13: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg14: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg15: 0x2::coin::Coin<T0>, arg16: 0x2::coin::Coin<T1>, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: address, arg24: &mut 0x2::tx_context::TxContext) {
        assert!(arg23 == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 10);
        let v0 = if (arg17 > 0) {
            if (arg18 > 0) {
                arg19 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = 0x2::coin::value<T0>(&arg15);
        let v2 = 0x2::coin::value<T1>(&arg16);
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg1, arg2, true, arg17);
        0x2::balance::destroy_zero<T1>(v4);
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_loan<T0, T1>(arg1, arg2, false, arg18);
        0x2::balance::destroy_zero<T0>(v6);
        let v9 = 0x2::coin::into_balance<T0>(arg15);
        0x2::balance::join<T0>(&mut v9, v3);
        let v10 = 0x2::coin::into_balance<T1>(arg16);
        0x2::balance::join<T1>(&mut v10, v7);
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, arg4, arg5, arg24);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, &mut v11, arg6, true, arg0);
        let (v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v12);
        assert!(0x2::balance::value<T0>(&v9) >= v13, 1);
        assert!(0x2::balance::value<T1>(&v10) >= v14, 2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v9, v13), 0x2::balance::split<T1>(&mut v10, v14), v12);
        let v15 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T1, T0>(arg7, arg8, arg9, arg10, arg24);
        let (v16, v17, v18, v19) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T1, T0>(arg0, arg7, arg8, &mut v15, v10, v9, arg11, false);
        v10 = v18;
        v9 = v19;
        assert!(0x2::balance::value<T1>(&v10) >= arg19, 3);
        let v20 = swap_cetus_b_to_a<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T1>(&mut v10, arg19));
        let v21 = 0x2::balance::value<T0>(&v20);
        assert!(v21 >= arg20, 3);
        let v22 = swap_bluefin_a_to_b<T0, T1>(arg0, arg7, arg8, 0x2::balance::split<T0>(&mut v20, arg20));
        let (v23, v24, v25) = swap_deepbook_quote_to_base<T1, T0>(arg0, arg12, arg13, v20, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg14), arg24);
        let v26 = v23;
        0x2::balance::join<T1>(&mut v10, v22);
        0x2::balance::join<T1>(&mut v10, v26);
        0x2::balance::join<T0>(&mut v9, v24);
        let v27 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T0, T3>(arg0, arg7, arg8, &mut v15);
        let (_, _, v30, v31) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T1, T0>(arg7, arg8, &mut v15, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v15), arg0);
        let v32 = v31;
        let v33 = v30;
        let (v34, v35) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(&v15);
        let (v36, v37) = if (v34 > 0 || v35 > 0) {
            let (_, _, v40, v41) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T1, T0>(arg0, arg7, arg8, &mut v15);
            (v40, v41)
        } else {
            (0x2::balance::zero<T1>(), 0x2::balance::zero<T0>())
        };
        let v42 = v37;
        let v43 = v36;
        0x2::balance::join<T1>(&mut v33, v43);
        0x2::balance::join<T0>(&mut v32, v42);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T1, T0>(arg0, arg7, arg8, v15);
        0x2::balance::join<T1>(&mut v10, v33);
        0x2::balance::join<T0>(&mut v9, v32);
        let (v44, v45) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &v11, false);
        let v46 = v45;
        let v47 = v44;
        let v48 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, &v11, arg3, true, arg0);
        0x2::balance::join<T1>(&mut v10, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg1, arg2, &v11, arg3, true, arg0));
        let (v49, v50) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut v11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v11), arg0);
        let (v51, v52) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &v11, false);
        let v53 = v52;
        let v54 = v51;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v11);
        0x2::balance::join<T0>(&mut v9, v47);
        0x2::balance::join<T0>(&mut v9, v54);
        0x2::balance::join<T0>(&mut v9, v49);
        0x2::balance::join<T1>(&mut v10, v46);
        0x2::balance::join<T1>(&mut v10, v53);
        0x2::balance::join<T1>(&mut v10, v50);
        let v55 = flash_repay<T0, T1>(arg2, arg17);
        let v56 = flash_repay<T0, T1>(arg2, arg18);
        assert!(0x2::balance::value<T0>(&v9) >= v55, 4);
        assert!(0x2::balance::value<T1>(&v10) >= v56, 5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v9, v55), 0x2::balance::zero<T1>(), v5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_loan<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v10, v56), v8);
        let v57 = 0x2::balance::value<T0>(&v9);
        let v58 = 0x2::balance::value<T1>(&v10);
        let v59 = arg21 == 18446744073709551615 && arg22 == 18446744073709551615;
        if (!v59) {
            assert!(v57 >= v1, 6);
            assert!(v58 >= v2, 7);
        };
        let v60 = if (v57 >= v1) {
            v57 - v1
        } else {
            0
        };
        let v61 = if (v58 >= v2) {
            v58 - v2
        } else {
            0
        };
        if (!v59) {
            assert!(v60 >= arg21, 8);
            assert!(v61 >= arg22, 9);
        };
        let v62 = AtomicMagicResult{
            loan_a         : arg17,
            loan_b         : arg18,
            cetus_lp_a     : v13,
            cetus_lp_b     : v14,
            bluefin_lp_a   : v17,
            bluefin_lp_b   : v16,
            swap_b_in      : arg19,
            cetus_a_out    : v21,
            bluefin_a_in   : arg20,
            bluefin_b_out  : 0x2::balance::value<T1>(&v22),
            deepbook_a_in  : 0x2::balance::value<T0>(&v20),
            deepbook_b_out : 0x2::balance::value<T1>(&v26),
            cetus_fee_a    : 0x2::balance::value<T0>(&v47) + 0x2::balance::value<T0>(&v54),
            cetus_fee_b    : 0x2::balance::value<T1>(&v46) + 0x2::balance::value<T1>(&v53),
            bluefin_fee_a  : 0x2::balance::value<T0>(&v42),
            bluefin_fee_b  : 0x2::balance::value<T1>(&v43),
            cetus_reward   : 0x2::balance::value<T2>(&v48),
            bluefin_reward : 0x2::balance::value<T3>(&v27),
            final_a        : v57,
            final_b        : v58,
            profit_a       : v60,
            profit_b       : v61,
        };
        0x2::event::emit<AtomicMagicResult>(v62);
        transfer_profit_nonzero<T0>(v9);
        transfer_profit_nonzero<T1>(v10);
        transfer_profit_nonzero<T2>(v48);
        transfer_profit_nonzero<T3>(v27);
        let v63 = 0x2::tx_context::sender(arg24);
        transfer_nonzero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v25, v63, arg24);
    }

    fun swap_bluefin_a_to_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg0, arg1, arg2, false, true, 0x2::balance::value<T0>(&arg3), 79226673515401279992447579055 - 1);
        0x2::balance::join<T0>(&mut arg3, v1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg1, arg2, 0x2::balance::zero<T1>(), arg3, v2);
        v0
    }

    fun swap_cetus_b_to_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, 0x2::balance::value<T1>(&arg3), 79226673515401279992447579055, arg0);
        0x2::balance::join<T1>(&mut arg3, v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg3, v2);
        v0
    }

    fun swap_deepbook_quote_to_base<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: 0x2::balance::Balance<T1>, arg4: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg1, 0, 0x2::balance::value<T1>(&arg3), arg0);
        let (_, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg1);
        let v6 = v2 - v2 % v4;
        if (v6 < v5) {
            (0x2::balance::zero<T0>(), arg3, arg4)
        } else {
            let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg5);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg2, 0x2::coin::zero<T0>(arg5), arg5);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg2, 0x2::coin::from_balance<T1>(arg3, arg5), arg5);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4, arg5), arg5);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg1, arg2, &v10, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v6, true, true, arg0, arg5);
            (0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg2, arg5)), 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg2, arg5)), 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, arg5)))
        }
    }

    fun transfer_nonzero<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    fun transfer_profit_nonzero<T0>(arg0: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::balance::send_funds<T0>(arg0, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

