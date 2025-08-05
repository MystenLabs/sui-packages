module 0x5de6fae0024de58f2941a9223609fd1b544acbe24c8151dea9fdd17fda6821f1::obric {
    public fun swap<T0, T1>(arg0: &mut 0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::SwapContext, arg1: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg2: u64, arg3: bool, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8);
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::SwapContext, arg1: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg2: u64, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::take_balance<T0>(arg0, arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_x_to_y<T0, T1>(arg1, arg6, arg3, arg4, arg5, 0x2::coin::from_balance<T0>(v0, arg7), arg7);
        0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::emit_swap_event<T0, T1>(arg0, b"OBRIC", 0x2::object::id<0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>>(arg1), v1, 0x2::coin::value<T1>(&v2), 0, true);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::SwapContext, arg1: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg2: u64, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::take_balance<T1>(arg0, arg2);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::swap_y_to_x<T0, T1>(arg1, arg6, arg3, arg4, arg5, 0x2::coin::from_balance<T1>(v0, arg7), arg7);
        0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::emit_swap_event<T0, T1>(arg0, b"OBRIC", 0x2::object::id<0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>>(arg1), v1, 0x2::coin::value<T0>(&v2), 0, false);
    }

    // decompiled from Move bytecode v6
}

