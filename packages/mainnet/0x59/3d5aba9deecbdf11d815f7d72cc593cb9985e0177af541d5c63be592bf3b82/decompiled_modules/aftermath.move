module 0x593d5aba9deecbdf11d815f7d72cc593cb9985e0177af541d5c63be592bf3b82::aftermath {
    struct AftermathQuote has copy, drop, store {
        a2b_out: u64,
        b2a_out: u64,
    }

    public fun a2b<T0, T1, T2>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg0, arg7, 900000000000000000, arg8)
    }

    public fun b2a<T0, T1, T2>(arg0: 0x2::coin::Coin<T2>, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, T2, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg0, arg7, 900000000000000000, arg8)
    }

    public fun probe_aftermath<T0, T1, T2>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: u64, arg2: u64) : AftermathQuote {
        AftermathQuote{
            a2b_out : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_swap_exact_in<T0, T1, T2>(arg0, arg1, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_in_for<T0, T1>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_out_for<T0, T2>(arg0)),
            b2a_out : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_swap_exact_in<T0, T2, T1>(arg0, arg2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_in_for<T0, T2>(arg0), 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_out_for<T0, T1>(arg0)),
        }
    }

    // decompiled from Move bytecode v7
}

