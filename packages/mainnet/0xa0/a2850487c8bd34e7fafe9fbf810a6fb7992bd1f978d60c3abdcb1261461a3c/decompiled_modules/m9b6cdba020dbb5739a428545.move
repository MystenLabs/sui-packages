module 0xa0a2850487c8bd34e7fafe9fbf810a6fb7992bd1f978d60c3abdcb1261461a3c::m9b6cdba020dbb5739a428545 {
    public entry fun f6155ea7be781fa955f82793d<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        fe2b0152c6ed944264fe63160<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public(friend) fun fe2b0152c6ed944264fe63160<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0xa0a2850487c8bd34e7fafe9fbf810a6fb7992bd1f978d60c3abdcb1261461a3c::mde0b718f2843e8a8463ea35c::f984558432a343e98fc002c98(arg3, arg11);
        let v0 = 0x2::coin::value<T1>(&arg5);
        assert!(arg7 <= v0, 0);
        0x2::coin::join<T1>(&mut arg5, 0xa0a2850487c8bd34e7fafe9fbf810a6fb7992bd1f978d60c3abdcb1261461a3c::m67209a09efee86da5f7f5055::f0e8402d70bd781c43e804356<T0, T1>(arg1, arg2, 0xa0a2850487c8bd34e7fafe9fbf810a6fb7992bd1f978d60c3abdcb1261461a3c::m6c35b1c350129fa4e196b203::fb6503a2abb137d348cd080de<T0, T1>(arg0, arg3, arg4, &mut arg5, arg6, arg7, arg12), arg8, arg10, arg3, arg12));
        0xa0a2850487c8bd34e7fafe9fbf810a6fb7992bd1f978d60c3abdcb1261461a3c::mde0b718f2843e8a8463ea35c::f001ce63d2ecae00c213f41f1<T1>(arg5, v0, arg9, arg12);
    }

    // decompiled from Move bytecode v7
}

