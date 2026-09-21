module 0xcbb0d8b9f7a54348c3166dadd926db68ad3e1e68aabee4d594afafb9c1122517::router {
    struct PerpsplexityRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut PerpsplexityRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::authorize(arg0, &mut arg1.id);
    }

    public fun buy_w1<T0, T1, T2, T3>(arg0: &mut PerpsplexityRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::Pool<T3, T2>, arg4: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg2);
        let (v0, v1) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::withdraw<T3, T2>(arg3, arg4, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::buy<T3, T2>(arg3, arg4, 0x2::coin::from_balance<T2>(arg2, arg6), 0, 18446744073709551615, arg5, arg6), arg5, arg6);
        let v2 = v1;
        let v3 = 0x2::coin::into_balance<T3>(v0);
        if (0x2::coin::value<T2>(&v2) == 0) {
            0x2::coin::destroy_zero<T2>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v2, 0x2::tx_context::sender(arg6));
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v3));
        v3
    }

    public fun deauthorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut PerpsplexityRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PerpsplexityRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<PerpsplexityRouterWrapper>(v0);
    }

    public fun sell_w1<T0, T1, T2, T3>(arg0: &mut PerpsplexityRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::Pool<T2, T3>, arg4: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg2);
        let v0 = 0x2::coin::into_balance<T3>(0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::sell<T2, T3>(arg3, arg4, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::deposit<T2, T3>(arg3, arg4, 0x2::coin::from_balance<T2>(arg2, arg6), arg5, arg6), 0, 18446744073709551615, arg5, arg6));
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v0));
        v0
    }

    // decompiled from Move bytecode v7
}

