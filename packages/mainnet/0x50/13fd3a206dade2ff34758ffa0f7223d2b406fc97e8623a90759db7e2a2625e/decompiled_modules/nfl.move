module 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::nfl {
    fun repay_flash_swap_pay_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) {
        transfer_or_destroy_balance<T1>(repay_flash_swap_pay_b_keep<T0, T1>(arg0, arg1, arg2, arg3, arg4), arg5);
    }

    public fun a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg9: address, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_a<T0, T1>(arg0, arg1, arg13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg2);
        let v3 = v1;
        let (v4, v5) = liquidate<T0, T1>(arg2, arg3, arg4, arg5, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg14);
        0x2::balance::join<T1>(&mut v3, v4);
        repay_flash_swap_pay_b<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v3, v2, arg14);
        transfer_or_destroy_balance<T0>(v5, arg14);
    }

    public fun b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg9: address, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_b<T1, T0>(arg0, arg1, arg13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg2);
        let v3 = v0;
        let (v4, v5) = liquidate<T0, T1>(arg2, arg3, arg4, arg5, arg6, v1, arg7, arg8, arg9, arg10, arg11, arg12, arg14);
        0x2::balance::join<T1>(&mut v3, v4);
        repay_flash_swap_pay_a<T1, T0>(arg0, arg1, v3, 0x2::balance::zero<T0>(), v2, arg14);
        transfer_or_destroy_balance<T0>(v5, arg14);
    }

    public fun c<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_a<T0, T1>(arg0, arg1, arg14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v3 = v2;
        let v4 = v1;
        let (v5, v6, v7) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_a<T1, T2>(arg0, arg2, 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::swap_pay_amount<T0, T1>(&v3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v8 = v6;
        0x2::balance::join<T1>(&mut v4, v5);
        let (v9, v10) = liquidate<T0, T2>(arg3, arg4, arg5, arg6, arg7, v0, arg8, arg9, arg10, arg11, arg12, arg13, arg15);
        0x2::balance::join<T2>(&mut v8, v9);
        repay_flash_swap_pay_b<T1, T2>(arg0, arg2, 0x2::balance::zero<T1>(), v8, v7, arg15);
        repay_flash_swap_pay_b<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v4, v3, arg15);
        transfer_or_destroy_balance<T0>(v10, arg15);
    }

    public fun d<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_a<T0, T1>(arg0, arg1, arg14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v3 = v2;
        let v4 = v1;
        let (v5, v6, v7) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_b<T2, T1>(arg0, arg2, 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::swap_pay_amount<T0, T1>(&v3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let v8 = v5;
        0x2::balance::join<T1>(&mut v4, v6);
        let (v9, v10) = liquidate<T0, T2>(arg3, arg4, arg5, arg6, arg7, v0, arg8, arg9, arg10, arg11, arg12, arg13, arg15);
        0x2::balance::join<T2>(&mut v8, v9);
        repay_flash_swap_pay_a<T2, T1>(arg0, arg2, v8, 0x2::balance::zero<T1>(), v7, arg15);
        repay_flash_swap_pay_b<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v4, v3, arg15);
        transfer_or_destroy_balance<T0>(v10, arg15);
    }

    public fun e<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_b<T1, T0>(arg0, arg1, arg14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let v3 = v2;
        let v4 = v0;
        let (v5, v6, v7) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_a<T1, T2>(arg0, arg2, 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::swap_pay_amount<T1, T0>(&v3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v8 = v6;
        0x2::balance::join<T1>(&mut v4, v5);
        let (v9, v10) = liquidate<T0, T2>(arg3, arg4, arg5, arg6, arg7, v1, arg8, arg9, arg10, arg11, arg12, arg13, arg15);
        0x2::balance::join<T2>(&mut v8, v9);
        repay_flash_swap_pay_b<T1, T2>(arg0, arg2, 0x2::balance::zero<T1>(), v8, v7, arg15);
        repay_flash_swap_pay_a<T1, T0>(arg0, arg1, v4, 0x2::balance::zero<T0>(), v3, arg15);
        transfer_or_destroy_balance<T0>(v10, arg15);
    }

    public fun f<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T2>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_b<T1, T0>(arg0, arg1, arg14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let v3 = v2;
        let v4 = v0;
        let (v5, v6, v7) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_b<T2, T1>(arg0, arg2, 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::swap_pay_amount<T1, T0>(&v3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let v8 = v5;
        0x2::balance::join<T1>(&mut v4, v6);
        let (v9, v10) = liquidate<T0, T2>(arg3, arg4, arg5, arg6, arg7, v1, arg8, arg9, arg10, arg11, arg12, arg13, arg15);
        0x2::balance::join<T2>(&mut v8, v9);
        repay_flash_swap_pay_a<T2, T1>(arg0, arg2, v8, 0x2::balance::zero<T1>(), v7, arg15);
        repay_flash_swap_pay_a<T1, T0>(arg0, arg1, v4, 0x2::balance::zero<T0>(), v3, arg15);
        transfer_or_destroy_balance<T0>(v10, arg15);
    }

    public fun g<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_a<T0, T1>(arg0, arg1, arg14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v3 = v1;
        let v4 = v0;
        let (v5, v6, v7) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_a<T0, T1>(arg0, arg2, arg15, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        0x2::balance::join<T0>(&mut v4, v5);
        0x2::balance::join<T1>(&mut v3, v6);
        let (v8, v9) = liquidate<T0, T1>(arg3, arg4, arg5, arg6, arg7, v4, arg8, arg9, arg10, arg11, arg12, arg13, arg16);
        0x2::balance::join<T1>(&mut v3, v8);
        let v10 = v3;
        v3 = repay_flash_swap_pay_b_keep<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v10, v2);
        transfer_or_destroy_balance<T1>(repay_flash_swap_pay_b_keep<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v3, v7), arg16);
        transfer_or_destroy_balance<T0>(v9, arg16);
    }

    public fun h<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_a<T0, T1>(arg0, arg1, arg14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v3 = v1;
        let v4 = v0;
        let (v5, v6, v7) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_b<T1, T0>(arg0, arg2, arg15, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        0x2::balance::join<T0>(&mut v4, v6);
        0x2::balance::join<T1>(&mut v3, v5);
        let (v8, v9) = liquidate<T0, T1>(arg3, arg4, arg5, arg6, arg7, v4, arg8, arg9, arg10, arg11, arg12, arg13, arg16);
        0x2::balance::join<T1>(&mut v3, v8);
        transfer_or_destroy_balance<T1>(repay_flash_swap_pay_a_keep<T1, T0>(arg0, arg2, repay_flash_swap_pay_b_keep<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v3, v2), 0x2::balance::zero<T0>(), v7), arg16);
        transfer_or_destroy_balance<T0>(v9, arg16);
    }

    public fun i<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_b<T1, T0>(arg0, arg1, arg14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let v3 = v1;
        let v4 = v0;
        let (v5, v6, v7) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_a<T0, T1>(arg0, arg2, arg15, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        0x2::balance::join<T0>(&mut v3, v5);
        0x2::balance::join<T1>(&mut v4, v6);
        let (v8, v9) = liquidate<T0, T1>(arg3, arg4, arg5, arg6, arg7, v3, arg8, arg9, arg10, arg11, arg12, arg13, arg16);
        0x2::balance::join<T1>(&mut v4, v8);
        let v10 = v4;
        v4 = repay_flash_swap_pay_a_keep<T1, T0>(arg0, arg1, v10, 0x2::balance::zero<T0>(), v2);
        transfer_or_destroy_balance<T1>(repay_flash_swap_pay_b_keep<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), v4, v7), arg16);
        transfer_or_destroy_balance<T0>(v9, arg16);
    }

    public fun j<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: u8, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg10: address, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_b<T1, T0>(arg0, arg1, arg14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let v3 = v1;
        let v4 = v0;
        let (v5, v6, v7) = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::flash_swap_borrow_b<T1, T0>(arg0, arg2, arg15, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        0x2::balance::join<T0>(&mut v3, v6);
        0x2::balance::join<T1>(&mut v4, v5);
        let (v8, v9) = liquidate<T0, T1>(arg3, arg4, arg5, arg6, arg7, v3, arg8, arg9, arg10, arg11, arg12, arg13, arg16);
        0x2::balance::join<T1>(&mut v4, v8);
        transfer_or_destroy_balance<T1>(repay_flash_swap_pay_a_keep<T1, T0>(arg0, arg2, repay_flash_swap_pay_a_keep<T1, T0>(arg0, arg1, v4, 0x2::balance::zero<T0>(), v2), 0x2::balance::zero<T0>(), v7), arg16);
        transfer_or_destroy_balance<T0>(v9, arg16);
    }

    fun liquidate<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: address, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::nl::l<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    fun repay_flash_swap_pay_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) {
        transfer_or_destroy_balance<T0>(repay_flash_swap_pay_a_keep<T0, T1>(arg0, arg1, arg2, arg3, arg4), arg5);
    }

    fun repay_flash_swap_pay_a_keep<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T0> {
        let v0 = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::swap_pay_amount<T0, T1>(&arg4);
        assert!(0x2::balance::value<T0>(&arg2) >= v0, 1);
        0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::repay_flash_swap_pay_b<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, v0), arg3, arg4);
        arg2
    }

    fun repay_flash_swap_pay_b_keep<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T1> {
        let v0 = 0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::swap_pay_amount<T0, T1>(&arg4);
        assert!(0x2::balance::value<T1>(&arg3) >= v0, 1);
        0x5013fd3a206dade2ff34758ffa0f7223d2b406fc97e8623a90759db7e2a2625e::flash_adapters::repay_flash_swap_pay_b<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T1>(&mut arg3, v0), arg4);
        arg3
    }

    fun transfer_or_destroy_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), @0x25b17d20d25caa33e3185b9d9bf9f7895a6c1e0356f45ca2cb67a518cad59494);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

