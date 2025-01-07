module 0xaaf4f6d86cd7ac3eb8136cf3402c6ff74cba41a86c726fda3f610819c52df139::liquidator {
    public fun liquidate_obligation<T0, T1, T2>(arg0: &0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::version::Version, arg1: &mut 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::Obligation, arg2: &mut 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::Market, arg3: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x6987906fbf965e4ac549e774e22714cbab402fd934330702727e2efb1b2aa98e::x_oracle::XOracle, arg5: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg6: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg7: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg8: &mut 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg9: &0x467a24e385368f74bb525e24783ff33d692c0ed5c09d544ef85d583f823ba387::pyth_registry::PythRegistry, arg10: vector<u8>, arg11: vector<u8>, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg14: 0x2::coin::Coin<0x2::sui::SUI>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xaaf4f6d86cd7ac3eb8136cf3402c6ff74cba41a86c726fda3f610819c52df139::oracle::update_usdc_sui_prices<T2>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg14, arg15, arg16);
        0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::accrue_interest::accrue_interest_for_market_and_obligation(arg2, arg1, arg15);
        let (v0, _) = 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg15);
        let (v2, v3) = 0xbee4e5f893adbb2b1bb741f150df84a90891f10568f95780614e921eb2cc6cd4::cetus_flash_loan::borrow_a_repay_b_later<T0, T1>(arg12, arg13, v0, arg15, arg16);
        let v4 = v3;
        let (v5, v6) = 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v2, arg3, arg4, arg15, arg16);
        let v7 = v6;
        0xbee4e5f893adbb2b1bb741f150df84a90891f10568f95780614e921eb2cc6cd4::cetus_flash_loan::repay_b<T0, T1>(arg12, arg13, 0x2::coin::split<T1>(&mut v7, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg16), v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, 0x2::tx_context::sender(arg16));
        0xaaf4f6d86cd7ac3eb8136cf3402c6ff74cba41a86c726fda3f610819c52df139::util::destory_or_send_to_sender<T0>(v5, arg16);
    }

    // decompiled from Move bytecode v6
}

