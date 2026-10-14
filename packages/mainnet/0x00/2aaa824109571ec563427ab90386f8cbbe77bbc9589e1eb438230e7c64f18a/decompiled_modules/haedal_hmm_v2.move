module 0x2aaa824109571ec563427ab90386f8cbbe77bbc9589e1eb438230e7c64f18a::haedal_hmm_v2 {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::coin::from_balance<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) == 0, 1);
        0x2::coin::destroy_zero<T0>(v0);
        0x2::coin::into_balance<T1>(0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::trader::sell_base_coin<T0, T1>(arg0, arg3, arg1, &mut v0, 0x2::balance::value<T0>(&arg2), 1, arg4))
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::from_balance<T1>(arg2, arg4);
        assert!(0x2::coin::value<T1>(&v0) == 0, 1);
        0x2::coin::destroy_zero<T1>(v0);
        0x2::coin::into_balance<T0>(0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::trader::sell_quote_coin<T0, T1>(arg0, arg3, arg1, &mut v0, 0x2::balance::value<T1>(&arg2), 1, arg4))
    }

    // decompiled from Move bytecode v7
}

