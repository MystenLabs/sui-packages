module 0x7ea164f681c5c82a2a70e4aed151524ccb905cd5c94a000d7c66687dcccff3a6::aftermath {
    public fun swap<T0, T1, T2>(arg0: &mut 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::SwapContext, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: bool, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg7) {
            swap_a2b<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9, arg10);
        } else {
            swap_b2a<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9, arg10);
        };
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::SwapContext, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::take_balance<T0>(arg0, arg7), arg9);
        let v1 = 0x2::coin::value<T0>(&v0);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T2, T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, v0, arg8, 900000000000000000, arg9);
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::emit_swap_event<T0, T1>(arg0, b"AFTERMATH", 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>>(arg1), v1, 0x2::coin::value<T1>(&v2), 0);
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::SwapContext, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::take_balance<T1>(arg0, arg7), arg9);
        let v1 = 0x2::coin::value<T1>(&v0);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T2, T1, T0>(arg1, arg2, arg3, arg4, arg5, arg6, v0, arg8, 900000000000000000, arg9);
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::emit_swap_event<T1, T0>(arg0, b"AFTERMATH", 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>>(arg1), v1, 0x2::coin::value<T0>(&v2), 0);
    }

    // decompiled from Move bytecode v6
}

