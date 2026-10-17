module 0x284dfba01ac30adfd340bc545e340fac9c8725314374960e17684e3e3f7c9ba8::meb94c33a6b8c67dfc05b1aa6 {
    public(friend) fun f84527568af726f1ca538da57<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0x284dfba01ac30adfd340bc545e340fac9c8725314374960e17684e3e3f7c9ba8::mf54cf72d106607bcf7335a21::fd8a5f7b8a548bc8605522d86(arg3, arg11);
        let v0 = 0x2::coin::value<T1>(&arg5);
        assert!(arg7 <= v0, 0);
        0x2::coin::join<T1>(&mut arg5, 0x284dfba01ac30adfd340bc545e340fac9c8725314374960e17684e3e3f7c9ba8::mc6c598321ce7fe8f2e8699b1::feb34e1f3b7db23db3c7b131a<T0, T1>(arg1, arg2, 0x284dfba01ac30adfd340bc545e340fac9c8725314374960e17684e3e3f7c9ba8::macff2d79f8f7e1596c8f932e::f3a5858cb9a7f4b454c270abe<T0, T1>(arg0, arg3, arg4, &mut arg5, arg6, arg7, arg12), arg8, arg10, arg3, arg12));
        0x284dfba01ac30adfd340bc545e340fac9c8725314374960e17684e3e3f7c9ba8::mf54cf72d106607bcf7335a21::fa14203e3009fdbc76bc451c5<T1>(arg5, v0, arg9, arg12);
    }

    public entry fun fd1464dba605e0fb69aa1c918<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        f84527568af726f1ca538da57<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    // decompiled from Move bytecode v7
}

