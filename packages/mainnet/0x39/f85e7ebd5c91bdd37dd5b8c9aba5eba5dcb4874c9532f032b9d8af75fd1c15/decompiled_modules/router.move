module 0x39f85e7ebd5c91bdd37dd5b8c9aba5eba5dcb4874c9532f032b9d8af75fd1c15::router {
    struct SteammRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut SteammRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::authorize(arg0, &mut arg1.id);
    }

    public fun burn<T0, T1, T2, T3>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T2, T3>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: 0x2::coin::Coin<T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, T3>(arg1, &arg4);
        let v0 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T1, T2, T3>(arg2, arg3, &mut arg4, 0x2::coin::value<T3>(&arg4), arg5, arg6);
        if (0x2::coin::value<T3>(&arg4) == 0) {
            0x2::coin::destroy_zero<T3>(arg4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(arg4, 0x2::tx_context::sender(arg6));
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, T2>(arg1, &arg0.id, 0x2::coin::value<T2>(&v0));
        v0
    }

    public fun deauthorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut SteammRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SteammRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<SteammRouterWrapper>(v0);
    }

    public fun mint<T0, T1, T2, T3>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T2, T3>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, T2>(arg1, &arg4);
        let v0 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T1, T2, T3>(arg2, arg3, &mut arg4, 0x2::coin::value<T2>(&arg4), arg5, arg6);
        0x2::coin::destroy_zero<T2>(arg4);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, T3>(arg1, &arg0.id, 0x2::coin::value<T3>(&v0));
        v0
    }

    public fun swap_cpmm_a2b<T0, T1, T2, T3: drop>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T1, T2, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T3>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, T1>(arg1, &arg3);
        let v0 = 0x2::coin::zero<T2>(arg4);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T1, T2, T3>(arg2, &mut arg3, &mut v0, true, 0x2::coin::value<T1>(&arg3), 0, arg4);
        0x2::coin::destroy_zero<T1>(arg3);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, T2>(arg1, &arg0.id, 0x2::coin::value<T2>(&v0));
        v0
    }

    public fun swap_cpmm_b2a<T0, T1, T2, T3: drop>(arg0: &mut SteammRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T1, T2, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T3>, arg3: 0x2::coin::Coin<T2>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, T2>(arg1, &arg3);
        let v0 = 0x2::coin::zero<T1>(arg4);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T1, T2, T3>(arg2, &mut v0, &mut arg3, true, 0x2::coin::value<T2>(&arg3), 0, arg4);
        0x2::coin::destroy_zero<T2>(arg3);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, T1>(arg1, &arg0.id, 0x2::coin::value<T1>(&v0));
        v0
    }

    // decompiled from Move bytecode v6
}

