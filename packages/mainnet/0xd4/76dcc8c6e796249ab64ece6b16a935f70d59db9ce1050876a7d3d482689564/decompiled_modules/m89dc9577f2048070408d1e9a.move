module 0xd476dcc8c6e796249ab64ece6b16a935f70d59db9ce1050876a7d3d482689564::m89dc9577f2048070408d1e9a {
    public entry fun f88cc5ade24d4adec4af7f994<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        fab3b25e75e46f8fd823b6638<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public(friend) fun fab3b25e75e46f8fd823b6638<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0xd476dcc8c6e796249ab64ece6b16a935f70d59db9ce1050876a7d3d482689564::m2fa2a7235b34b218fa9edf2e::fc67ce9b99e7d1a3bde3ad046(arg3, arg11);
        let v0 = 0x2::coin::value<T1>(&arg5);
        assert!(arg7 <= v0, 0);
        0x2::coin::join<T1>(&mut arg5, 0xd476dcc8c6e796249ab64ece6b16a935f70d59db9ce1050876a7d3d482689564::m139811a625aeae61648b5281::fd2c851a71e33cf79d8e34b57<T0, T1>(arg1, arg2, 0xd476dcc8c6e796249ab64ece6b16a935f70d59db9ce1050876a7d3d482689564::mc6d40359563ea963ebf9736d::f5fbf9010bb2c33469eb6605a<T0, T1>(arg0, arg3, arg4, &mut arg5, arg6, arg7, arg12), arg8, arg10, arg3, arg12));
        0xd476dcc8c6e796249ab64ece6b16a935f70d59db9ce1050876a7d3d482689564::m2fa2a7235b34b218fa9edf2e::f11e3bbb63e4e899a80c0da00<T1>(arg5, v0, arg9, arg12);
    }

    // decompiled from Move bytecode v7
}

