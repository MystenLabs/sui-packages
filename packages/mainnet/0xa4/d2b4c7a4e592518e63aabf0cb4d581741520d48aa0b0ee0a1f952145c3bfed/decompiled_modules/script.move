module 0xa4d2b4c7a4e592518e63aabf0cb4d581741520d48aa0b0ee0a1f952145c3bfed::script {
    struct Profit has copy, drop {
        type_id: 0x1::ascii::String,
        amount: u64,
    }

    public entry fun arb_stables_via_wusdc_bridge<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::LiquidityPool<T1, T2, T0, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::curves::Stable>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u128, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg4);
        if (!arg8) {
            let (v1, v2) = cetus_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v0, arg5), 0x2::balance::zero<T1>(), true, true, arg5, 1, arg7, arg0, arg9);
            0x2::balance::destroy_zero<T0>(v1);
            let (v3, v4, v5) = 0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::swap<T1, T2, T0, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::curves::Stable>(arg0, arg3, v2, 0, 0x2::balance::zero<T2>(), 0, 0x2::balance::zero<T0>(), 1, true);
            let v6 = v5;
            0x2::balance::destroy_zero<T1>(v3);
            0x2::balance::destroy_zero<T2>(v4);
            if (arg6 > 0) {
                let v7 = 0x2::balance::value<T0>(&v6);
                assert!(v7 > arg5 + arg6, 15543);
                let v8 = Profit{
                    type_id : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                    amount  : v7 - arg5,
                };
                0x2::event::emit<Profit>(v8);
            };
            0x2::balance::join<T0>(&mut v0, v6);
        } else {
            let (v9, v10, v11) = 0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::swap<T1, T2, T0, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::curves::Stable>(arg0, arg3, 0x2::balance::zero<T1>(), 1, 0x2::balance::zero<T2>(), 0, 0x2::balance::split<T0>(&mut v0, arg5), 0, true);
            let v12 = v9;
            0x2::balance::destroy_zero<T0>(v11);
            0x2::balance::destroy_zero<T2>(v10);
            let (v13, v14) = cetus_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v12, false, true, 0x2::balance::value<T1>(&v12), 1, arg7, arg0, arg9);
            let v15 = v13;
            0x2::balance::destroy_zero<T1>(v14);
            if (arg6 > 0) {
                let v16 = 0x2::balance::value<T0>(&v15);
                assert!(v16 > arg5 + arg6, 15543);
                let v17 = Profit{
                    type_id : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                    amount  : v16 - arg5,
                };
                0x2::event::emit<Profit>(v17);
            };
            0x2::balance::join<T0>(&mut v0, v15);
        };
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg9), arg9);
    }

    public entry fun arb_stables_via_wusdt_bridge<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::LiquidityPool<T1, T2, T0, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::curves::Stable>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u128, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T1>(arg4);
        if (!arg8) {
            let (v1, v2) = cetus_swap<T2, T1>(arg1, arg2, 0x2::balance::zero<T2>(), 0x2::balance::split<T1>(&mut v0, arg5), false, true, arg5, 1, arg7, arg0, arg9);
            0x2::balance::destroy_zero<T1>(v2);
            let (v3, v4, v5) = 0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::swap<T1, T2, T0, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::curves::Stable>(arg0, arg3, 0x2::balance::zero<T1>(), 1, v1, 0, 0x2::balance::zero<T0>(), 0, true);
            let v6 = v3;
            0x2::balance::destroy_zero<T2>(v4);
            0x2::balance::destroy_zero<T0>(v5);
            if (arg6 > 0) {
                let v7 = 0x2::balance::value<T1>(&v6);
                assert!(v7 > arg5 + arg6, 15543);
                let v8 = Profit{
                    type_id : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
                    amount  : v7 - arg5,
                };
                0x2::event::emit<Profit>(v8);
            };
            0x2::balance::join<T1>(&mut v0, v6);
        } else {
            let (v9, v10, v11) = 0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::swap<T1, T2, T0, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::curves::Stable>(arg0, arg3, 0x2::balance::split<T1>(&mut v0, arg5), 0, 0x2::balance::zero<T2>(), 1, 0x2::balance::zero<T0>(), 0, true);
            let v12 = v10;
            0x2::balance::destroy_zero<T0>(v11);
            0x2::balance::destroy_zero<T1>(v9);
            let (v13, v14) = cetus_swap<T2, T1>(arg1, arg2, v12, 0x2::balance::zero<T1>(), true, true, 0x2::balance::value<T2>(&v12), 1, arg7, arg0, arg9);
            let v15 = v14;
            0x2::balance::destroy_zero<T2>(v13);
            if (arg6 > 0) {
                let v16 = 0x2::balance::value<T1>(&v15);
                assert!(v16 > arg5 + arg6, 15543);
                let v17 = Profit{
                    type_id : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
                    amount  : v16 - arg5,
                };
                0x2::event::emit<Profit>(v17);
            };
            0x2::balance::join<T1>(&mut v0, v15);
        };
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T1>(v0, 0x2::tx_context::sender(arg9), arg9);
    }

    public entry fun arb_sui_X_via_cetus<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LiquidityPool<T0, 0x2::sui::SUI, T1>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        let (v1, v2) = cetus_swap<T0, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg5), false, true, arg5, 1, arg7, arg0, arg8);
        let (v3, v4) = 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::swap<T0, 0x2::sui::SUI, T1>(arg0, arg3, v1, 0, 0x2::balance::zero<0x2::sui::SUI>(), 1, true);
        let v5 = v4;
        0x2::balance::destroy_zero<T0>(v3);
        if (arg6 > 0) {
            let v6 = 0x2::balance::value<0x2::sui::SUI>(&v5);
            assert!(arg5 > v6 + arg6, 15543);
            let v7 = Profit{
                type_id : 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()),
                amount  : arg5 - v6,
            };
            0x2::event::emit<Profit>(v7);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v5);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v2);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg8), arg8);
    }

    public entry fun arb_sui_X_via_degenhive<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LiquidityPool<T0, 0x2::sui::SUI, T1>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        let (v1, v2) = 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::swap<T0, 0x2::sui::SUI, T1>(arg0, arg3, 0x2::balance::zero<T0>(), 1, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg5), 0, true);
        let v3 = v1;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
        let (v4, v5) = cetus_swap<T0, 0x2::sui::SUI>(arg1, arg2, v3, 0x2::balance::zero<0x2::sui::SUI>(), true, true, 0x2::balance::value<T0>(&v3), 1, arg7, arg0, arg8);
        let v6 = v5;
        0x2::balance::destroy_zero<T0>(v4);
        if (arg6 > 0) {
            let v7 = 0x2::balance::value<0x2::sui::SUI>(&v6);
            assert!(arg5 > v7 + arg6, 15543);
            let v8 = Profit{
                type_id : 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()),
                amount  : arg5 - v7,
            };
            0x2::event::emit<Profit>(v8);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v6);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg8), arg8);
    }

    public entry fun arb_sui_dsui_via_staking(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::dsui_vault::DSuiVault, arg3: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LiquidityPool<0x2::sui::SUI, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::curves::Stable>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        let (v1, v2) = 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::swap<0x2::sui::SUI, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::curves::Stable>(arg0, arg3, 0x2::balance::zero<0x2::sui::SUI>(), 1, 0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::dsui_vault::stake_sui_request(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg5), 0x1::option::none<address>(), arg7), 0, true);
        let v3 = v1;
        0x2::balance::destroy_zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(v2);
        if (arg6 > 0) {
            let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
            assert!(v4 > v4 + arg6, 15543);
            let v5 = Profit{
                type_id : 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()),
                amount  : v4 - arg5,
            };
            0x2::event::emit<Profit>(v5);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v3);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg7), arg7);
    }

    public entry fun arb_sui_dsui_via_swap(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::dsui_vault::DSuiVault, arg3: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LiquidityPool<0x2::sui::SUI, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::curves::Stable>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        let (v1, v2) = 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::swap<0x2::sui::SUI, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI, 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::curves::Stable>(arg0, arg3, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg5), 0, 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::dsui::DSUI>(), 1, true);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        let v3 = 0x53578180d93e5fa7b10334045c4565e3c743f0eb64c89932b14adb1b0baab145::dsui_vault::request_instant_unstake(arg1, arg2, v2, arg7);
        if (arg6 > 0) {
            let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
            assert!(v4 > v4 + arg6, 15543);
            let v5 = Profit{
                type_id : 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()),
                amount  : v4 - arg5,
            };
            0x2::event::emit<Profit>(v5);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut v0, v3);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg7), arg7);
    }

    public fun cetus_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, arg9);
        let v3 = v2;
        let (v4, v5) = if (arg4) {
            (0x2::balance::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)))
        };
        0x2::balance::join<T1>(&mut arg3, v1);
        0x2::balance::join<T0>(&mut arg2, v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v4, v5, v3);
        (arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

