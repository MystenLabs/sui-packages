module 0x640d44dbdc0ede165c7cc417d7f57f1b09648083109de7132c6b3fb15861f5ee::aftermath {
    struct AftermathSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x2::coin::Coin<T0>, arg11: 0x2::coin::Coin<T1>, arg12: bool, arg13: bool, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, u64) {
        if (arg13) {
            let v0 = if (arg12) {
                0x2::coin::value<T0>(&arg10)
            } else {
                0x2::coin::value<T1>(&arg11)
            };
            arg6 = v0;
        };
        let v1 = if (arg12) {
            assert!(0x2::coin::value<T0>(&arg10) >= arg6, 1);
            let v2 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T2, T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::split<T0>(&mut arg10, arg6, arg14), arg8, arg9, arg14);
            assert!(0x2::coin::value<T1>(&v2) >= arg7, 0);
            let v3 = 0x2::coin::value<T1>(&v2);
            let v4 = AftermathSwapEvent{
                pool         : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>>(arg0),
                amount_in    : arg6,
                amount_out   : v3,
                a2b          : arg12,
                by_amount_in : true,
                coin_a       : 0x1::type_name::get<T0>(),
                coin_b       : 0x1::type_name::get<T1>(),
            };
            0x2::event::emit<AftermathSwapEvent>(v4);
            0x2::coin::join<T1>(&mut arg11, v2);
            v3
        } else {
            assert!(0x2::coin::value<T1>(&arg11) >= arg6, 1);
            let v5 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T2, T1, T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::split<T1>(&mut arg11, arg6, arg14), arg8, arg9, arg14);
            assert!(0x2::coin::value<T0>(&v5) >= arg7, 0);
            let v6 = 0x2::coin::value<T0>(&v5);
            let v7 = AftermathSwapEvent{
                pool         : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>>(arg0),
                amount_in    : arg6,
                amount_out   : v6,
                a2b          : arg12,
                by_amount_in : true,
                coin_a       : 0x1::type_name::get<T0>(),
                coin_b       : 0x1::type_name::get<T1>(),
            };
            0x2::event::emit<AftermathSwapEvent>(v7);
            0x2::coin::join<T0>(&mut arg10, v5);
            v6
        };
        (arg10, arg11, arg6, v1)
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x2::coin::Coin<T0>, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64, u64) {
        let v0 = 0x2::coin::zero<T1>(arg12);
        let (v1, v2, v3, v4) = swap<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v0, true, arg11, arg12);
        0x640d44dbdc0ede165c7cc417d7f57f1b09648083109de7132c6b3fb15861f5ee::utils::transfer_or_destroy_coin<T0>(v1, arg12);
        (v2, v3, v4)
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x2::coin::Coin<T1>, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, u64) {
        let v0 = 0x2::coin::zero<T0>(arg12);
        let (v1, v2, v3, v4) = swap<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v0, arg10, false, arg11, arg12);
        0x640d44dbdc0ede165c7cc417d7f57f1b09648083109de7132c6b3fb15861f5ee::utils::transfer_or_destroy_coin<T1>(v2, arg12);
        (v1, v3, v4)
    }

    // decompiled from Move bytecode v6
}

