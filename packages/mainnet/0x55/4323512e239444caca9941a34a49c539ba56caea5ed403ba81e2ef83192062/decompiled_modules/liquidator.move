module 0x554323512e239444caca9941a34a49c539ba56caea5ed403ba81e2ef83192062::liquidator {
    public fun liquidate_obligation<T0, T1>(arg0: &0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::version::Version, arg1: &mut 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::obligation::Obligation, arg2: &mut 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::market::Market, arg3: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0x6987906fbf965e4ac549e774e22714cbab402fd934330702727e2efb1b2aa98e::x_oracle::XOracle, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::accrue_interest::accrue_interest_for_market_and_obligation(arg2, arg1, arg7);
        let (v0, _) = 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::liquidation_evaluator::max_liquidation_amounts<T0, T1>(arg1, arg2, arg3, arg4, arg7);
        let (v2, v3) = 0xbee4e5f893adbb2b1bb741f150df84a90891f10568f95780614e921eb2cc6cd4::cetus_flash_loan::borrow_a_repay_b_later<T0, T1>(arg5, arg6, v0, arg7, arg8);
        let v4 = v3;
        let (v5, v6) = 0x99aaa66c01af06d78c1634300e6ca4fabf46bfe830291184bca7d11ddc96859c::liquidate::liquidate<T0, T1>(arg0, arg1, arg2, v2, arg3, arg4, arg7, arg8);
        let v7 = v6;
        0xbee4e5f893adbb2b1bb741f150df84a90891f10568f95780614e921eb2cc6cd4::cetus_flash_loan::repay_b<T0, T1>(arg5, arg6, 0x2::coin::split<T1>(&mut v7, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg8), v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, 0x2::tx_context::sender(arg8));
        0x554323512e239444caca9941a34a49c539ba56caea5ed403ba81e2ef83192062::coin_util::destory_or_send_to_sender<T0>(v5, arg8);
    }

    // decompiled from Move bytecode v6
}

