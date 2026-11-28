module 0xf92e4e916418d5ae50437cd9fddc17f338429df64062feab1a512c506072f742::router {
    struct CetusDlmmRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut CetusDlmmRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut CetusDlmmRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusDlmmRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<CetusDlmmRouterWrapper>(v0);
    }

    public fun swap_a_to_b_by_a_w1<T0, T1, T2, T3>(arg0: &mut CetusDlmmRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T2, T3>, arg5: 0x2::balance::Balance<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg5);
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T2, T3>(arg4, true, true, 0x2::balance::value<T2>(&arg5), arg2, arg3, arg6, arg7);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::join<T2>(&mut arg5, v0);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T2, T3>(arg4, 0x2::balance::split<T2>(&mut arg5, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T2, T3>(&v3)), 0x2::balance::zero<T3>(), v3, arg3);
        if (0x2::balance::value<T2>(&arg5) != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(arg5, arg7), 0x2::tx_context::sender(arg7));
        } else {
            0x2::balance::destroy_zero<T2>(arg5);
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v4));
        v4
    }

    public fun swap_a_to_b_by_b_w1<T0, T1, T2, T3>(arg0: &mut CetusDlmmRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T2, T3>, arg5: 0x2::balance::Balance<T2>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg5);
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T2, T3>(arg4, true, false, arg6, arg2, arg3, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::join<T2>(&mut arg5, v0);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T2, T3>(arg4, 0x2::balance::split<T2>(&mut arg5, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T2, T3>(&v3)), 0x2::balance::zero<T3>(), v3, arg3);
        if (0x2::balance::value<T2>(&arg5) != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(arg5, arg8), 0x2::tx_context::sender(arg8));
        } else {
            0x2::balance::destroy_zero<T2>(arg5);
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v4));
        v4
    }

    public fun swap_b_to_a_by_a_w1<T0, T1, T2, T3>(arg0: &mut CetusDlmmRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T2, T3>, arg5: 0x2::balance::Balance<T3>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T3>(arg1, &arg5);
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T2, T3>(arg4, false, false, arg6, arg2, arg3, arg7, arg8);
        let v3 = v2;
        let v4 = v0;
        0x2::balance::join<T3>(&mut arg5, v1);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T2, T3>(arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut arg5, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T2, T3>(&v3)), v3, arg3);
        if (0x2::balance::value<T3>(&arg5) != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(arg5, arg8), 0x2::tx_context::sender(arg8));
        } else {
            0x2::balance::destroy_zero<T3>(arg5);
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T2>(arg1, &arg0.id, 0x2::balance::value<T2>(&v4));
        v4
    }

    public fun swap_b_to_a_by_b_w1<T0, T1, T2, T3>(arg0: &mut CetusDlmmRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T2, T3>, arg5: 0x2::balance::Balance<T3>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T3>(arg1, &arg5);
        let (v0, v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T2, T3>(arg4, false, true, 0x2::balance::value<T3>(&arg5), arg2, arg3, arg6, arg7);
        let v3 = v2;
        let v4 = v0;
        0x2::balance::join<T3>(&mut arg5, v1);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T2, T3>(arg4, 0x2::balance::zero<T2>(), 0x2::balance::split<T3>(&mut arg5, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T2, T3>(&v3)), v3, arg3);
        if (0x2::balance::value<T3>(&arg5) != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(arg5, arg7), 0x2::tx_context::sender(arg7));
        } else {
            0x2::balance::destroy_zero<T3>(arg5);
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T2>(arg1, &arg0.id, 0x2::balance::value<T2>(&v4));
        v4
    }

    // decompiled from Move bytecode v7
}

