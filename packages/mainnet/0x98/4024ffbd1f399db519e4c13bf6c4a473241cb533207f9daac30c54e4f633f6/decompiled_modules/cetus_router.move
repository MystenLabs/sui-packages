module 0x954e404cdd15b5859c18425b737d848d28f7f63ae6b74e9a2656784d1ae0683c::cetus_router {
    struct Cetus has drop {
        dummy_field: bool,
    }

    public fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x1::option::Option<0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::TradePromise<T0, T1>>, arg11: &mut 0x1::option::Option<0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::TradePromise<T1, T0>>, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 == true, 2);
        let (v0, v1) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12);
        if (arg4 == true) {
            let v2 = 0x1::option::borrow_mut<0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::TradePromise<T0, T1>>(arg10);
            assert!(0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_input<T0, T1>(v2) == arg6, 1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_owner<T0, T1>(v2));
            let v3 = Cetus{dummy_field: false};
            0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::add_trade_proof_with_coin<Cetus, T0, T1>(v3, v2, arg6, v1);
        } else {
            let v4 = 0x1::option::borrow_mut<0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::TradePromise<T1, T0>>(arg11);
            assert!(0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_input<T1, T0>(v4) == arg6, 1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_owner<T1, T0>(v4));
            let v5 = Cetus{dummy_field: false};
            0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::add_trade_proof_with_coin<Cetus, T1, T0>(v5, v4, arg6, v0);
        };
    }

    public fun calculate_router_swap_result<T0, T1, T2, T3>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: bool, arg3: bool, arg4: bool, arg5: u64) {
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::calculate_router_swap_result<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun check_coin_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::check_coin_threshold<T0>(arg0, arg1);
    }

    public fun swap_ab_bc<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::TradePromise<T0, T2>, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 == true, 2);
        assert!(0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_input<T0, T2>(arg11) == arg6, 1);
        let (v0, v1) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap_ab_bc<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_owner<T0, T2>(arg11));
        let v2 = Cetus{dummy_field: false};
        0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::add_trade_proof_with_coin<Cetus, T0, T2>(v2, arg11, arg6, v1);
    }

    public fun swap_ab_cb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::TradePromise<T0, T2>, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 == true, 2);
        assert!(0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_input<T0, T2>(arg11) == arg6, 1);
        let (v0, v1) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap_ab_cb<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_owner<T0, T2>(arg11));
        let v2 = Cetus{dummy_field: false};
        0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::add_trade_proof_with_coin<Cetus, T0, T2>(v2, arg11, arg6, v1);
    }

    public fun swap_ba_bc<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::TradePromise<T0, T2>, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 == true, 2);
        assert!(0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_input<T0, T2>(arg11) == arg6, 1);
        let (v0, v1) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap_ba_bc<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_owner<T0, T2>(arg11));
        let v2 = Cetus{dummy_field: false};
        0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::add_trade_proof_with_coin<Cetus, T0, T2>(v2, arg11, arg6, v1);
    }

    public fun swap_ba_cb<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::TradePromise<T0, T2>, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 == true, 2);
        assert!(0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_input<T0, T2>(arg11) == arg6, 1);
        let (v0, v1) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap_ba_cb<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::trade_owner<T0, T2>(arg11));
        let v2 = Cetus{dummy_field: false};
        0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::dca::add_trade_proof_with_coin<Cetus, T0, T2>(v2, arg11, arg6, v1);
    }

    // decompiled from Move bytecode v6
}

