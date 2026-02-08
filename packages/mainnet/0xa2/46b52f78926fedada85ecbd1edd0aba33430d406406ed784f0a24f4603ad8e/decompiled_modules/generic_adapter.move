module 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::generic_adapter {
    public fun begin_trade<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::GlobalConfig, arg2: &0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::PriceFeedRegistry, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::DCA<T0, T1>, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::TradePromise<T0, T1>) {
        0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::assert_executor_allowed(arg1, 0x2::tx_context::sender(arg8));
        let (v0, v1) = 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::init_trade<T0, T1>(arg7, arg1, arg0, arg2, arg3, arg4, arg5, arg6, arg8);
        (0x2::coin::from_balance<T0>(v0, arg8), v1)
    }

    public fun end_trade<T0, T1>(arg0: &mut 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::DCA<T0, T1>, arg1: &mut 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::config::FeeTracker, arg2: 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::TradePromise<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::owner<T0, T1>(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::dca::resolve_trade<T0, T1>(arg0, arg1, arg2, 0x2::coin::value<T1>(&arg3), arg4, arg5), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

