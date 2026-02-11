module 0x2f354e93e638ca66cecba769cd0827b89c84cfe08a0c76a9dd3910b00a55a8bc::router {
    struct TurbosRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut TurbosRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut TurbosRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TurbosRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<TurbosRouterWrapper>(v0);
    }

    public fun swap_a_b<T0, T1, T2, T3>(arg0: &mut TurbosRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        abort 426
    }

    public fun swap_a_b_w1<T0, T1, T2, T3, T4>(arg0: &mut TurbosRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg3: 0x2::balance::Balance<T2>, arg4: &0x2::clock::Clock, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T2>(arg1, &arg3);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v1, 0x2::coin::from_balance<T2>(arg3, arg6));
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T2, T3, T4>(arg2, v1, 0x2::balance::value<T2>(&arg3), 0, 764408330562997061, true, v0, 18446744073709551615, arg4, arg5, arg6);
        let v4 = v3;
        let v5 = 0x2::coin::into_balance<T3>(v2);
        if (0x2::coin::value<T2>(&v4) == 0) {
            0x2::coin::destroy_zero<T2>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, v0);
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T3>(arg1, &arg0.id, 0x2::balance::value<T3>(&v5));
        v5
    }

    public fun swap_b_a<T0, T1, T2, T3>(arg0: &mut TurbosRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 426
    }

    public fun swap_b_a_w1<T0, T1, T2, T3, T4>(arg0: &mut TurbosRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCapExtended<T0, 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::WrapperDataV1<T1>>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T2, T3, T4>, arg3: 0x2::balance::Balance<T3>, arg4: &0x2::clock::Clock, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_balance_in_w1<T0, T1, T3>(arg1, &arg3);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T3>>();
        0x1::vector::push_back<0x2::coin::Coin<T3>>(&mut v1, 0x2::coin::from_balance<T3>(arg3, arg6));
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T2, T3, T4>(arg2, v1, 0x2::balance::value<T3>(&arg3), 0, 18456887916243848389, true, v0, 18446744073709551615, arg4, arg5, arg6);
        let v4 = v3;
        let v5 = 0x2::coin::into_balance<T2>(v2);
        if (0x2::coin::value<T3>(&v4) == 0) {
            0x2::coin::destroy_zero<T3>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v4, v0);
        };
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata_w1<T0, T1, T2>(arg1, &arg0.id, 0x2::balance::value<T2>(&v5));
        v5
    }

    // decompiled from Move bytecode v6
}

