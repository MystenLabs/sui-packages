module 0xe2b36487510c25c5e25a2a12a672d9b6975202c171d95fce8ca41c06b213b8c8::liquidator_navi_flash {
    struct FlashLiqDiag has copy, drop {
        flash_amount: u64,
        leftover_debt: u64,
        coll_amount: u64,
        debt_shortfall: u64,
        coll_owed: u64,
        variant: u8,
    }

    public fun flash_liq_navi_a<T0, T1>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg9: address, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: u64, arg14: u128, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg0, arg6, arg13, arg12, arg17);
        let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg16, arg3, arg4, arg5, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg17);
        let v4 = v2;
        let v5 = v3;
        let v6 = 0x2::balance::value<T1>(&v4);
        let v7 = 0x2::balance::value<T0>(&v5);
        let v8 = if (arg13 > v7) {
            arg13 - v7
        } else {
            0
        };
        let v9 = FlashLiqDiag{
            flash_amount   : arg13,
            leftover_debt  : v7,
            coll_amount    : v6,
            debt_shortfall : v8,
            coll_owed      : 0,
            variant        : 0,
        };
        0x2::event::emit<FlashLiqDiag>(v9);
        if (v6 > 0 && v8 > 0) {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, false, v8, arg14, arg16);
            let v13 = v12;
            0x2::balance::destroy_zero<T1>(v11);
            let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v13);
            let v15 = FlashLiqDiag{
                flash_amount   : arg13,
                leftover_debt  : v7,
                coll_amount    : v6,
                debt_shortfall : v8,
                coll_owed      : v14,
                variant        : 0,
            };
            0x2::event::emit<FlashLiqDiag>(v15);
            assert!(v14 <= v6, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v4, v14), v13);
            0x2::balance::join<T0>(&mut v5, v10);
        };
        if (0x2::balance::value<T1>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg17), 0x2::tx_context::sender(arg17));
        } else {
            0x2::balance::destroy_zero<T1>(v4);
        };
        let v16 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg16, arg4, arg6, v1, v5, arg17);
        assert!(0x2::balance::value<T0>(&v16) >= arg15, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg17), 0x2::tx_context::sender(arg17));
    }

    public fun flash_liq_navi_b<T0, T1>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg9: address, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: u64, arg14: u128, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg0, arg6, arg13, arg12, arg17);
        let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg16, arg3, arg4, arg5, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg17);
        let v4 = v2;
        let v5 = v3;
        let v6 = 0x2::balance::value<T1>(&v4);
        let v7 = 0x2::balance::value<T0>(&v5);
        let v8 = if (arg13 > v7) {
            arg13 - v7
        } else {
            0
        };
        let v9 = FlashLiqDiag{
            flash_amount   : arg13,
            leftover_debt  : v7,
            coll_amount    : v6,
            debt_shortfall : v8,
            coll_owed      : 0,
            variant        : 1,
        };
        0x2::event::emit<FlashLiqDiag>(v9);
        if (v6 > 0 && v8 > 0) {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg1, arg2, true, false, v8, arg14, arg16);
            let v13 = v12;
            0x2::balance::destroy_zero<T1>(v10);
            let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v13);
            let v15 = FlashLiqDiag{
                flash_amount   : arg13,
                leftover_debt  : v7,
                coll_amount    : v6,
                debt_shortfall : v8,
                coll_owed      : v14,
                variant        : 1,
            };
            0x2::event::emit<FlashLiqDiag>(v15);
            assert!(v14 <= v6, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg1, arg2, 0x2::balance::split<T1>(&mut v4, v14), 0x2::balance::zero<T0>(), v13);
            0x2::balance::join<T0>(&mut v5, v11);
        };
        if (0x2::balance::value<T1>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg17), 0x2::tx_context::sender(arg17));
        } else {
            0x2::balance::destroy_zero<T1>(v4);
        };
        let v16 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg16, arg4, arg6, v1, v5, arg17);
        assert!(0x2::balance::value<T0>(&v16) >= arg15, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg17), 0x2::tx_context::sender(arg17));
    }

    // decompiled from Move bytecode v6
}

