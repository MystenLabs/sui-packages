module 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::navi {
    fun assert_floor_matches_mode(arg0: u64, arg1: u64, arg2: bool) {
        if (arg2) {
            assert!(arg0 == 0, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::bad_argument());
        } else {
            assert!(arg1 == 0, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::bad_argument());
        };
    }

    fun bite<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: address, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun liquidate_flash_swap_coll_debt<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg7: address, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg13: u8, arg14: u64, arg15: u64, arg16: u64, arg17: bool, arg18: &mut 0x2::tx_context::TxContext) {
        assert_floor_matches_mode(arg15, arg16, arg17);
        let v0 = max_bite(arg0, arg1, arg2, arg3, arg5, arg7, arg13, arg14);
        let (v1, v2) = 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::swap::borrow_exact_b<T1, T0>(arg11, arg12, v0, arg0);
        let v3 = v2;
        let (v4, v5) = bite<T0, T1>(arg0, arg1, arg2, arg3, arg4, v1, arg5, arg6, arg7, arg8, arg9, arg10, arg18);
        let v6 = v4;
        let v7 = 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::swap::pay_amount<T1, T0>(&v3);
        assert!(0x2::balance::value<T1>(&v6) >= v7, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::not_enough_seized());
        0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::swap::repay_with_a<T1, T0>(arg11, arg12, 0x2::balance::split<T1>(&mut v6, v7), v3);
        if (arg17) {
            let v8 = v5;
            0x2::balance::join<T0>(&mut v8, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::swap::sell_all_a<T1, T0>(arg11, arg12, v6, arg0));
            assert!(0x2::balance::value<T0>(&v8) >= arg16, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::net_below_min());
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v8, arg18), 0x2::tx_context::sender(arg18));
        } else {
            settle<T0, T1>(v6, v5, arg15, arg18);
        };
    }

    public fun liquidate_flash_swap_debt_coll<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg7: address, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg13: u8, arg14: u64, arg15: u64, arg16: u64, arg17: bool, arg18: &mut 0x2::tx_context::TxContext) {
        assert_floor_matches_mode(arg15, arg16, arg17);
        let v0 = max_bite(arg0, arg1, arg2, arg3, arg5, arg7, arg13, arg14);
        let (v1, v2) = 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::swap::borrow_exact_a<T0, T1>(arg11, arg12, v0, arg0);
        let v3 = v2;
        let (v4, v5) = bite<T0, T1>(arg0, arg1, arg2, arg3, arg4, v1, arg5, arg6, arg7, arg8, arg9, arg10, arg18);
        let v6 = v4;
        let v7 = 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::swap::pay_amount<T0, T1>(&v3);
        assert!(0x2::balance::value<T1>(&v6) >= v7, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::not_enough_seized());
        0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::swap::repay_with_b<T0, T1>(arg11, arg12, 0x2::balance::split<T1>(&mut v6, v7), v3);
        if (arg17) {
            let v8 = v5;
            0x2::balance::join<T0>(&mut v8, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::swap::sell_all_b<T0, T1>(arg11, arg12, v6, arg0));
            assert!(0x2::balance::value<T0>(&v8) >= arg16, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::net_below_min());
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v8, arg18), 0x2::tx_context::sender(arg18));
        } else {
            settle<T0, T1>(v6, v5, arg15, arg18);
        };
    }

    public fun max_bite(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: u8, arg5: address, arg6: u8, arg7: u64) : u64 {
        let (v0, v1, v2) = 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::oracle::price(arg0, arg1, arg3);
        let (v3, v4, v5) = 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::oracle::price(arg0, arg1, arg4);
        assert!(v0 && v3, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::price_unavailable());
        let (_, v7) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg2, arg3, arg5);
        let (_, v9) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg2, arg3);
        let (v10, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg2, arg4, arg5);
        let (v12, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg2, arg4);
        let (v14, _, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg2, arg4);
        let v17 = 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::math::shave_bps(0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::math::to_base_units(0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::math::max_repay_normalized(0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::math::current_balance(v10, v12), v4, v5, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::math::current_balance(v7, v9), v1, v2, v14), arg6), 5);
        let v18 = if (v17 > (arg7 as u256)) {
            (arg7 as u256)
        } else {
            v17
        };
        assert!(v18 > 0, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::repay_zero());
        (v18 as u64)
    }

    fun settle<T0, T1>(arg0: 0x2::balance::Balance<T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T1>(&arg0) >= arg2, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::net_below_min());
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(arg0, arg3), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg3), v0);
    }

    // decompiled from Move bytecode v7
}

