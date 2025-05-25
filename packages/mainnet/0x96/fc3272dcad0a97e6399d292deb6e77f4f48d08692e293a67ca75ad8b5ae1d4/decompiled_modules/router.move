module 0x96fc3272dcad0a97e6399d292deb6e77f4f48d08692e293a67ca75ad8b5ae1d4::router {
    struct MomentumRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut MomentumRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut MomentumRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MomentumRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<MomentumRouterWrapper>(v0);
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut MomentumRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, T1>(arg1, &arg2);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0x2::tx_context::sender(arg6);
        let (v2, v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T2>(arg3, true, true, v0, 4295048016, arg5, arg4, arg6);
        let v5 = v4;
        let v6 = v2;
        let (v7, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v5);
        let v9 = if (v7 == v0) {
            0x2::coin::into_balance<T1>(arg2)
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v1);
            0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut arg2), v7)
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T2>(arg3, v5, v9, 0x2::balance::zero<T2>(), arg4, arg6);
        if (0x2::balance::value<T1>(&v6) == 0) {
            0x2::balance::destroy_zero<T1>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg6), v1);
        };
        let v10 = 0x2::coin::from_balance<T2>(v3, arg6);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, T2>(arg1, &arg0.id, 0x2::coin::value<T2>(&v10));
        v10
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut MomentumRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T1>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, T1>(arg1, &arg2);
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T2, T1>(arg3, false, true, 0x2::coin::value<T1>(&arg2), 79226673515401279992447579055, arg5, arg4, arg6);
        let v3 = v2;
        let v4 = v1;
        let (_, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v7 = if (v6 == 0x2::coin::value<T1>(&arg2)) {
            0x2::coin::into_balance<T1>(arg2)
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, 0x2::tx_context::sender(arg6));
            0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut arg2), v6)
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T2, T1>(arg3, v3, 0x2::balance::zero<T2>(), v7, arg4, arg6);
        if (0x2::balance::value<T1>(&v4) == 0) {
            0x2::balance::destroy_zero<T1>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg6), 0x2::tx_context::sender(arg6));
        };
        let v8 = 0x2::coin::from_balance<T2>(v0, arg6);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, T2>(arg1, &arg0.id, 0x2::coin::value<T2>(&v8));
        v8
    }

    // decompiled from Move bytecode v6
}

