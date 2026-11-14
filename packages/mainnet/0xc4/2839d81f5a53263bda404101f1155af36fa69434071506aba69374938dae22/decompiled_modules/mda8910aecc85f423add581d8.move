module 0xc42839d81f5a53263bda404101f1155af36fa69434071506aba69374938dae22::mda8910aecc85f423add581d8 {
    public(friend) fun fbe3dded35d672b0506a4fada<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0xc42839d81f5a53263bda404101f1155af36fa69434071506aba69374938dae22::m50b6bff2d9fe8a58d40e9de5::f4a556174bc866391c3178eb4(arg3, arg11);
        let v0 = 0x2::coin::value<T1>(&arg5);
        assert!(arg7 <= v0, 0);
        0x2::coin::join<T1>(&mut arg5, 0xc42839d81f5a53263bda404101f1155af36fa69434071506aba69374938dae22::m63d3237c77d917fd1abb3872::f9a269145924ee7040881d050<T0, T1>(arg1, arg2, 0xc42839d81f5a53263bda404101f1155af36fa69434071506aba69374938dae22::m41053ea5c4649a8fe34938d6::f3d277e9d458bc12742485cfe<T0, T1>(arg0, arg3, arg4, &mut arg5, arg6, arg7, arg12), arg8, arg10, arg3, arg12));
        0xc42839d81f5a53263bda404101f1155af36fa69434071506aba69374938dae22::m50b6bff2d9fe8a58d40e9de5::f794ca6bb5f43323ee34eade5<T1>(arg5, v0, arg9, arg12);
    }

    public entry fun fe3b7400a3a362b92fe359a0f<T0, T1>(arg0: &mut 0x9525dec11fb79eaef17138ee0352dedf4ee817bc44893a9465e7bb217b45761::oracle_driven_pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        fbe3dded35d672b0506a4fada<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    // decompiled from Move bytecode v7
}

