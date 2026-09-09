module 0x661f77056d916c84ee7e82ff128fa7289d84e6c54d4c6711195d05900806e046::m70aa6043b457536e62583318 {
    public(friend) fun f2130dacc3f3e1db3596b2e80<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0x661f77056d916c84ee7e82ff128fa7289d84e6c54d4c6711195d05900806e046::meacb1934523b5fe183459d59::fa39d5e81b0926bab7d045660(arg3, arg11);
        let v0 = 0x2::coin::value<T1>(&arg5);
        assert!(arg7 <= v0, 0);
        0x2::coin::join<T1>(&mut arg5, 0x661f77056d916c84ee7e82ff128fa7289d84e6c54d4c6711195d05900806e046::m5fd98c9598fb5e0182e8a65c::f01ba4e666be2eae96811c30d<T0, T1>(arg1, arg2, 0x661f77056d916c84ee7e82ff128fa7289d84e6c54d4c6711195d05900806e046::m5396b27a9c8a65b9e8236ad5::fe99e123820af2996a4e88fb2<T0, T1>(arg0, arg3, arg4, &mut arg5, arg6, arg7, arg12), arg8, arg10, arg3, arg12));
        0x661f77056d916c84ee7e82ff128fa7289d84e6c54d4c6711195d05900806e046::meacb1934523b5fe183459d59::f8739bc9a4fda72b37b786f74<T1>(arg5, v0, arg9, arg12);
    }

    public entry fun fe5b4f73ed90b17fd508efe44<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        f2130dacc3f3e1db3596b2e80<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    // decompiled from Move bytecode v7
}

