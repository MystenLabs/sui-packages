module 0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_app::LeverageApp, arg1: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp, arg2: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::market::Market<T0>, arg3: &0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_obligation::LeverageMarketOwnerCap, arg4: u64, arg5: &0x70d0acb8fb07d5b50168d196d44c8c7eef422e6b0c7f46d778b5648cbd725060::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_app::ensure_version_matches(arg0);
        0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_obligation::ensure_same_market<T0>(arg3);
        0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let v0 = 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_obligation::market_obligation(arg3), arg7, 0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg2, arg3, arg4), arg5, arg6, arg8);
        0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v0), 0, 0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v0
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_app::LeverageApp, arg1: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp, arg2: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::market::Market<T0>, arg3: &0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_obligation::LeverageMarketOwnerCap, arg4: u8, arg5: &0x70d0acb8fb07d5b50168d196d44c8c7eef422e6b0c7f46d778b5648cbd725060::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_app::ensure_version_matches(arg0);
        0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_obligation::ensure_same_market<T0>(arg3);
        0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let (v0, _) = 0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg2, arg3, arg4);
        let v2 = 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_obligation::market_obligation(arg3), arg7, v0, arg5, arg6, arg8);
        0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v2), 0, 0xc1d93d126e7d796144a058cfbe225cffacf74ff4a5c3f3aaabaa2d55358ab59b::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v2
    }

    // decompiled from Move bytecode v6
}

