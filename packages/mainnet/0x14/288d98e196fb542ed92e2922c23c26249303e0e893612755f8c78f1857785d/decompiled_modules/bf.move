module 0x14288d98e196fb542ed92e2922c23c26249303e0e893612755f8c78f1857785d::bf {
    fun borrow_ab<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, 0x2::sui::SUI>) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg3, arg0, arg1, false, false, arg2, 79226673515401279992447579055);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        (v0, v2)
    }

    fun borrow_ba<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<0x2::sui::SUI, T0>) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T0>(arg3, arg0, arg1, true, false, arg2, 4295048016);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        (v1, v2)
    }

    public fun exact_amount(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: u8, arg5: address, arg6: u8, arg7: u64) : u64 {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_value(arg0, arg1, arg2, arg3, arg5);
        if (v0 == 0) {
            return 0
        };
        let (v1, _, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg2, arg4);
        let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg0, arg1, arg2, arg4, arg5), v1);
        let v5 = v4;
        if (v4 > v0) {
            v5 = v0;
        };
        let v6 = if (arg6 <= 9) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg1, v5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg2, arg3)) / pow10(9 - arg6)
        } else {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg0, arg1, v5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg2, arg3)) * pow10(arg6 - 9)
        };
        if (v6 < (arg7 as u256)) {
            (v6 as u64)
        } else {
            arg7
        }
    }

    fun keep<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    fun liquidate_sui<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg0, arg3, arg4, v0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(v1), arg7);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg0, arg3, &v2, arg6, arg7);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg0, arg3, v2, arg7)
    }

    public fun navi_ab_ab<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg11: address, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg14: &mut 0x3::sui_system::SuiSystemState, arg15: u64, arg16: u8, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = exact_amount(arg4, arg5, arg6, arg7, arg9, arg11, arg16, arg15);
        let (v1, v2) = borrow_ab<T0>(arg0, arg1, v0, arg4);
        let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg7, arg8, v1, arg9, arg10, arg11, arg12, arg13, arg14, arg18);
        let v5 = v3;
        let (v6, v7) = sell_ab<T0>(arg2, arg3, v4, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut v5, v6);
        settle_ab<T0>(arg0, arg1, v5, v7, v2, arg17, arg18);
    }

    public fun navi_ab_ba<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg4: &0x2::clock::Clock, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg11: address, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg14: &mut 0x3::sui_system::SuiSystemState, arg15: u64, arg16: u8, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = exact_amount(arg4, arg5, arg6, arg7, arg9, arg11, arg16, arg15);
        let (v1, v2) = borrow_ab<T0>(arg0, arg1, v0, arg4);
        let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg7, arg8, v1, arg9, arg10, arg11, arg12, arg13, arg14, arg18);
        let v5 = v3;
        let (v6, v7) = sell_ba<T0>(arg2, arg3, v4, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut v5, v6);
        settle_ab<T0>(arg0, arg1, v5, v7, v2, arg17, arg18);
    }

    public fun navi_ba_ab<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg11: address, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg14: &mut 0x3::sui_system::SuiSystemState, arg15: u64, arg16: u8, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = exact_amount(arg4, arg5, arg6, arg7, arg9, arg11, arg16, arg15);
        let (v1, v2) = borrow_ba<T0>(arg0, arg1, v0, arg4);
        let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg7, arg8, v1, arg9, arg10, arg11, arg12, arg13, arg14, arg18);
        let v5 = v3;
        let (v6, v7) = sell_ab<T0>(arg2, arg3, v4, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut v5, v6);
        settle_ba<T0>(arg0, arg1, v5, v7, v2, arg17, arg18);
    }

    public fun navi_ba_ba<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg4: &0x2::clock::Clock, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: u8, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg11: address, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg14: &mut 0x3::sui_system::SuiSystemState, arg15: u64, arg16: u8, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = exact_amount(arg4, arg5, arg6, arg7, arg9, arg11, arg16, arg15);
        let (v1, v2) = borrow_ba<T0>(arg0, arg1, v0, arg4);
        let (v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg7, arg8, v1, arg9, arg10, arg11, arg12, arg13, arg14, arg18);
        let v5 = v3;
        let (v6, v7) = sell_ba<T0>(arg2, arg3, v4, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut v5, v6);
        settle_ba<T0>(arg0, arg1, v5, v7, v2, arg17, arg18);
    }

    fun pow10(arg0: u8) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun sell_ab<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 < 1000) {
            return (0x2::balance::zero<0x2::sui::SUI>(), arg2)
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, true, true, v0, 4295048016, arg3);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v4)), 0x2::balance::zero<0x2::sui::SUI>(), v4);
        (v2, arg2)
    }

    fun sell_ba<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 < 1000) {
            return (0x2::balance::zero<0x2::sui::SUI>(), arg2)
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg0, arg1, false, true, v0, 79226673515401279992447579055, arg3);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg0, arg1, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::balance::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v4)), v4);
        (v1, arg2)
    }

    fun settle_ab<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x2::balance::Balance<T0>, arg4: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<T0, 0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&arg4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2) >= v0 + arg5, 1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut arg2, v0), arg4);
        keep<0x2::sui::SUI>(arg2, arg6);
        keep<T0>(arg3, arg6);
    }

    fun settle_ba<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x2::balance::Balance<T0>, arg4: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::FlashSwapReceipt<0x2::sui::SUI, T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, T0>(&arg4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2) >= v0 + arg5, 1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, v0), 0x2::balance::zero<T0>(), arg4);
        keep<0x2::sui::SUI>(arg2, arg6);
        keep<T0>(arg3, arg6);
    }

    public fun suilend_ab_ab<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, 0x2::sui::SUI>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = borrow_ab<T1>(arg0, arg1, arg10, arg4);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg12);
        let v3 = &mut v2;
        let v4 = liquidate_sui<T0, T1>(arg5, arg6, arg7, arg8, arg4, v3, arg9, arg12);
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(v4);
        let (v6, v7) = sell_ab<T1>(arg2, arg3, 0x2::coin::into_balance<T1>(v2), arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut v5, v6);
        settle_ab<T1>(arg0, arg1, v5, v7, v1, arg11, arg12);
    }

    public fun suilend_ab_ba<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, 0x2::sui::SUI>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = borrow_ab<T1>(arg0, arg1, arg10, arg4);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg12);
        let v3 = &mut v2;
        let v4 = liquidate_sui<T0, T1>(arg5, arg6, arg7, arg8, arg4, v3, arg9, arg12);
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(v4);
        let (v6, v7) = sell_ba<T1>(arg2, arg3, 0x2::coin::into_balance<T1>(v2), arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut v5, v6);
        settle_ab<T1>(arg0, arg1, v5, v7, v1, arg11, arg12);
    }

    public fun suilend_ba_ab<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = borrow_ba<T1>(arg0, arg1, arg10, arg4);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg12);
        let v3 = &mut v2;
        let v4 = liquidate_sui<T0, T1>(arg5, arg6, arg7, arg8, arg4, v3, arg9, arg12);
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(v4);
        let (v6, v7) = sell_ab<T1>(arg2, arg3, 0x2::coin::into_balance<T1>(v2), arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut v5, v6);
        settle_ba<T1>(arg0, arg1, v5, v7, v1, arg11, arg12);
    }

    public fun suilend_ba_ba<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = borrow_ba<T1>(arg0, arg1, arg10, arg4);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg12);
        let v3 = &mut v2;
        let v4 = liquidate_sui<T0, T1>(arg5, arg6, arg7, arg8, arg4, v3, arg9, arg12);
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(v4);
        let (v6, v7) = sell_ba<T1>(arg2, arg3, 0x2::coin::into_balance<T1>(v2), arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut v5, v6);
        settle_ba<T1>(arg0, arg1, v5, v7, v1, arg11, arg12);
    }

    // decompiled from Move bytecode v7
}

