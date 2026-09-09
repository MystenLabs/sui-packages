module 0xfc00e48f9200ac0cf66666b9e711f43be9ecb837d92c27d19df0e3d38d30c2ba::m57d1a1db288edad601810bcf {
    public entry fun fda170c1fabb82f3c974f1d8d<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        fdf3c8e7b496a9ecf79fbe058<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public(friend) fun fdf3c8e7b496a9ecf79fbe058<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        0xfc00e48f9200ac0cf66666b9e711f43be9ecb837d92c27d19df0e3d38d30c2ba::m8d6660136033ea1321f4178d::fce66912f4b6c0425e71a2434(arg3, arg12);
        let v0 = 0x2::coin::value<T1>(&arg5);
        assert!(arg6 <= v0, 0);
        let v1 = 0xfc00e48f9200ac0cf66666b9e711f43be9ecb837d92c27d19df0e3d38d30c2ba::ma679b663af24d1f2791fabed::fbc0e0c925d00ed999c7112ca<T0, T1>(arg1, arg2, 0x2::coin::split<T1>(&mut arg5, arg6, arg13), arg8, arg11, arg3, arg13);
        assert!(0x2::coin::value<T0>(&v1) == arg7, 1);
        0x2::coin::join<T1>(&mut arg5, 0xfc00e48f9200ac0cf66666b9e711f43be9ecb837d92c27d19df0e3d38d30c2ba::m2067b2e6f15b4edb3d2394eb::ffda8346d1cb13bd909f5e877<T0, T1>(arg0, arg3, arg4, v1, arg9, arg13));
        0xfc00e48f9200ac0cf66666b9e711f43be9ecb837d92c27d19df0e3d38d30c2ba::m8d6660136033ea1321f4178d::fc876086f014abbab01f9360a<T1>(arg5, v0, arg10, arg13);
    }

    // decompiled from Move bytecode v7
}

