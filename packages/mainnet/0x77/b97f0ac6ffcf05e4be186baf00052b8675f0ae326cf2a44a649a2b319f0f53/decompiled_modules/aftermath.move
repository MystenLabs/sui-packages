module 0x77b97f0ac6ffcf05e4be186baf00052b8675f0ae326cf2a44a649a2b319f0f53::aftermath {
    public fun swap_a2b<T0, T1, T2, T3>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T3>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::balance::Balance<T1>, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        assert!(0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::has_referrer(arg6, 0x2::tx_context::sender(arg9)) == arg8, 1);
        let v0 = 0x2::coin::into_balance<T2>(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in_direct<T3, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::from_balance<T1>(arg7, arg9), 1, arg9));
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T3>>(arg1), true, 0x2::balance::value<T2>(&v0));
        (v0, 0x2::balance::zero<T1>())
    }

    public fun swap_b2a<T0, T1, T2, T3>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T3>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::balance::Balance<T2>, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        assert!(0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::has_referrer(arg6, 0x2::tx_context::sender(arg9)) == arg8, 1);
        let v0 = 0x2::coin::into_balance<T1>(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in_direct<T3, T2, T1>(arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::from_balance<T2>(arg7, arg9), 1, arg9));
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T3>>(arg1), false, 0x2::balance::value<T1>(&v0));
        (v0, 0x2::balance::zero<T2>())
    }

    // decompiled from Move bytecode v7
}

