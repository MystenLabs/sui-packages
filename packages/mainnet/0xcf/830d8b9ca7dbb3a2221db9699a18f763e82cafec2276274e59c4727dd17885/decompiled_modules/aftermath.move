module 0xcf830d8b9ca7dbb3a2221db9699a18f763e82cafec2276274e59c4727dd17885::aftermath {
    struct HopRecord has copy, drop {
        out_amount: u64,
    }

    public fun aftermath_swap_bal<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::balance::Balance<T1>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        assert!(arg7 > 0, 1);
        let v0 = 0x2::coin::into_balance<T2>(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::from_balance<T1>(arg6, arg8), arg7, 1000000000000000000, arg8));
        let v1 = HopRecord{out_amount: 0x2::balance::value<T2>(&v0)};
        0x2::event::emit<HopRecord>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

