module 0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic {
    struct Liquidated has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        debt_asset: u8,
        collateral_asset: u8,
        repay_raw: u64,
        collateral_out_raw: u64,
        collateral_paid_raw: u64,
        collateral_profit_raw: u64,
        debt_remainder_raw: u64,
        route_hops: u8,
    }

    fun finish<T0, T1>(arg0: &mut 0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::LiquidationVault, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: address, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u8) {
        0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::deposit_balance<T0>(arg0, arg1);
        0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::deposit_balance<T1>(arg0, arg2);
        let v0 = Liquidated{
            vault_id              : 0x2::object::id<0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::LiquidationVault>(arg0),
            user                  : arg3,
            debt_asset            : arg4,
            collateral_asset      : arg5,
            repay_raw             : arg6,
            collateral_out_raw    : arg7,
            collateral_paid_raw   : arg8,
            collateral_profit_raw : 0x2::balance::value<T0>(&arg1),
            debt_remainder_raw    : 0x2::balance::value<T1>(&arg2),
            route_hops            : arg9,
        };
        0x2::event::emit<Liquidated>(v0);
    }

    fun liquidate<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: address, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    fun live_repay(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: address, arg4: u8, arg5: u8, arg6: u8, arg7: u64, arg8: bool, arg9: &0x2::tx_context::TxContext) : u64 {
        0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::gate::exact_pair_repay_raw(arg0, arg1, arg2, 0x2::tx_context::sender(arg9), arg3, arg4, arg5, arg6, arg7, arg8)
    }

    fun require_profit<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64, arg2: u64) {
        assert!(arg1 <= 18446744073709551615 - arg2, 1);
        assert!(0x2::balance::value<T0>(arg0) >= arg1 + arg2, 1);
    }

    fun settle_direct_a_to_b<T0, T1>(arg0: &mut 0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::LiquidationVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: u64, arg8: address, arg9: u8, arg10: u8, arg11: u64) {
        require_profit<T0>(&arg4, arg6, arg7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut arg4, arg6), 0x2::balance::zero<T1>(), arg3);
        finish<T0, T1>(arg0, arg4, arg5, arg8, arg9, arg10, arg11, 0x2::balance::value<T0>(&arg4), arg6, 1);
    }

    fun settle_direct_b_to_a<T0, T1>(arg0: &mut 0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::LiquidationVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg4: 0x2::balance::Balance<T1>, arg5: 0x2::balance::Balance<T0>, arg6: u64, arg7: u64, arg8: address, arg9: u8, arg10: u8, arg11: u64) {
        require_profit<T1>(&arg4, arg6, arg7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg4, arg6), arg3);
        finish<T1, T0>(arg0, arg4, arg5, arg8, arg9, arg10, arg11, 0x2::balance::value<T1>(&arg4), arg6, 1);
    }

    public fun try_direct_a_to_b<T0, T1>(arg0: &mut 0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::LiquidationVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: address, arg12: u8, arg13: u8, arg14: u8, arg15: u64, arg16: bool, arg17: u128, arg18: u64, arg19: &mut 0x2::tx_context::TxContext) : bool {
        0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::assert_authorized(arg0, arg19);
        assert!(arg17 > 0, 0);
        let v0 = live_repay(arg3, arg4, arg5, arg11, arg12, arg13, arg14, arg15, arg16, arg19);
        if (v0 == 0) {
            return false
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, false, v0, arg17, arg3);
        let v4 = v3;
        let (v5, v6) = liquidate<T1, T0>(arg3, arg4, arg5, arg12, arg6, v2, arg13, arg7, arg11, arg8, arg9, arg10, arg19);
        let v7 = v5;
        0x2::balance::join<T0>(&mut v7, v1);
        settle_direct_a_to_b<T0, T1>(arg0, arg1, arg2, v4, v7, v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg18, arg11, arg12, arg13, v0);
        true
    }

    public fun try_direct_b_to_a<T0, T1>(arg0: &mut 0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::LiquidationVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: address, arg12: u8, arg13: u8, arg14: u8, arg15: u64, arg16: bool, arg17: u128, arg18: u64, arg19: &mut 0x2::tx_context::TxContext) : bool {
        0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::assert_authorized(arg0, arg19);
        assert!(arg17 > 0, 0);
        let v0 = live_repay(arg3, arg4, arg5, arg11, arg12, arg13, arg14, arg15, arg16, arg19);
        if (v0 == 0) {
            return false
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, false, v0, arg17, arg3);
        let v4 = v3;
        let (v5, v6) = liquidate<T0, T1>(arg3, arg4, arg5, arg12, arg6, v1, arg13, arg7, arg11, arg8, arg9, arg10, arg19);
        let v7 = v5;
        0x2::balance::join<T1>(&mut v7, v2);
        settle_direct_b_to_a<T0, T1>(arg0, arg1, arg2, v4, v7, v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg18, arg11, arg12, arg13, v0);
        true
    }

    public fun try_three_ab_ba_ab<T0, T1, T2, T3>(arg0: &mut 0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::LiquidationVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T3>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: address, arg14: u8, arg15: u8, arg16: u8, arg17: u64, arg18: bool, arg19: u128, arg20: u128, arg21: u128, arg22: u64, arg23: &mut 0x2::tx_context::TxContext) : bool {
        0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::assert_authorized(arg0, arg23);
        let v0 = if (arg19 > 0) {
            if (arg20 > 0) {
                arg21 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = live_repay(arg5, arg6, arg7, arg13, arg14, arg15, arg16, arg17, arg18, arg23);
        if (v1 == 0) {
            return false
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg1, arg4, true, false, v1, arg21, arg5);
        let v5 = v4;
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg1, arg3, false, false, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v5), arg20, arg5);
        let v9 = v8;
        let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, false, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v9), arg19, arg5);
        let v13 = v12;
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v13);
        let (v15, v16) = liquidate<T3, T0>(arg5, arg6, arg7, arg14, arg8, v3, arg15, arg9, arg13, arg10, arg11, arg12, arg23);
        let v17 = v15;
        0x2::balance::join<T0>(&mut v17, v10);
        require_profit<T0>(&v17, v14, arg22);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v17, v14), 0x2::balance::zero<T1>(), v13);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg1, arg3, v6, v11, v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg1, arg4, v2, 0x2::balance::zero<T3>(), v5);
        0x2::balance::destroy_zero<T1>(v7);
        finish<T0, T3>(arg0, v17, v16, arg13, arg14, arg15, v1, 0x2::balance::value<T0>(&v17), v14, 3);
        true
    }

    public fun try_two_ab_ab<T0, T1, T2>(arg0: &mut 0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::LiquidationVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &0x2::clock::Clock, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: address, arg13: u8, arg14: u8, arg15: u8, arg16: u64, arg17: bool, arg18: u128, arg19: u128, arg20: u64, arg21: &mut 0x2::tx_context::TxContext) : bool {
        0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::assert_authorized(arg0, arg21);
        assert!(arg18 > 0 && arg19 > 0, 0);
        let v0 = live_repay(arg4, arg5, arg6, arg12, arg13, arg14, arg15, arg16, arg17, arg21);
        if (v0 == 0) {
            return false
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg1, arg3, true, false, v0, arg19, arg4);
        let v4 = v3;
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, false, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v4), arg18, arg4);
        let v8 = v7;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v8);
        let (v10, v11) = liquidate<T2, T0>(arg4, arg5, arg6, arg13, arg7, v2, arg14, arg8, arg12, arg9, arg10, arg11, arg21);
        let v12 = v10;
        0x2::balance::join<T0>(&mut v12, v5);
        require_profit<T0>(&v12, v9, arg20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v12, v9), 0x2::balance::zero<T1>(), v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg1, arg3, v6, 0x2::balance::zero<T2>(), v4);
        0x2::balance::destroy_zero<T1>(v1);
        finish<T0, T2>(arg0, v12, v11, arg12, arg13, arg14, v0, 0x2::balance::value<T0>(&v12), v9, 2);
        true
    }

    public fun try_two_ab_ba<T0, T1, T2>(arg0: &mut 0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::LiquidationVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &0x2::clock::Clock, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: address, arg13: u8, arg14: u8, arg15: u8, arg16: u64, arg17: bool, arg18: u128, arg19: u128, arg20: u64, arg21: &mut 0x2::tx_context::TxContext) : bool {
        0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::assert_authorized(arg0, arg21);
        assert!(arg18 > 0 && arg19 > 0, 0);
        let v0 = live_repay(arg4, arg5, arg6, arg12, arg13, arg14, arg15, arg16, arg17, arg21);
        if (v0 == 0) {
            return false
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg1, arg3, false, false, v0, arg19, arg4);
        let v4 = v3;
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, false, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v4), arg18, arg4);
        let v8 = v7;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v8);
        let (v10, v11) = liquidate<T2, T0>(arg4, arg5, arg6, arg13, arg7, v1, arg14, arg8, arg12, arg9, arg10, arg11, arg21);
        let v12 = v10;
        0x2::balance::join<T0>(&mut v12, v5);
        require_profit<T0>(&v12, v9, arg20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v12, v9), 0x2::balance::zero<T1>(), v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg1, arg3, 0x2::balance::zero<T2>(), v6, v4);
        0x2::balance::destroy_zero<T1>(v2);
        finish<T0, T2>(arg0, v12, v11, arg12, arg13, arg14, v0, 0x2::balance::value<T0>(&v12), v9, 2);
        true
    }

    public fun try_two_ba_ab<T0, T1, T2>(arg0: &mut 0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::LiquidationVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &0x2::clock::Clock, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: address, arg13: u8, arg14: u8, arg15: u8, arg16: u64, arg17: bool, arg18: u128, arg19: u128, arg20: u64, arg21: &mut 0x2::tx_context::TxContext) : bool {
        0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::assert_authorized(arg0, arg21);
        assert!(arg18 > 0 && arg19 > 0, 0);
        let v0 = live_repay(arg4, arg5, arg6, arg12, arg13, arg14, arg15, arg16, arg17, arg21);
        if (v0 == 0) {
            return false
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg1, arg3, true, false, v0, arg19, arg4);
        let v4 = v3;
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg1, arg2, false, false, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v4), arg18, arg4);
        let v8 = v7;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v8);
        let (v10, v11) = liquidate<T2, T0>(arg4, arg5, arg6, arg13, arg7, v2, arg14, arg8, arg12, arg9, arg10, arg11, arg21);
        let v12 = v10;
        0x2::balance::join<T0>(&mut v12, v6);
        require_profit<T0>(&v12, v9, arg20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg1, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v12, v9), v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg1, arg3, v5, 0x2::balance::zero<T2>(), v4);
        0x2::balance::destroy_zero<T1>(v1);
        finish<T0, T2>(arg0, v12, v11, arg12, arg13, arg14, v0, 0x2::balance::value<T0>(&v12), v9, 2);
        true
    }

    public fun try_two_ba_ba<T0, T1, T2>(arg0: &mut 0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::LiquidationVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &0x2::clock::Clock, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: address, arg13: u8, arg14: u8, arg15: u8, arg16: u64, arg17: bool, arg18: u128, arg19: u128, arg20: u64, arg21: &mut 0x2::tx_context::TxContext) : bool {
        0xd7a2b43235459be0a72b2a7ae83a22d8b1437bd254a443a579d1237839af6e7f::atomic_vault::assert_authorized(arg0, arg21);
        assert!(arg18 > 0 && arg19 > 0, 0);
        let v0 = live_repay(arg4, arg5, arg6, arg12, arg13, arg14, arg15, arg16, arg17, arg21);
        if (v0 == 0) {
            return false
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg1, arg3, false, false, v0, arg19, arg4);
        let v4 = v3;
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg1, arg2, false, false, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v4), arg18, arg4);
        let v8 = v7;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v8);
        let (v10, v11) = liquidate<T2, T0>(arg4, arg5, arg6, arg13, arg7, v1, arg14, arg8, arg12, arg9, arg10, arg11, arg21);
        let v12 = v10;
        0x2::balance::join<T0>(&mut v12, v6);
        require_profit<T0>(&v12, v9, arg20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg1, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v12, v9), v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg1, arg3, 0x2::balance::zero<T2>(), v5, v4);
        0x2::balance::destroy_zero<T1>(v2);
        finish<T0, T2>(arg0, v12, v11, arg12, arg13, arg14, v0, 0x2::balance::value<T0>(&v12), v9, 2);
        true
    }

    // decompiled from Move bytecode v7
}

