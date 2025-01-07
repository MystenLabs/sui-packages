module 0xc06ebb87c2753af79a5700778a7d8feabeaa88363cb45c576ec591437d52f201::aftermath {
    struct AftermathSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0xc06ebb87c2753af79a5700778a7d8feabeaa88363cb45c576ec591437d52f201::config::Config, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<T0>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T2, T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg9, arg7, arg8, arg10);
        let v1 = AftermathSwapEvent{
            pool         : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>>(arg1),
            amount_in    : 0x2::coin::value<T0>(&arg9),
            amount_out   : 0x2::coin::value<T1>(&v0),
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<AftermathSwapEvent>(v1);
        let (v2, _) = 0xc06ebb87c2753af79a5700778a7d8feabeaa88363cb45c576ec591437d52f201::config::pay_fee<T1>(arg0, v0, arg10);
        v2
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0xc06ebb87c2753af79a5700778a7d8feabeaa88363cb45c576ec591437d52f201::config::Config, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<T1>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T2, T1, T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg9, arg7, arg8, arg10);
        let v1 = AftermathSwapEvent{
            pool         : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>>(arg1),
            amount_in    : 0x2::coin::value<T1>(&arg9),
            amount_out   : 0x2::coin::value<T0>(&v0),
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<AftermathSwapEvent>(v1);
        let (v2, _) = 0xc06ebb87c2753af79a5700778a7d8feabeaa88363cb45c576ec591437d52f201::config::pay_fee<T0>(arg0, v0, arg10);
        v2
    }

    // decompiled from Move bytecode v6
}

