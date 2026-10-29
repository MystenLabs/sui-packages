module 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::navi3 {
    public fun begin3<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::NaviArgs, arg3: u8, arg4: u8, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) : (u64, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::navi2::Session) {
        let v0 = pre3<T0>(arg0, arg1, &arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        (v0, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::navi2::new_session_pkg<T0, T1>(0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_debt_asset(&arg2), 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_coll_asset(&arg2), 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_user(&arg2), v0, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_min_profit(&arg2)))
    }

    fun liq<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::NaviArgs, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg0, arg1, arg2, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_debt_asset(arg3), arg4, arg5, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_coll_asset(arg3), arg6, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_user(arg3), arg7, arg8, arg9, arg10)
    }

    public fun navi3_cetus_cd<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::NaviArgs, arg3: u8, arg4: u8, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg14: u128, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = pre3<T1>(arg0, arg1, &arg2, arg3, arg4, arg15, arg5, arg6, arg7);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg12, arg13, true, false, v0, arg14, arg15);
        let v4 = v3;
        let (v5, v6) = liq<T1, T0>(arg15, arg5, arg6, &arg2, arg7, v2, arg8, arg9, arg10, arg11, arg16);
        let v7 = settle_owed<T0, T1>(arg0, v5, v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_min_profit(&arg2), arg16);
        0x2::balance::join<T0>(&mut v7, v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg12, arg13, v7, 0x2::balance::zero<T1>(), v4);
    }

    public fun navi3_cetus_dc<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::NaviArgs, arg3: u8, arg4: u8, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg14: u128, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = pre3<T1>(arg0, arg1, &arg2, arg3, arg4, arg15, arg5, arg6, arg7);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg12, arg13, false, false, v0, arg14, arg15);
        let v4 = v3;
        let (v5, v6) = liq<T1, T0>(arg15, arg5, arg6, &arg2, arg7, v1, arg8, arg9, arg10, arg11, arg16);
        let v7 = settle_owed<T0, T1>(arg0, v5, v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v4), 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_min_profit(&arg2), arg16);
        0x2::balance::join<T0>(&mut v7, v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg12, arg13, 0x2::balance::zero<T1>(), v7, v4);
    }

    public fun navi3_ownfunds<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::NaviArgs, arg3: u8, arg4: u8, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: 0x2::balance::Balance<T0>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = pre3<T0>(arg0, arg1, &arg2, arg3, arg4, arg13, arg5, arg6, arg7);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::pay<T0>(arg0, arg12, arg14);
        let (v1, v2) = liq<T0, T1>(arg13, arg5, arg6, &arg2, arg7, 0x2::balance::split<T0>(&mut arg12, ownfunds_repay(0x2::balance::value<T0>(&arg12), v0)), arg8, arg9, arg10, arg11, arg14);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::pay<T0>(arg0, v2, arg14);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::settle<T1>(arg0, v1, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_min_profit(&arg2), arg14);
    }

    fun ownfunds_repay(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg0 < arg1) {
            arg0
        } else {
            arg1
        };
        assert!(v0 > 0, 141);
        v0
    }

    fun pre3<T0>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: &0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::NaviArgs, arg3: u8, arg4: u8, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) : u64 {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::assert_can_strike(arg0, arg1);
        require_navi_fresh(arg5, arg6, arg3, arg4);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_deadline(arg5, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_deadline_ms(arg2));
        0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::navi_guard<T0>(arg5, arg6, arg7, arg8, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_debt_asset(arg2), 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_user(arg2), 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_min_debt(arg2), 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_max_repay(arg2))
    }

    public fun require_navi_fresh(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: u8, arg3: u8) {
        let (v0, _, _) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg0, arg1, arg2);
        let (v3, _, _) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg0, arg1, arg3);
        require_valid(v0, v3);
    }

    fun require_valid(arg0: bool, arg1: bool) {
        assert!(arg0 && arg1, 140);
    }

    fun settle_owed<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_cover(0x2::balance::value<T0>(&arg1), arg3, arg4);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::pay<T0>(arg0, arg1, arg5);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::pay<T1>(arg0, arg2, arg5);
        0x2::balance::split<T0>(&mut arg1, arg3)
    }

    // decompiled from Move bytecode v7
}

