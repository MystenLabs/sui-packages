module 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::cetus {
    public fun calculate_router_swap_result<T0, T1, T2, T3>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: bool, arg3: bool, arg4: bool, arg5: u64) {
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::calculate_router_swap_result<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun check_coin_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::check_coin_threshold<T0>(arg0, arg1);
    }

    public fun swap_ab_bc<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::DCA<T0, T2>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 == true, 1);
        let (v0, v1) = 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::init_trade<T0, T2>(arg11, arg10, arg13);
        let v2 = v1;
        let v3 = v0;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg3), v3);
        let (v4, v5) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap_ab_bc<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::balance::value<T0>(&v3), arg7, arg8, arg9, arg10, arg13);
        let v6 = v5;
        0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::assert_min_price<T0, T2>(0x2::coin::value<T2>(&v6), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T0, T2>(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v6, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T0, T2>(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::resolve_trade<T0, T2>(arg11, v2, arg12, arg13), 0x2::tx_context::sender(arg13));
    }

    public fun swap_ab_cb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::DCA<T0, T2>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 == true, 1);
        let (v0, v1) = 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::init_trade<T0, T2>(arg11, arg10, arg13);
        let v2 = v1;
        let v3 = v0;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg3), v3);
        let (v4, v5) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap_ab_cb<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::balance::value<T0>(&v3), arg7, arg8, arg9, arg10, arg13);
        let v6 = v5;
        0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::assert_min_price<T0, T2>(0x2::coin::value<T2>(&v6), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T0, T2>(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v6, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T0, T2>(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::resolve_trade<T0, T2>(arg11, v2, arg12, arg13), 0x2::tx_context::sender(arg13));
    }

    public fun swap_ba_bc<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::DCA<T0, T2>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 == true, 1);
        let (v0, v1) = 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::init_trade<T0, T2>(arg11, arg10, arg13);
        let v2 = v1;
        let v3 = v0;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg3), v3);
        let (v4, v5) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap_ba_bc<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::balance::value<T0>(&v3), arg7, arg8, arg9, arg10, arg13);
        let v6 = v5;
        0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::assert_min_price<T0, T2>(0x2::coin::value<T2>(&v6), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T0, T2>(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v6, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T0, T2>(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::resolve_trade<T0, T2>(arg11, v2, arg12, arg13), 0x2::tx_context::sender(arg13));
    }

    public fun swap_ba_cb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::DCA<T0, T2>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 == true, 1);
        let (v0, v1) = 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::init_trade<T0, T2>(arg11, arg10, arg13);
        let v2 = v1;
        let v3 = v0;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg3), v3);
        let (v4, v5) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap_ba_cb<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::balance::value<T0>(&v3), arg7, arg8, arg9, arg10, arg13);
        let v6 = v5;
        0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::assert_min_price<T0, T2>(0x2::coin::value<T2>(&v6), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T0, T2>(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v6, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T0, T2>(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::resolve_trade<T0, T2>(arg11, v2, arg12, arg13), 0x2::tx_context::sender(arg13));
    }

    public fun swap_ab<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::DCA<T0, T1>, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 == true, 0);
        assert!(arg5 == true, 1);
        let (v0, v1) = 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::init_trade<T0, T1>(arg10, arg9, arg12);
        let v2 = v1;
        let v3 = v0;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg2), v3);
        let (v4, v5) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::balance::value<T0>(&v3), arg7, arg8, arg9, arg12);
        let v6 = v5;
        0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::assert_min_price<T0, T1>(0x2::coin::value<T1>(&v6), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T0, T1>(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T0, T1>(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::resolve_trade<T0, T1>(arg10, v2, arg11, arg12), 0x2::tx_context::sender(arg12));
    }

    public fun swap_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::DCA<T1, T0>, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 == false, 0);
        assert!(arg5 == true, 1);
        let (v0, v1) = 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::init_trade<T1, T0>(arg10, arg9, arg12);
        let v2 = v1;
        let v3 = v0;
        0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(&mut arg2), v3);
        let (v4, v5) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap<T0, T1>(arg0, arg1, arg3, arg2, arg4, arg5, 0x2::balance::value<T1>(&v3), arg7, arg8, arg9, arg12);
        let v6 = v4;
        0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::assert_min_price<T1, T0>(0x2::coin::value<T0>(&v6), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T1, T0>(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, 0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::owner<T1, T0>(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa74eb3567306ba569100dab765ed9bbbb83d581d912f742fd93ade2a1c4adb2f::dca::resolve_trade<T1, T0>(arg10, v2, arg11, arg12), 0x2::tx_context::sender(arg12));
    }

    // decompiled from Move bytecode v6
}

