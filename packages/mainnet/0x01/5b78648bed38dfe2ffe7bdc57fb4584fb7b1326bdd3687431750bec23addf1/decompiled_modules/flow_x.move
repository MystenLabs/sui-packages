module 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::flow_x {
    public entry fun swap_exact_input_doublehop<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::GlobalConfig, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &mut 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::FeeTracker, arg4: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::PriceFeedRegistry, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T0>, arg10: u64, arg11: address, arg12: u64, arg13: &mut 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::DCA<T0, T2>, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::assert_executor_allowed(arg1, 0x2::tx_context::sender(arg15));
        assert!(0x2::coin::value<T0>(&arg9) == 0, 1);
        assert!(arg11 == 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::owner<T0, T2>(arg13), 2);
        let (v0, v1) = 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::init_trade<T0, T2>(arg13, arg1, arg0, arg4, arg5, arg6, arg7, arg8, arg15);
        let v2 = v1;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg9), v0);
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::assert_max_price_via_output<T0, T2>(arg10, &v2);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_doublehop<T0, T1, T2>(arg0, arg2, arg9, arg10, 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::owner<T0, T2>(arg13), arg12, arg15);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::resolve_trade<T0, T2>(arg13, arg3, v2, arg10, arg14, arg15), 0x2::tx_context::sender(arg15));
    }

    public entry fun swap_exact_input_triplehop<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::GlobalConfig, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &mut 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::FeeTracker, arg4: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::PriceFeedRegistry, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T0>, arg10: u64, arg11: address, arg12: u64, arg13: &mut 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::DCA<T0, T3>, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::assert_executor_allowed(arg1, 0x2::tx_context::sender(arg15));
        assert!(0x2::coin::value<T0>(&arg9) == 0, 1);
        assert!(arg11 == 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::owner<T0, T3>(arg13), 2);
        let (v0, v1) = 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::init_trade<T0, T3>(arg13, arg1, arg0, arg4, arg5, arg6, arg7, arg8, arg15);
        let v2 = v1;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg9), v0);
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::assert_max_price_via_output<T0, T3>(arg10, &v2);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_triplehop<T0, T1, T2, T3>(arg0, arg2, arg9, arg10, 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::owner<T0, T3>(arg13), arg12, arg15);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::resolve_trade<T0, T3>(arg13, arg3, v2, arg10, arg14, arg15), 0x2::tx_context::sender(arg15));
    }

    public entry fun swap_exact_output_doublehop<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::GlobalConfig, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &mut 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::FeeTracker, arg4: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::PriceFeedRegistry, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T0>, arg10: u64, arg11: u64, arg12: address, arg13: u64, arg14: &mut 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::DCA<T0, T2>, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::assert_executor_allowed(arg1, 0x2::tx_context::sender(arg16));
        assert!(0x2::coin::value<T0>(&arg9) == 0, 1);
        assert!(arg12 == 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::owner<T0, T2>(arg14), 2);
        let (v0, v1) = 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::init_trade<T0, T2>(arg14, arg1, arg0, arg4, arg5, arg6, arg7, arg8, arg16);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::balance::value<T0>(&v3);
        assert!(arg10 == v4, 0);
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg9), v3);
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::assert_max_price_via_output<T0, T2>(arg11, &v2);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_output_doublehop<T0, T1, T2>(arg0, arg2, arg9, v4, arg11, 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::owner<T0, T2>(arg14), arg13, arg16);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::resolve_trade<T0, T2>(arg14, arg3, v2, arg11, arg15, arg16), 0x2::tx_context::sender(arg16));
    }

    public entry fun swap_exact_output_triplehop<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::GlobalConfig, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &mut 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::FeeTracker, arg4: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::PriceFeedRegistry, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T0>, arg10: u64, arg11: u64, arg12: address, arg13: u64, arg14: &mut 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::DCA<T0, T3>, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::assert_executor_allowed(arg1, 0x2::tx_context::sender(arg16));
        assert!(0x2::coin::value<T0>(&arg9) == 0, 1);
        assert!(arg12 == 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::owner<T0, T3>(arg14), 2);
        let (v0, v1) = 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::init_trade<T0, T3>(arg14, arg1, arg0, arg4, arg5, arg6, arg7, arg8, arg16);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::balance::value<T0>(&v3);
        assert!(arg10 == v4, 0);
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg9), v3);
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::assert_max_price_via_output<T0, T3>(arg11, &v2);
        0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_output_triplehop<T0, T1, T2, T3>(arg0, arg2, arg9, v4, arg11, 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::owner<T0, T3>(arg14), arg13, arg16);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::resolve_trade<T0, T3>(arg14, arg3, v2, arg11, arg15, arg16), 0x2::tx_context::sender(arg16));
    }

    public entry fun swap_exact_input<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::GlobalConfig, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &mut 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::FeeTracker, arg4: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::PriceFeedRegistry, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T0>, arg10: &mut 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::DCA<T0, T1>, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::assert_executor_allowed(arg1, 0x2::tx_context::sender(arg12));
        assert!(0x2::coin::value<T0>(&arg9) == 0, 1);
        let (v0, v1) = 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::init_trade<T0, T1>(arg10, arg1, arg0, arg4, arg5, arg6, arg7, arg8, arg12);
        let v2 = v1;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg9), v0);
        let v3 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T0, T1>(arg2, arg9, arg12);
        let v4 = 0x2::coin::value<T1>(&v3);
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::assert_max_price_via_output<T0, T1>(v4, &v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::owner<T0, T1>(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::resolve_trade<T0, T1>(arg10, arg3, v2, v4, arg11, arg12), 0x2::tx_context::sender(arg12));
    }

    public entry fun swap_exact_output<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::GlobalConfig, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &mut 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::FeeTracker, arg4: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::PriceFeedRegistry, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T0>, arg10: u64, arg11: &mut 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::DCA<T0, T1>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::assert_executor_allowed(arg1, 0x2::tx_context::sender(arg13));
        assert!(0x2::coin::value<T0>(&arg9) == 0, 1);
        let (v0, v1) = 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::init_trade<T0, T1>(arg11, arg1, arg0, arg4, arg5, arg6, arg7, arg8, arg13);
        let v2 = v1;
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut arg9), v0);
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::assert_max_price_via_output<T0, T1>(arg10, &v2);
        let v3 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_output_direct<T0, T1>(arg2, arg9, arg10, arg13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::owner<T0, T1>(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::resolve_trade<T0, T1>(arg11, arg3, v2, 0x2::coin::value<T1>(&v3), arg12, arg13), 0x2::tx_context::sender(arg13));
    }

    // decompiled from Move bytecode v6
}

