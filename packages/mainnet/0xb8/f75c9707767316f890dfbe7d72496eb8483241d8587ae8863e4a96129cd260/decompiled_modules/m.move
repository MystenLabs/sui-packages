module 0xb8f75c9707767316f890dfbe7d72496eb8483241d8587ae8863e4a96129cd260::m {
    fun burn<T0, T1>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        keep<T1>(arg2, arg4);
        0x2::coin::into_balance<T0>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, T1>(arg0, arg1, &mut arg2, 0x2::coin::value<T1>(&arg2), arg3, arg4))
    }

    public fun ca<T0, T1, T2, T3, T4: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, T1>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T1, T3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T4>, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        let v0 = mint<T0, T1>(arg0, arg2, arg5, arg4, arg6);
        let v1 = 0x2::coin::zero<T3>(arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T1, T3, T4>(arg3, &mut v0, &mut v1, true, 0x2::coin::value<T1>(&v0), 0, arg6);
        keep<T1>(v0, arg6);
        burn<T2, T3>(arg1, arg2, v1, arg4, arg6)
    }

    public fun cb<T0, T1, T2, T3, T4: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, T1>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T1, T3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T4>, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T2>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = mint<T2, T3>(arg1, arg2, arg5, arg4, arg6);
        let v1 = 0x2::coin::zero<T1>(arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T1, T3, T4>(arg3, &mut v1, &mut v0, false, 0x2::coin::value<T3>(&v0), 0, arg6);
        keep<T3>(v0, arg6);
        burn<T0, T1>(arg0, arg2, v1, arg4, arg6)
    }

    fun keep<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::coin::send_funds<T0>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    fun mint<T0, T1>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::from_balance<T0>(arg2, arg4);
        0x2::coin::destroy_zero<T0>(v0);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, T1>(arg0, arg1, &mut v0, 0x2::coin::value<T0>(&v0), arg3, arg4)
    }

    public fun oa<T0, T1, T2, T3, T4: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, T1>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T1, T3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T4>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg5: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: 0x2::balance::Balance<T0>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        let v0 = mint<T0, T1>(arg0, arg2, arg10, arg9, arg11);
        let v1 = 0x2::coin::zero<T3>(arg11);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, T2, T1, T3, T4>(arg3, arg0, arg1, arg2, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg5, arg7, arg9), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg6, arg8, arg9), &mut v0, &mut v1, true, 0x2::coin::value<T1>(&v0), 0, arg9, arg11);
        keep<T1>(v0, arg11);
        burn<T2, T3>(arg1, arg2, v1, arg9, arg11)
    }

    public fun ob<T0, T1, T2, T3, T4: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, T1>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T2, T3>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T1, T3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T4>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg5: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: 0x2::balance::Balance<T2>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = mint<T2, T3>(arg1, arg2, arg10, arg9, arg11);
        let v1 = 0x2::coin::zero<T1>(arg11);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0, T2, T1, T3, T4>(arg3, arg0, arg1, arg2, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg5, arg7, arg9), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg4, arg6, arg8, arg9), &mut v1, &mut v0, false, 0x2::coin::value<T3>(&v0), 0, arg9, arg11);
        keep<T3>(v0, arg11);
        burn<T0, T1>(arg0, arg2, v1, arg9, arg11)
    }

    // decompiled from Move bytecode v7
}

