module 0x75beb4151654e3004a847623031ea033d7b1573d4c81509892f86048d03f87e0::h2 {
    public fun sxy<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x75beb4151654e3004a847623031ea033d7b1573d4c81509892f86048d03f87e0::u::tod<T0>(arg3, 0x2::tx_context::sender(arg4));
        0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::trader::sell_base_coin<T0, T1>(arg0, arg1, arg2, &mut arg3, 0x2::coin::value<T0>(&arg3), 0, arg4)
    }

    public fun syx<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x75beb4151654e3004a847623031ea033d7b1573d4c81509892f86048d03f87e0::u::tod<T1>(arg3, 0x2::tx_context::sender(arg4));
        0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::trader::sell_quote_coin<T0, T1>(arg0, arg1, arg2, &mut arg3, 0x2::coin::value<T1>(&arg3), 0, arg4)
    }

    // decompiled from Move bytecode v6
}

