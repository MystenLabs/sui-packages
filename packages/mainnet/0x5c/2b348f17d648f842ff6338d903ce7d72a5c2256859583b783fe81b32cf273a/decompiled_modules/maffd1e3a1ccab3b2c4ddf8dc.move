module 0x5c2b348f17d648f842ff6338d903ce7d72a5c2256859583b783fe81b32cf273a::maffd1e3a1ccab3b2c4ddf8dc {
    public entry fun f01f00ca3345a422ad0a9b289<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        fc0d610ce8bf61f4e14eec869<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public(friend) fun fc0d610ce8bf61f4e14eec869<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0x5c2b348f17d648f842ff6338d903ce7d72a5c2256859583b783fe81b32cf273a::m0fc6d0a325b3b94d238e1fab::ff83fd3374cebdcacd6f629ec(arg3, arg11);
        let v0 = 0x2::coin::value<T1>(&arg5);
        assert!(arg7 <= v0, 0);
        0x2::coin::join<T1>(&mut arg5, 0x5c2b348f17d648f842ff6338d903ce7d72a5c2256859583b783fe81b32cf273a::mba6fbbca4f902b032bec98c2::f6731b60aa443ce74b2a13617<T0, T1>(arg1, arg2, 0x5c2b348f17d648f842ff6338d903ce7d72a5c2256859583b783fe81b32cf273a::m615924695e8b4f7b21be61d8::fbb3d5a8cfa14018b739890e7<T0, T1>(arg0, arg3, arg4, &mut arg5, arg6, arg7, arg12), arg8, arg10, arg3, arg12));
        0x5c2b348f17d648f842ff6338d903ce7d72a5c2256859583b783fe81b32cf273a::m0fc6d0a325b3b94d238e1fab::f63bd322e9dc805930cfec3b8<T1>(arg5, v0, arg9, arg12);
    }

    // decompiled from Move bytecode v7
}

