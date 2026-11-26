module 0x522a988a51a615733b2b2d8339899f75c865fa5a5b29951a882d8b3da3114f76::mf8e25b7a9c7c6fe2ccc6e4bd {
    public entry fun f57684f3759b0b13539645fe4<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        fc7fc2904149e4d09ad7c6d2c<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public(friend) fun fc7fc2904149e4d09ad7c6d2c<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0x522a988a51a615733b2b2d8339899f75c865fa5a5b29951a882d8b3da3114f76::m3105a9db0fb60ba9721c3e42::f8f8d41384e7a31ab80b0a606(arg3, arg11);
        let v0 = 0x2::coin::value<T1>(&arg5);
        assert!(arg7 <= v0, 0);
        0x2::coin::join<T1>(&mut arg5, 0x522a988a51a615733b2b2d8339899f75c865fa5a5b29951a882d8b3da3114f76::m1f6a166f0780f704875d68ee::ffa8c70cc58cb118d43db2360<T0, T1>(arg1, arg2, 0x522a988a51a615733b2b2d8339899f75c865fa5a5b29951a882d8b3da3114f76::m959f09b0ecc9470e3ae188d0::fa73681664020df19834330b3<T0, T1>(arg0, arg3, arg4, &mut arg5, arg6, arg7, arg12), arg8, arg10, arg3, arg12));
        0x522a988a51a615733b2b2d8339899f75c865fa5a5b29951a882d8b3da3114f76::m3105a9db0fb60ba9721c3e42::ff5e1c244d571bcbe6ac51873<T1>(arg5, v0, arg9, arg12);
    }

    // decompiled from Move bytecode v7
}

