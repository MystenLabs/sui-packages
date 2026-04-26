module 0x1ab876bee5fda2e5f67b34289e3e0ba722bcbbd0aef68c46ba2c889f72c2ac9f::liquidator_navi_flash {
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
        let v2 = v1;
        let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg16, arg3, arg4, arg5, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg17);
        let v5 = v3;
        let v6 = v4;
        let (_, _, _, _, v11, v12) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T0>(&v2);
        let v13 = arg13 + v11 + v12;
        let v14 = 0x2::balance::value<T1>(&v5);
        let v15 = 0x2::balance::value<T0>(&v6);
        let v16 = if (v13 > v15) {
            v13 - v15
        } else {
            0
        };
        let v17 = FlashLiqDiag{
            flash_amount   : arg13,
            leftover_debt  : v15,
            coll_amount    : v14,
            debt_shortfall : v16,
            coll_owed      : 0,
            variant        : 0,
        };
        0x2::event::emit<FlashLiqDiag>(v17);
        if (v14 > 0 && v16 > 0) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, false, v16, arg14, arg16);
            let v21 = v20;
            0x2::balance::destroy_zero<T1>(v19);
            let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v21);
            let v23 = FlashLiqDiag{
                flash_amount   : arg13,
                leftover_debt  : v15,
                coll_amount    : v14,
                debt_shortfall : v16,
                coll_owed      : v22,
                variant        : 0,
            };
            0x2::event::emit<FlashLiqDiag>(v23);
            assert!(v22 <= v14, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v5, v22), v21);
            0x2::balance::join<T0>(&mut v6, v18);
        };
        if (0x2::balance::value<T1>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg17), 0x2::tx_context::sender(arg17));
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
        let v24 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg16, arg4, arg6, v2, v6, arg17);
        assert!(0x2::balance::value<T0>(&v24) >= arg15, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v24, arg17), 0x2::tx_context::sender(arg17));
    }

    public fun flash_liq_navi_b<T0, T1>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg9: address, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: u64, arg14: u128, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx_v2<T0>(arg0, arg6, arg13, arg12, arg17);
        let v2 = v1;
        let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg16, arg3, arg4, arg5, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg17);
        let v5 = v3;
        let v6 = v4;
        let (_, _, _, _, v11, v12) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T0>(&v2);
        let v13 = arg13 + v11 + v12;
        let v14 = 0x2::balance::value<T1>(&v5);
        let v15 = 0x2::balance::value<T0>(&v6);
        let v16 = if (v13 > v15) {
            v13 - v15
        } else {
            0
        };
        let v17 = FlashLiqDiag{
            flash_amount   : arg13,
            leftover_debt  : v15,
            coll_amount    : v14,
            debt_shortfall : v16,
            coll_owed      : 0,
            variant        : 1,
        };
        0x2::event::emit<FlashLiqDiag>(v17);
        if (v14 > 0 && v16 > 0) {
            let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg1, arg2, true, false, v16, arg14, arg16);
            let v21 = v20;
            0x2::balance::destroy_zero<T1>(v18);
            let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v21);
            let v23 = FlashLiqDiag{
                flash_amount   : arg13,
                leftover_debt  : v15,
                coll_amount    : v14,
                debt_shortfall : v16,
                coll_owed      : v22,
                variant        : 1,
            };
            0x2::event::emit<FlashLiqDiag>(v23);
            assert!(v22 <= v14, 1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg1, arg2, 0x2::balance::split<T1>(&mut v5, v22), 0x2::balance::zero<T0>(), v21);
            0x2::balance::join<T0>(&mut v6, v19);
        };
        if (0x2::balance::value<T1>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg17), 0x2::tx_context::sender(arg17));
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
        let v24 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg16, arg4, arg6, v2, v6, arg17);
        assert!(0x2::balance::value<T0>(&v24) >= arg15, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v24, arg17), 0x2::tx_context::sender(arg17));
    }

    // decompiled from Move bytecode v6
}

