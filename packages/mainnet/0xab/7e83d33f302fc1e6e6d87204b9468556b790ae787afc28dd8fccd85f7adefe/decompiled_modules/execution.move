module 0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::execution {
    public fun maybe_x_to_y<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x1::option::Option<0x2::coin::Coin<T1>>, arg7: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T2>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg6)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg6);
            return 0x1::option::none<0x2::coin::Coin<T2>>()
        };
        0x1::option::some<0x2::coin::Coin<T2>>(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in_direct<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg6), 0, arg7))
    }

    public fun maybe_y_to_x<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x1::option::Option<0x2::coin::Coin<T2>>, arg7: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T2>>(&arg6)) {
            0x1::option::destroy_none<0x2::coin::Coin<T2>>(arg6);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        0x1::option::some<0x2::coin::Coin<T1>>(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in_direct<T0, T2, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::destroy_some<0x2::coin::Coin<T2>>(arg6), 0, arg7))
    }

    // decompiled from Move bytecode v7
}

