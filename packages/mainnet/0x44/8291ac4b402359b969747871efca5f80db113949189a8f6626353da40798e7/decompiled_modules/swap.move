module 0x448291ac4b402359b969747871efca5f80db113949189a8f6626353da40798e7::swap {
    public fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    fun swap_<T0, T1>(arg0: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u64, arg7: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::versioned::Versioned, arg8: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::GlobalConfig, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::flash_swap<T0, T1>(arg0, arg3, arg4, arg5, arg8, arg7, arg9, arg10);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::pay_amount<T0, T1>(&v3);
        let v7 = if (arg3) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        if (arg4) {
            assert!(v6 == arg5, 13906834895897886721);
            assert!(v7 >= arg6, 13906834900192985091);
        } else {
            assert!(v7 == arg5, 13906834908782788609);
            assert!(v6 <= arg6, 13906834913078018053);
        };
        let (v8, v9) = if (arg3) {
            assert!(0x2::coin::value<T0>(arg1) >= v6, 13906834930258018311);
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v6, arg10)), 0x2::balance::zero<T1>())
        } else {
            assert!(0x2::coin::value<T1>(arg2) >= v6, 13906834943142920199);
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, v6, arg10)))
        };
        0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::repay_flash_swap<T0, T1>(arg0, v8, v9, v3, arg7);
        0x2::coin::join<T0>(arg1, 0x2::coin::from_balance<T0>(v5, arg10));
        0x2::coin::join<T1>(arg2, 0x2::coin::from_balance<T1>(v4, arg10));
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::GlobalConfig, arg6: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T1>(arg8);
        let v1 = &mut v0;
        swap_<T0, T1>(arg0, arg1, v1, true, arg2, arg3, arg4, arg6, arg5, arg7, arg8);
        send_coin<T1>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun swap_a2b_with_partner<T0, T1>(arg0: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>, arg1: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::partner::Partner, arg2: &mut 0x2::coin::Coin<T0>, arg3: bool, arg4: u64, arg5: u64, arg6: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::GlobalConfig, arg7: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T1>(arg9);
        let v1 = &mut v0;
        swap_with_partner_<T0, T1>(arg0, arg1, arg2, v1, true, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        send_coin<T1>(v0, 0x2::tx_context::sender(arg9));
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: bool, arg3: u64, arg4: u64, arg5: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::GlobalConfig, arg6: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg8);
        let v1 = &mut v0;
        swap_<T0, T1>(arg0, v1, arg1, false, arg2, arg3, arg4, arg6, arg5, arg7, arg8);
        send_coin<T0>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun swap_b2a_with_partner<T0, T1>(arg0: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>, arg1: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::partner::Partner, arg2: &mut 0x2::coin::Coin<T1>, arg3: bool, arg4: u64, arg5: u64, arg6: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::GlobalConfig, arg7: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg9);
        let v1 = &mut v0;
        swap_with_partner_<T0, T1>(arg0, arg1, v1, arg2, false, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        send_coin<T0>(v0, 0x2::tx_context::sender(arg9));
    }

    fun swap_with_partner_<T0, T1>(arg0: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>, arg1: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::partner::Partner, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::GlobalConfig, arg9: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::versioned::Versioned, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, arg9, arg10, arg11);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::pay_amount<T0, T1>(&v3);
        let v7 = if (arg4) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        if (arg5) {
            assert!(v6 == arg6, 13906835140711022593);
            assert!(v7 >= arg7, 13906835145006120963);
        } else {
            assert!(v7 == arg6, 13906835153595924481);
            assert!(v6 <= arg7, 13906835157891153925);
        };
        let (v8, v9) = if (arg4) {
            assert!(0x2::coin::value<T0>(arg2) >= v6, 13906835175071154183);
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v6, arg11)), 0x2::balance::zero<T1>())
        } else {
            assert!(0x2::coin::value<T1>(arg3) >= v6, 13906835187956056071);
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v6, arg11)))
        };
        0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, v8, v9, v3, arg9);
        0x2::coin::join<T0>(arg2, 0x2::coin::from_balance<T0>(v5, arg11));
        0x2::coin::join<T1>(arg3, 0x2::coin::from_balance<T1>(v4, arg11));
    }

    // decompiled from Move bytecode v6
}

