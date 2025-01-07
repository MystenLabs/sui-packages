module 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::cetus {
    public fun calculate_router_swap_result<T0, T1, T2, T3>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: bool, arg3: bool, arg4: bool, arg5: u64) {
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::calculate_router_swap_result<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun check_coin_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::check_coin_threshold<T0>(arg0, arg1);
    }

    public fun swap_ab<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u128, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::DCA<T0, T1>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::init_trade<T0, T1>(arg5, arg4, arg7);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap<T0, T1>(arg0, arg1, v3, 0x2::coin::zero<T1>(arg7), true, true, 0x2::coin::value<T0>(&v3), arg2, arg3, arg4, arg7);
        let v6 = v5;
        0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::assert_min_price<T0, T1>(0x2::coin::value<T1>(&v6), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::owner<T0, T1>(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::owner<T0, T1>(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::resolve_trade<T0, T1>(arg5, v2, arg6, arg7), 0x2::tx_context::sender(arg7));
    }

    public fun swap_ab_bc<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::DCA<T0, T2>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::init_trade<T0, T2>(arg8, arg7, arg10);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap_ab_bc<T0, T1, T2>(arg0, arg1, arg2, v3, 0x2::coin::zero<T2>(arg10), true, 0x2::coin::value<T0>(&v3), arg4, arg5, arg6, arg7, arg10);
        let v6 = v5;
        0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::assert_min_price<T0, T2>(0x2::coin::value<T2>(&v6), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::owner<T0, T2>(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v6, 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::owner<T0, T2>(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::resolve_trade<T0, T2>(arg8, v2, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    public fun swap_ab_cb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::DCA<T0, T2>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::init_trade<T0, T2>(arg8, arg7, arg10);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap_ab_cb<T0, T1, T2>(arg0, arg1, arg2, v3, 0x2::coin::zero<T2>(arg10), true, 0x2::coin::value<T0>(&v3), arg4, arg5, arg6, arg7, arg10);
        let v6 = v5;
        0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::assert_min_price<T0, T2>(0x2::coin::value<T2>(&v6), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::owner<T0, T2>(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v6, 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::owner<T0, T2>(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::resolve_trade<T0, T2>(arg8, v2, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    public fun swap_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u128, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::DCA<T1, T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::init_trade<T1, T0>(arg5, arg4, arg7);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap<T0, T1>(arg0, arg1, 0x2::coin::zero<T0>(arg7), v3, false, true, 0x2::coin::value<T1>(&v3), arg2, arg3, arg4, arg7);
        let v6 = v4;
        0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::assert_min_price<T1, T0>(0x2::coin::value<T0>(&v6), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::owner<T1, T0>(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::owner<T1, T0>(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::resolve_trade<T1, T0>(arg5, v2, arg6, arg7), 0x2::tx_context::sender(arg7));
    }

    public fun swap_ba_bc<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::DCA<T0, T2>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::init_trade<T0, T2>(arg8, arg7, arg10);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap_ba_bc<T0, T1, T2>(arg0, arg1, arg2, v3, 0x2::coin::zero<T2>(arg10), true, 0x2::coin::value<T0>(&v3), arg4, arg5, arg6, arg7, arg10);
        let v6 = v5;
        0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::assert_min_price<T0, T2>(0x2::coin::value<T2>(&v6), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::owner<T0, T2>(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v6, 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::owner<T0, T2>(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::resolve_trade<T0, T2>(arg8, v2, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    public fun swap_ba_cb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::DCA<T0, T2>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::init_trade<T0, T2>(arg8, arg7, arg10);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap_ba_cb<T0, T1, T2>(arg0, arg1, arg2, v3, 0x2::coin::zero<T2>(arg10), true, 0x2::coin::value<T0>(&v3), arg4, arg5, arg6, arg7, arg10);
        let v6 = v5;
        0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::assert_min_price<T0, T2>(0x2::coin::value<T2>(&v6), &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::owner<T0, T2>(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v6, 0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::owner<T0, T2>(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x495de18feac86973ee1f88d9ad2cc52592ec8f2afdf05e95a1aa3bf1ef312b84::dca::resolve_trade<T0, T2>(arg8, v2, arg9, arg10), 0x2::tx_context::sender(arg10));
    }

    // decompiled from Move bytecode v6
}

