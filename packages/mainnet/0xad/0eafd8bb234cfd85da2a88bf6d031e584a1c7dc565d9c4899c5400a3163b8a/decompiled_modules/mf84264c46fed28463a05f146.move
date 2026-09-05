module 0xad0eafd8bb234cfd85da2a88bf6d031e584a1c7dc565d9c4899c5400a3163b8a::mf84264c46fed28463a05f146 {
    public entry fun f5b3adb3eaf7ecb414456e944<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        fadfe8e35a703e6ca05bfd1f1<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public(friend) fun fadfe8e35a703e6ca05bfd1f1<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0xad0eafd8bb234cfd85da2a88bf6d031e584a1c7dc565d9c4899c5400a3163b8a::mc5933433146972d55c6c326e::f68f8dc031dd28732f874087e(arg3, arg11);
        let v0 = 0x2::coin::value<T1>(&arg5);
        assert!(arg7 <= v0, 0);
        0x2::coin::join<T1>(&mut arg5, 0xad0eafd8bb234cfd85da2a88bf6d031e584a1c7dc565d9c4899c5400a3163b8a::mb1d33ec6552e01c2f9da87c8::f6bdbfb836149719f870fb35a<T0, T1>(arg1, arg2, 0xad0eafd8bb234cfd85da2a88bf6d031e584a1c7dc565d9c4899c5400a3163b8a::m69eb061b7507c42f746b7bef::f14087bc963f0464b60d46077<T0, T1>(arg0, arg3, arg4, &mut arg5, arg6, arg7, arg12), arg8, arg10, arg3, arg12));
        0xad0eafd8bb234cfd85da2a88bf6d031e584a1c7dc565d9c4899c5400a3163b8a::mc5933433146972d55c6c326e::f42703ddd39d085e04e5df3a2<T1>(arg5, v0, arg9, arg12);
    }

    // decompiled from Move bytecode v7
}

