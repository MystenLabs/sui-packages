module 0x8ee188a542680ce4a6446d5cd823d544eb039778bab86b765828db0f583ec114::mb134970b2660da6faaa5c052 {
    public fun f69f3afeb3db8ccd8bf782739<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::trader::sell_quote_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun f71766f9581b176349aa646e8<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::trader::sell_base_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun f948852f3f3bdc8abc919293c<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::trader::buy_base_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v7
}

