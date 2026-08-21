module 0xff9a651c91006c4aea2074d110973a8a6b2367a0d3f1c6a9589ccd07390d8b23::mab76ac31d0aee03c0d42d82f {
    public entry fun f9ac0a6a2ac743f82054161fe<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        fa86f8f11099b036f39e8990b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public(friend) fun fa86f8f11099b036f39e8990b<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0xff9a651c91006c4aea2074d110973a8a6b2367a0d3f1c6a9589ccd07390d8b23::mf727b17db86bfcff9c8d481b::fc3bddf00d862906ad6cb3d8f(arg3, arg11);
        let v0 = 0x2::coin::value<T1>(&arg5);
        assert!(arg7 <= v0, 0);
        0x2::coin::join<T1>(&mut arg5, 0xff9a651c91006c4aea2074d110973a8a6b2367a0d3f1c6a9589ccd07390d8b23::mabe373e5eb419962153056ff::fb7cc351014ef93ecdf09ab4d<T0, T1>(arg1, arg2, 0xff9a651c91006c4aea2074d110973a8a6b2367a0d3f1c6a9589ccd07390d8b23::me99076ab4cea78d763711183::fe8fbb31cd14511dc65ddf9c7<T0, T1>(arg0, arg3, arg4, &mut arg5, arg6, arg7, arg12), arg8, arg10, arg3, arg12));
        0xff9a651c91006c4aea2074d110973a8a6b2367a0d3f1c6a9589ccd07390d8b23::mf727b17db86bfcff9c8d481b::fc62131054592867b5f21c749<T1>(arg5, v0, arg9, arg12);
    }

    // decompiled from Move bytecode v7
}

