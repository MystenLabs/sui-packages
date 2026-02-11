module 0x39f85e7ebd5c91bdd37dd5b8c9aba5eba5dcb4874c9532f032b9d8af75fd1c15::router {
    struct SteammRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut SteammRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::authorize(arg0, &mut arg1.id);
    }

    public fun burn<T0, T1, T2, T3>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T2, T3>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: 0x2::coin::Coin<T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 426
    }

    public fun burn_w1<T0, T1, T2, T3, T4>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T3, T4>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg4: 0x2::balance::Balance<T4>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T4>(arg1, &arg4);
        let v0 = 0x2::coin::from_balance<T4>(arg4, arg6);
        let v1 = 0x2::coin::into_balance<T3>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T2, T3, T4>(arg2, arg3, &mut v0, 0x2::balance::value<T4>(&arg4), arg5, arg6));
        if (0x2::coin::value<T4>(&v0) == 0) {
            0x2::coin::destroy_zero<T4>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(v0, 0x2::tx_context::sender(arg6));
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v1));
        v1
    }

    public fun deauthorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut SteammRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SteammRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<SteammRouterWrapper>(v0);
    }

    public fun mint<T0, T1, T2, T3>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T2, T3>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        abort 426
    }

    public fun mint_w1<T0, T1, T2, T3, T4>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T3, T4>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg4: 0x2::balance::Balance<T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T4> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T3>(arg1, &arg4);
        let v0 = 0x2::coin::from_balance<T3>(arg4, arg6);
        let v1 = 0x2::coin::into_balance<T4>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T2, T3, T4>(arg2, arg3, &mut v0, 0x2::balance::value<T3>(&arg4), arg5, arg6));
        0x2::coin::destroy_zero<T3>(v0);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T4>(arg1, &arg0.id, 0x2::balance::value<T4>(&v1));
        v1
    }

    public fun swap_cpmm_a2b<T0, T1, T2, T3: drop>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T1, T2, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T3>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 426
    }

    public fun swap_cpmm_a2b_w1<T0, T1, T2, T3, T4: drop>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T2, T3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T4>, arg3: 0x2::balance::Balance<T2>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg3);
        let v0 = 0x2::coin::from_balance<T2>(arg3, arg4);
        let v1 = 0x2::coin::zero<T3>(arg4);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T2, T3, T4>(arg2, &mut v0, &mut v1, true, 0x2::balance::value<T2>(&arg3), 0, arg4);
        0x2::coin::destroy_zero<T2>(v0);
        let v2 = 0x2::coin::into_balance<T3>(v1);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v2));
        v2
    }

    public fun swap_cpmm_b2a<T0, T1, T2, T3: drop>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T1, T2, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T3>, arg3: 0x2::coin::Coin<T2>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 426
    }

    public fun swap_cpmm_b2a_w1<T0, T1, T2, T3, T4: drop>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T2, T3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T4>, arg3: 0x2::balance::Balance<T3>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T3>(arg1, &arg3);
        let v0 = 0x2::coin::from_balance<T3>(arg3, arg4);
        let v1 = 0x2::coin::zero<T2>(arg4);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T2, T3, T4>(arg2, &mut v1, &mut v0, false, 0x2::balance::value<T3>(&arg3), 0, arg4);
        0x2::coin::destroy_zero<T3>(v0);
        let v2 = 0x2::coin::into_balance<T2>(v1);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T2>(arg1, &arg0.id, 0x2::balance::value<T2>(&v2));
        v2
    }

    public fun swap_omm_a2b<T0, T1, T2, T3, T4, T5, T6: drop>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T6>, arg3: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T2, T4>, arg4: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T3, T5>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg8: 0x2::coin::Coin<T4>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T5> {
        abort 426
    }

    public fun swap_omm_a2b_w1<T0, T1, T2, T3, T4, T5, T6, T7: drop>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T7>, arg3: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T3, T5>, arg4: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T4, T6>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg8: 0x2::balance::Balance<T5>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T6> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T5>(arg1, &arg8);
        let v0 = 0x2::coin::from_balance<T5>(arg8, arg10);
        let v1 = 0x2::coin::zero<T6>(arg10);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::swap<T2, T3, T4, T5, T6, T7>(arg2, arg3, arg4, arg5, arg6, arg7, &mut v0, &mut v1, true, 0x2::balance::value<T5>(&arg8), 0, arg9, arg10);
        0x2::coin::destroy_zero<T5>(v0);
        let v2 = 0x2::coin::into_balance<T6>(v1);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T6>(arg1, &arg0.id, 0x2::balance::value<T6>(&v2));
        v2
    }

    public fun swap_omm_b2a<T0, T1, T2, T3, T4, T5, T6: drop>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T6>, arg3: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T2, T4>, arg4: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T3, T5>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg8: 0x2::coin::Coin<T5>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T4> {
        abort 426
    }

    public fun swap_omm_b2a_w1<T0, T1, T2, T3, T4, T5, T6, T7: drop>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T7>, arg3: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T3, T5>, arg4: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T4, T6>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg8: 0x2::balance::Balance<T6>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T5> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T6>(arg1, &arg8);
        let v0 = 0x2::coin::from_balance<T6>(arg8, arg10);
        let v1 = 0x2::coin::zero<T5>(arg10);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::swap<T2, T3, T4, T5, T6, T7>(arg2, arg3, arg4, arg5, arg6, arg7, &mut v1, &mut v0, false, 0x2::balance::value<T6>(&arg8), 0, arg9, arg10);
        0x2::coin::destroy_zero<T6>(v0);
        let v2 = 0x2::coin::into_balance<T5>(v1);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T5>(arg1, &arg0.id, 0x2::balance::value<T5>(&v2));
        v2
    }

    public fun swap_omm_v2_a2b<T0, T1, T2, T3, T4, T5, T6: drop>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T6>, arg3: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T2, T4>, arg4: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T3, T5>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg8: 0x2::coin::Coin<T4>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T5> {
        abort 426
    }

    public fun swap_omm_v2_a2b_w1<T0, T1, T2, T3, T4, T5, T6, T7: drop>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T7>, arg3: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T3, T5>, arg4: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T4, T6>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg8: 0x2::balance::Balance<T5>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T6> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T5>(arg1, &arg8);
        let v0 = 0x2::coin::from_balance<T5>(arg8, arg10);
        let v1 = 0x2::coin::zero<T6>(arg10);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T2, T3, T4, T5, T6, T7>(arg2, arg3, arg4, arg5, arg6, arg7, &mut v0, &mut v1, true, 0x2::balance::value<T5>(&arg8), 0, arg9, arg10);
        0x2::coin::destroy_zero<T5>(v0);
        let v2 = 0x2::coin::into_balance<T6>(v1);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T6>(arg1, &arg0.id, 0x2::balance::value<T6>(&v2));
        v2
    }

    public fun swap_omm_v2_b2a<T0, T1, T2, T3, T4, T5, T6: drop>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T6>, arg3: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T2, T4>, arg4: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T3, T5>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg8: 0x2::coin::Coin<T5>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T4> {
        abort 426
    }

    public fun swap_omm_v2_b2a_w1<T0, T1, T2, T3, T4, T5, T6, T7: drop>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T7>, arg3: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T3, T5>, arg4: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T4, T6>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg8: 0x2::balance::Balance<T6>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T5> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T6>(arg1, &arg8);
        let v0 = 0x2::coin::from_balance<T6>(arg8, arg10);
        let v1 = 0x2::coin::zero<T5>(arg10);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T2, T3, T4, T5, T6, T7>(arg2, arg3, arg4, arg5, arg6, arg7, &mut v1, &mut v0, false, 0x2::balance::value<T6>(&arg8), 0, arg9, arg10);
        0x2::coin::destroy_zero<T6>(v0);
        let v2 = 0x2::coin::into_balance<T5>(v1);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T5>(arg1, &arg0.id, 0x2::balance::value<T5>(&v2));
        v2
    }

    // decompiled from Move bytecode v6
}

