module 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike {
    struct NaviArgs has copy, drop {
        debt_asset: u8,
        coll_asset: u8,
        user: address,
        min_debt: u64,
        max_repay: u64,
        min_profit: u64,
        deadline_ms: u64,
    }

    fun finish<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_cover(0x2::balance::value<T0>(&arg1), arg3, arg4);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::pay<T0>(arg0, arg1, arg5);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::pay<T1>(arg0, arg2, arg5);
        0x2::balance::split<T0>(&mut arg1, arg3)
    }

    public fun navi_args(arg0: u8, arg1: u8, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : NaviArgs {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_positive_repay(arg4);
        NaviArgs{
            debt_asset  : arg0,
            coll_asset  : arg1,
            user        : arg2,
            min_debt    : arg3,
            max_repay   : arg4,
            min_profit  : arg5,
            deadline_ms : arg6,
        }
    }

    public fun navi_bluefin_cd<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg3: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg4: NaviArgs, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg12: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg13: u128, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::assert_can_strike(arg0, arg1);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::consume_pair<T1, T0>(arg0, arg2, arg3);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_deadline(arg14, arg4.deadline_ms);
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg14, arg11, arg12, true, false, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::navi_guard<T1>(arg14, arg5, arg6, arg7, arg4.debt_asset, arg4.user, arg4.min_debt, arg4.max_repay), arg13);
        let v3 = v2;
        let (v4, v5) = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::navi_liquidate<T1, T0>(arg14, arg5, arg6, arg4.debt_asset, arg7, v1, arg4.coll_asset, arg8, arg4.user, arg9, arg10, arg15);
        let v6 = finish<T0, T1>(arg0, v4, v5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3), arg4.min_profit, arg15);
        0x2::balance::join<T0>(&mut v6, v0);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg11, arg12, v6, 0x2::balance::zero<T1>(), v3);
    }

    public fun navi_bluefin_dc<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg3: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg4: NaviArgs, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg12: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg13: u128, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::assert_can_strike(arg0, arg1);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::consume_pair<T1, T0>(arg0, arg2, arg3);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_deadline(arg14, arg4.deadline_ms);
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg14, arg11, arg12, false, false, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::navi_guard<T1>(arg14, arg5, arg6, arg7, arg4.debt_asset, arg4.user, arg4.min_debt, arg4.max_repay), arg13);
        let v3 = v2;
        let (v4, v5) = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::navi_liquidate<T1, T0>(arg14, arg5, arg6, arg4.debt_asset, arg7, v0, arg4.coll_asset, arg8, arg4.user, arg9, arg10, arg15);
        let v6 = finish<T0, T1>(arg0, v4, v5, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v3), arg4.min_profit, arg15);
        0x2::balance::join<T0>(&mut v6, v1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg11, arg12, 0x2::balance::zero<T1>(), v6, v3);
    }

    public fun navi_cetus_cd<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg3: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg4: NaviArgs, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg13: u128, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::assert_can_strike(arg0, arg1);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::consume_pair<T1, T0>(arg0, arg2, arg3);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_deadline(arg14, arg4.deadline_ms);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg11, arg12, true, false, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::navi_guard<T1>(arg14, arg5, arg6, arg7, arg4.debt_asset, arg4.user, arg4.min_debt, arg4.max_repay), arg13, arg14);
        let v3 = v2;
        let (v4, v5) = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::navi_liquidate<T1, T0>(arg14, arg5, arg6, arg4.debt_asset, arg7, v1, arg4.coll_asset, arg8, arg4.user, arg9, arg10, arg15);
        let v6 = finish<T0, T1>(arg0, v4, v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg4.min_profit, arg15);
        0x2::balance::join<T0>(&mut v6, v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg11, arg12, v6, 0x2::balance::zero<T1>(), v3);
    }

    public fun navi_cetus_dc<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg3: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg4: NaviArgs, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg13: u128, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::assert_can_strike(arg0, arg1);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::consume_pair<T1, T0>(arg0, arg2, arg3);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_deadline(arg14, arg4.deadline_ms);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg11, arg12, false, false, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::navi_guard<T1>(arg14, arg5, arg6, arg7, arg4.debt_asset, arg4.user, arg4.min_debt, arg4.max_repay), arg13, arg14);
        let v3 = v2;
        let (v4, v5) = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::navi_liquidate<T1, T0>(arg14, arg5, arg6, arg4.debt_asset, arg7, v0, arg4.coll_asset, arg8, arg4.user, arg9, arg10, arg15);
        let v6 = finish<T0, T1>(arg0, v4, v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v3), arg4.min_profit, arg15);
        0x2::balance::join<T0>(&mut v6, v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg11, arg12, 0x2::balance::zero<T1>(), v6, v3);
    }

    public fun navi_coll_asset(arg0: &NaviArgs) : u8 {
        arg0.coll_asset
    }

    public fun navi_deadline_ms(arg0: &NaviArgs) : u64 {
        arg0.deadline_ms
    }

    public fun navi_debt_asset(arg0: &NaviArgs) : u8 {
        arg0.debt_asset
    }

    public fun navi_max_repay(arg0: &NaviArgs) : u64 {
        arg0.max_repay
    }

    public fun navi_min_debt(arg0: &NaviArgs) : u64 {
        arg0.min_debt
    }

    public fun navi_min_profit(arg0: &NaviArgs) : u64 {
        arg0.min_profit
    }

    public fun navi_user(arg0: &NaviArgs) : address {
        arg0.user
    }

    public fun suilend_bluefin_cd<T0, T1, T2>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg3: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg13: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg14: u128, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::assert_can_strike(arg0, arg1);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::consume_pair<T2, T1>(arg0, arg2, arg3);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_positive_repay(arg9);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_deadline(arg15, arg11);
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T2>(arg15, arg12, arg13, true, false, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::suilend_guard<T0>(arg4, arg5, arg6, arg8, arg9), arg14);
        let v3 = v2;
        let v4 = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::to_coin<T2>(v1, arg16);
        let v5 = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::suilend_liquidate<T0, T2, T1>(arg4, arg5, arg6, arg7, arg15, &mut v4, arg16);
        let v6 = finish<T1, T2>(arg0, v5, 0x2::coin::into_balance<T2>(v4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T2>(&v3), arg10, arg16);
        0x2::balance::join<T1>(&mut v6, v0);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T2>(arg12, arg13, v6, 0x2::balance::zero<T2>(), v3);
    }

    public fun suilend_bluefin_dc<T0, T1, T2>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg3: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg13: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg14: u128, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::assert_can_strike(arg0, arg1);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::consume_pair<T2, T1>(arg0, arg2, arg3);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_positive_repay(arg9);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_deadline(arg15, arg11);
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T1>(arg15, arg12, arg13, false, false, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::suilend_guard<T0>(arg4, arg5, arg6, arg8, arg9), arg14);
        let v3 = v2;
        let v4 = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::to_coin<T2>(v0, arg16);
        let v5 = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::suilend_liquidate<T0, T2, T1>(arg4, arg5, arg6, arg7, arg15, &mut v4, arg16);
        let v6 = finish<T1, T2>(arg0, v5, 0x2::coin::into_balance<T2>(v4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T1>(&v3), arg10, arg16);
        0x2::balance::join<T1>(&mut v6, v1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T1>(arg12, arg13, 0x2::balance::zero<T2>(), v6, v3);
    }

    public fun suilend_cetus_cd<T0, T1, T2>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg3: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg14: u128, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::assert_can_strike(arg0, arg1);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::consume_pair<T2, T1>(arg0, arg2, arg3);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_positive_repay(arg9);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_deadline(arg15, arg11);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg12, arg13, true, false, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::suilend_guard<T0>(arg4, arg5, arg6, arg8, arg9), arg14, arg15);
        let v3 = v2;
        let v4 = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::to_coin<T2>(v1, arg16);
        let v5 = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::suilend_liquidate<T0, T2, T1>(arg4, arg5, arg6, arg7, arg15, &mut v4, arg16);
        let v6 = finish<T1, T2>(arg0, v5, 0x2::coin::into_balance<T2>(v4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v3), arg10, arg16);
        0x2::balance::join<T1>(&mut v6, v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg12, arg13, v6, 0x2::balance::zero<T2>(), v3);
    }

    public fun suilend_cetus_dc<T0, T1, T2>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg3: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg14: u128, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::assert_can_strike(arg0, arg1);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::consume_pair<T2, T1>(arg0, arg2, arg3);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_positive_repay(arg9);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_deadline(arg15, arg11);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T1>(arg12, arg13, false, false, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::suilend_guard<T0>(arg4, arg5, arg6, arg8, arg9), arg14, arg15);
        let v3 = v2;
        let v4 = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::to_coin<T2>(v0, arg16);
        let v5 = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::suilend_liquidate<T0, T2, T1>(arg4, arg5, arg6, arg7, arg15, &mut v4, arg16);
        let v6 = finish<T1, T2>(arg0, v5, 0x2::coin::into_balance<T2>(v4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T1>(&v3), arg10, arg16);
        0x2::balance::join<T1>(&mut v6, v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T1>(arg12, arg13, 0x2::balance::zero<T2>(), v6, v3);
    }

    // decompiled from Move bytecode v7
}

