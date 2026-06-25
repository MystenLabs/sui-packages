module 0xab98a0a7e0c9550e7aa721e6ada11b24f4301fc8d8de9a84cbef9eea4a7e8574::alphalend_liq {
    struct AlphaCrossFlashDiag has copy, drop {
        flash_amount: u64,
        leftover_debt: u64,
        coll_seized: u64,
        debt_shortfall: u64,
        coll_owed: u64,
        final_profit: u64,
        variant: u8,
    }

    struct AlphaCross2HopDiag has copy, drop {
        flash_amount: u64,
        leftover_debt: u64,
        coll_seized: u64,
        mid_received: u64,
        debt_from_coll: u64,
        final_profit: u64,
        variant: u8,
    }

    struct NaviUsdcFlashDiag has copy, drop {
        flash_amount: u64,
        fee_total: u64,
        repay_needed: u64,
        usdc_provided: u64,
        final_profit: u64,
    }

    struct NaviUsdcReceipt<phantom T0> {
        receipt: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T0>,
        flash_amount: u64,
        min_profit: u64,
    }

    public fun finish_flash_navi_usdc<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: 0x2::coin::Coin<T0>, arg4: NaviUsdcReceipt<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let NaviUsdcReceipt {
            receipt      : v0,
            flash_amount : v1,
            min_profit   : v2,
        } = arg4;
        let v3 = v0;
        let (_, _, _, _, v8, v9) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T0>(&v3);
        let v10 = v8 + v9;
        let v11 = 0x2::coin::into_balance<T0>(arg3);
        let v12 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg0, arg1, arg2, v3, v11, arg5);
        let v13 = 0x2::balance::value<T0>(&v12);
        let v14 = NaviUsdcFlashDiag{
            flash_amount  : v1,
            fee_total     : v10,
            repay_needed  : v1 + v10,
            usdc_provided : 0x2::balance::value<T0>(&v11),
            final_profit  : v13,
        };
        0x2::event::emit<NaviUsdcFlashDiag>(v14);
        assert!(v13 >= v2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg5), 0x2::tx_context::sender(arg5));
    }

    public fun flash_liq_alphalend_2hop_cA_mA<T0, T1, T2>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg0, arg5, arg11, arg6, arg16);
        let (v2, v3) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, T1>(arg7, arg8, arg9, arg10, 0x2::coin::from_balance<T0>(v0, arg16), arg15, arg16);
        let v4 = 0x2::coin::into_balance<T0>(v3);
        let v5 = 0x2::coin::into_balance<T1>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg7, v2, arg15, arg16));
        let v6 = 0x2::balance::value<T1>(&v5);
        assert!(v6 > 0, 1);
        let v7 = swap_all_a_for_b<T1, T2>(arg1, arg2, v5, arg12, arg15);
        let v8 = swap_all_a_for_b<T2, T0>(arg1, arg3, v7, arg13, arg15);
        0x2::balance::join<T0>(&mut v4, v8);
        let v9 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg15, arg4, arg5, v1, v4, arg16);
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = AlphaCross2HopDiag{
            flash_amount   : arg11,
            leftover_debt  : 0x2::balance::value<T0>(&v4),
            coll_seized    : v6,
            mid_received   : 0x2::balance::value<T2>(&v7),
            debt_from_coll : 0x2::balance::value<T0>(&v8),
            final_profit   : v10,
            variant        : 0,
        };
        0x2::event::emit<AlphaCross2HopDiag>(v11);
        assert!(v10 >= arg14, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg16), 0x2::tx_context::sender(arg16));
    }

    public fun flash_liq_alphalend_2hop_cA_mB<T0, T1, T2>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg0, arg5, arg11, arg6, arg16);
        let (v2, v3) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, T1>(arg7, arg8, arg9, arg10, 0x2::coin::from_balance<T0>(v0, arg16), arg15, arg16);
        let v4 = 0x2::coin::into_balance<T0>(v3);
        let v5 = 0x2::coin::into_balance<T1>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg7, v2, arg15, arg16));
        let v6 = 0x2::balance::value<T1>(&v5);
        assert!(v6 > 0, 1);
        let v7 = swap_all_a_for_b<T1, T2>(arg1, arg2, v5, arg12, arg15);
        let v8 = swap_all_b_for_a<T0, T2>(arg1, arg3, v7, arg13, arg15);
        0x2::balance::join<T0>(&mut v4, v8);
        let v9 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg15, arg4, arg5, v1, v4, arg16);
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = AlphaCross2HopDiag{
            flash_amount   : arg11,
            leftover_debt  : 0x2::balance::value<T0>(&v4),
            coll_seized    : v6,
            mid_received   : 0x2::balance::value<T2>(&v7),
            debt_from_coll : 0x2::balance::value<T0>(&v8),
            final_profit   : v10,
            variant        : 1,
        };
        0x2::event::emit<AlphaCross2HopDiag>(v11);
        assert!(v10 >= arg14, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg16), 0x2::tx_context::sender(arg16));
    }

    public fun flash_liq_alphalend_2hop_cB_mA<T0, T1, T2>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg0, arg5, arg11, arg6, arg16);
        let (v2, v3) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, T1>(arg7, arg8, arg9, arg10, 0x2::coin::from_balance<T0>(v0, arg16), arg15, arg16);
        let v4 = 0x2::coin::into_balance<T0>(v3);
        let v5 = 0x2::coin::into_balance<T1>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg7, v2, arg15, arg16));
        let v6 = 0x2::balance::value<T1>(&v5);
        assert!(v6 > 0, 1);
        let v7 = swap_all_b_for_a<T2, T1>(arg1, arg2, v5, arg12, arg15);
        let v8 = swap_all_a_for_b<T2, T0>(arg1, arg3, v7, arg13, arg15);
        0x2::balance::join<T0>(&mut v4, v8);
        let v9 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg15, arg4, arg5, v1, v4, arg16);
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = AlphaCross2HopDiag{
            flash_amount   : arg11,
            leftover_debt  : 0x2::balance::value<T0>(&v4),
            coll_seized    : v6,
            mid_received   : 0x2::balance::value<T2>(&v7),
            debt_from_coll : 0x2::balance::value<T0>(&v8),
            final_profit   : v10,
            variant        : 2,
        };
        0x2::event::emit<AlphaCross2HopDiag>(v11);
        assert!(v10 >= arg14, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg16), 0x2::tx_context::sender(arg16));
    }

    public fun flash_liq_alphalend_2hop_cB_mB<T0, T1, T2>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg8: 0x2::object::ID, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg0, arg5, arg11, arg6, arg16);
        let (v2, v3) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, T1>(arg7, arg8, arg9, arg10, 0x2::coin::from_balance<T0>(v0, arg16), arg15, arg16);
        let v4 = 0x2::coin::into_balance<T0>(v3);
        let v5 = 0x2::coin::into_balance<T1>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg7, v2, arg15, arg16));
        let v6 = 0x2::balance::value<T1>(&v5);
        assert!(v6 > 0, 1);
        let v7 = swap_all_b_for_a<T2, T1>(arg1, arg2, v5, arg12, arg15);
        let v8 = swap_all_b_for_a<T0, T2>(arg1, arg3, v7, arg13, arg15);
        0x2::balance::join<T0>(&mut v4, v8);
        let v9 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg15, arg4, arg5, v1, v4, arg16);
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = AlphaCross2HopDiag{
            flash_amount   : arg11,
            leftover_debt  : 0x2::balance::value<T0>(&v4),
            coll_seized    : v6,
            mid_received   : 0x2::balance::value<T2>(&v7),
            debt_from_coll : 0x2::balance::value<T0>(&v8),
            final_profit   : v10,
            variant        : 3,
        };
        0x2::event::emit<AlphaCross2HopDiag>(v11);
        assert!(v10 >= arg14, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg16), 0x2::tx_context::sender(arg16));
    }

    public fun flash_liq_alphalend_a<T0, T1>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg0, arg4, arg10, arg5, arg14);
        let v2 = v1;
        let (v3, v4) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, T1>(arg6, arg7, arg8, arg9, 0x2::coin::from_balance<T0>(v0, arg14), arg13, arg14);
        let v5 = 0x2::coin::into_balance<T0>(v4);
        let v6 = 0x2::coin::into_balance<T1>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg6, v3, arg13, arg14));
        let (_, _, _, _, v11, v12) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T0>(&v2);
        let v13 = arg10 + v11 + v12;
        let v14 = 0x2::balance::value<T1>(&v6);
        let v15 = 0x2::balance::value<T0>(&v5);
        let v16 = if (v13 > v15) {
            v13 - v15
        } else {
            0
        };
        let v17 = 0;
        if (v14 > 0 && v16 > 0) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, false, v16, arg11, arg13);
            let v21 = v20;
            0x2::balance::destroy_zero<T1>(v19);
            let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v21);
            v17 = v22;
            assert!(v22 <= v14, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v6, v22), v21);
            0x2::balance::join<T0>(&mut v5, v18);
        };
        if (0x2::balance::value<T1>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg14), 0x2::tx_context::sender(arg14));
        } else {
            0x2::balance::destroy_zero<T1>(v6);
        };
        let v23 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg13, arg3, arg4, v2, v5, arg14);
        let v24 = 0x2::balance::value<T0>(&v23);
        let v25 = AlphaCrossFlashDiag{
            flash_amount   : arg10,
            leftover_debt  : v15,
            coll_seized    : v14,
            debt_shortfall : v16,
            coll_owed      : v17,
            final_profit   : v24,
            variant        : 0,
        };
        0x2::event::emit<AlphaCrossFlashDiag>(v25);
        assert!(v24 >= arg12, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v23, arg14), 0x2::tx_context::sender(arg14));
    }

    public fun flash_liq_alphalend_a_collsui<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg0, arg4, arg10, arg5, arg14);
        let v2 = v1;
        let (v3, v4) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, 0x2::sui::SUI>(arg6, arg7, arg8, arg9, 0x2::coin::from_balance<T0>(v0, arg14), arg13, arg14);
        let v5 = 0x2::coin::into_balance<T0>(v4);
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg6, v3, arg5, arg13, arg14));
        let (_, _, _, _, v11, v12) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T0>(&v2);
        let v13 = arg10 + v11 + v12;
        let v14 = 0x2::balance::value<0x2::sui::SUI>(&v6);
        let v15 = 0x2::balance::value<T0>(&v5);
        let v16 = if (v13 > v15) {
            v13 - v15
        } else {
            0
        };
        let v17 = 0;
        if (v14 > 0 && v16 > 0) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, false, false, v16, arg11, arg13);
            let v21 = v20;
            0x2::balance::destroy_zero<0x2::sui::SUI>(v19);
            let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v21);
            v17 = v22;
            assert!(v22 <= v14, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v6, v22), v21);
            0x2::balance::join<T0>(&mut v5, v18);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg14), 0x2::tx_context::sender(arg14));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
        };
        let v23 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg13, arg3, arg4, v2, v5, arg14);
        let v24 = 0x2::balance::value<T0>(&v23);
        let v25 = AlphaCrossFlashDiag{
            flash_amount   : arg10,
            leftover_debt  : v15,
            coll_seized    : v14,
            debt_shortfall : v16,
            coll_owed      : v17,
            final_profit   : v24,
            variant        : 2,
        };
        0x2::event::emit<AlphaCrossFlashDiag>(v25);
        assert!(v24 >= arg12, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v23, arg14), 0x2::tx_context::sender(arg14));
    }

    public fun flash_liq_alphalend_b<T0, T1>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg0, arg4, arg10, arg5, arg14);
        let v2 = v1;
        let (v3, v4) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, T1>(arg6, arg7, arg8, arg9, 0x2::coin::from_balance<T0>(v0, arg14), arg13, arg14);
        let v5 = 0x2::coin::into_balance<T0>(v4);
        let v6 = 0x2::coin::into_balance<T1>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg6, v3, arg13, arg14));
        let (_, _, _, _, v11, v12) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T0>(&v2);
        let v13 = arg10 + v11 + v12;
        let v14 = 0x2::balance::value<T1>(&v6);
        let v15 = 0x2::balance::value<T0>(&v5);
        let v16 = if (v13 > v15) {
            v13 - v15
        } else {
            0
        };
        let v17 = 0;
        if (v14 > 0 && v16 > 0) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg1, arg2, true, false, v16, arg11, arg13);
            let v21 = v20;
            0x2::balance::destroy_zero<T1>(v18);
            let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v21);
            v17 = v22;
            assert!(v22 <= v14, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg1, arg2, 0x2::balance::split<T1>(&mut v6, v22), 0x2::balance::zero<T0>(), v21);
            0x2::balance::join<T0>(&mut v5, v19);
        };
        if (0x2::balance::value<T1>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg14), 0x2::tx_context::sender(arg14));
        } else {
            0x2::balance::destroy_zero<T1>(v6);
        };
        let v23 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg13, arg3, arg4, v2, v5, arg14);
        let v24 = 0x2::balance::value<T0>(&v23);
        let v25 = AlphaCrossFlashDiag{
            flash_amount   : arg10,
            leftover_debt  : v15,
            coll_seized    : v14,
            debt_shortfall : v16,
            coll_owed      : v17,
            final_profit   : v24,
            variant        : 1,
        };
        0x2::event::emit<AlphaCrossFlashDiag>(v25);
        assert!(v24 >= arg12, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v23, arg14), 0x2::tx_context::sender(arg14));
    }

    public fun liquidate_with_debt<T0, T1>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, T1>(arg0, arg2, arg3, arg4, arg1, arg5, arg6);
        let v2 = v1;
        let v3 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg0, v0, arg5, arg6);
        assert!(0x2::coin::value<T1>(&v3) > 0, 1);
        if (0x2::coin::value<T0>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        v3
    }

    public fun liquidate_with_debt_collsui<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, 0x2::sui::SUI>(arg0, arg3, arg4, arg5, arg2, arg6, arg7);
        let v2 = v1;
        let v3 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg0, v0, arg1, arg6, arg7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v3) > 0, 1);
        if (0x2::coin::value<T0>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        v3
    }

    public fun start_flash_navi_usdc<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, NaviUsdcReceipt<T0>) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg0, arg1, arg3, arg2, arg5);
        let v2 = NaviUsdcReceipt<T0>{
            receipt      : v1,
            flash_amount : arg3,
            min_profit   : arg4,
        };
        (0x2::coin::from_balance<T0>(v0, arg5), v2)
    }

    fun swap_all_a_for_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u128, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), arg3, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        0x2::balance::destroy_zero<T0>(arg2);
        v1
    }

    fun swap_all_b_for_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u128, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), arg3, arg4);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        0x2::balance::destroy_zero<T1>(arg2);
        v0
    }

    // decompiled from Move bytecode v7
}

