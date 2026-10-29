module 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike2 {
    struct Strike2Args has copy, drop {
        repay_idx: u64,
        withdraw_idx: u64,
        min_debt: u64,
        max_repay: u64,
        min_profit: u64,
        min_out: u64,
        deadline_ms: u64,
    }

    public fun args(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : Strike2Args {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_positive_min_out(arg5);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_positive_repay(arg3);
        Strike2Args{
            repay_idx    : arg0,
            withdraw_idx : arg1,
            min_debt     : arg2,
            max_repay    : arg3,
            min_profit   : arg4,
            min_out      : arg5,
            deadline_ms  : arg6,
        }
    }

    public fun suilend_bluefin_flash_cetus_swap<T0, T1, T2, T3>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg3: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: Strike2Args, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg9: u128, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg12: u128, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::assert_can_strike(arg0, arg1);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::consume_pair<T2, T3>(arg0, arg2, arg3);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_deadline(arg13, arg6.deadline_ms);
        let (v0, v1, v2) = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::dex::bluefin_flash_b<T1, T2>(arg7, arg8, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::suilend_guard<T0>(arg4, arg5, arg6.repay_idx, arg6.min_debt, arg6.max_repay), arg9, arg13);
        let v3 = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::to_coin<T2>(v0, arg14);
        let (v4, v5) = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::dex::cetus_swap_a_to_b<T3, T1>(arg10, arg11, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::suilend_liquidate<T0, T2, T3>(arg4, arg5, arg6.repay_idx, arg6.withdraw_idx, arg13, &mut v3, arg14), arg6.min_out, arg12, arg13);
        let v6 = v4;
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::pay<T3>(arg0, v5, arg14);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::pay<T2>(arg0, 0x2::coin::into_balance<T2>(v3), arg14);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_cover(0x2::balance::value<T1>(&v6), v1, arg6.min_profit);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::pay<T1>(arg0, v6, arg14);
        0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::dex::bluefin_repay_a<T1, T2>(arg7, arg8, 0x2::balance::split<T1>(&mut v6, v1), v2);
    }

    public fun suilend_cetus_flash_bluefin_swap<T0, T1, T2, T3>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg3: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: Strike2Args, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg9: u128, arg10: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg11: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg12: u128, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::assert_can_strike(arg0, arg1);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::consume_pair<T2, T3>(arg0, arg2, arg3);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_deadline(arg13, arg6.deadline_ms);
        let (v0, v1, v2) = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::dex::cetus_flash_b<T1, T2>(arg7, arg8, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::suilend_guard<T0>(arg4, arg5, arg6.repay_idx, arg6.min_debt, arg6.max_repay), arg9, arg13);
        let v3 = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::to_coin<T2>(v0, arg14);
        let (v4, v5) = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::dex::bluefin_swap_a_to_b<T3, T1>(arg10, arg11, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::suilend_liquidate<T0, T2, T3>(arg4, arg5, arg6.repay_idx, arg6.withdraw_idx, arg13, &mut v3, arg14), arg6.min_out, arg12, arg13);
        let v6 = v4;
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::pay<T3>(arg0, v5, arg14);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::pay<T2>(arg0, 0x2::coin::into_balance<T2>(v3), arg14);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_cover(0x2::balance::value<T1>(&v6), v1, arg6.min_profit);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::pay<T1>(arg0, v6, arg14);
        0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::dex::cetus_repay_a<T1, T2>(arg7, arg8, 0x2::balance::split<T1>(&mut v6, v1), v2);
    }

    public fun suilend_sui_bluefin_flash_cetus_swap<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg3: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: 0x2::object::ID, arg7: Strike2Args, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T1>, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::assert_can_strike(arg0, arg1);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::consume_pair<T1, 0x2::sui::SUI>(arg0, arg2, arg3);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_deadline(arg11, arg7.deadline_ms);
        let (v0, v1, v2) = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::dex::bluefin_flash_b<0x2::sui::SUI, T1>(arg8, arg9, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::suilend_guard<T0>(arg4, arg6, arg7.repay_idx, arg7.min_debt, arg7.max_repay), arg10, arg11);
        let v3 = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::to_coin<T1>(v0, arg12);
        let v4 = 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::suilend_liquidate_sui<T0, T1>(arg4, arg5, arg6, arg7.repay_idx, arg7.withdraw_idx, arg11, &mut v3, arg12);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::pay<T1>(arg0, 0x2::coin::into_balance<T1>(v3), arg12);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_cover(0x2::balance::value<0x2::sui::SUI>(&v4), v1, arg7.min_profit);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_min_out(0x2::balance::value<0x2::sui::SUI>(&v4), arg7.min_out);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::pay<0x2::sui::SUI>(arg0, v4, arg12);
        0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::dex::bluefin_repay_a<0x2::sui::SUI, T1>(arg8, arg9, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v1), v2);
    }

    // decompiled from Move bytecode v7
}

