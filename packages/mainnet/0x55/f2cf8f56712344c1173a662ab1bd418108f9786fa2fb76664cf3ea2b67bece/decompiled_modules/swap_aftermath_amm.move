module 0x55f2cf8f56712344c1173a662ab1bd418108f9786fa2fb76664cf3ea2b67bece::swap_aftermath_amm {
    public fun swap_a2b<T0, T1, T2, T3, T4>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<T0>, arg9: &0x55f2cf8f56712344c1173a662ab1bd418108f9786fa2fb76664cf3ea2b67bece::swap_transaction::SwapTransaction<T3, T4>, arg10: &0x55f2cf8f56712344c1173a662ab1bd418108f9786fa2fb76664cf3ea2b67bece::state::State, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T2, T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg8, arg6, arg7, arg11);
        let v1 = 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>>(arg0);
        0x55f2cf8f56712344c1173a662ab1bd418108f9786fa2fb76664cf3ea2b67bece::swap_event::emit_common_swap<T0, T1>(0x55f2cf8f56712344c1173a662ab1bd418108f9786fa2fb76664cf3ea2b67bece::consts::DEX_AFLTERMATH_AMM(), 0x2::object::id_to_address(&v1), true, 0x2::coin::value<T0>(&arg8), 0x2::coin::value<T1>(&v0), true);
        v0
    }

    public fun swap_b2a<T0, T1, T2, T3, T4>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<T1>, arg9: &0x55f2cf8f56712344c1173a662ab1bd418108f9786fa2fb76664cf3ea2b67bece::swap_transaction::SwapTransaction<T3, T4>, arg10: &0x55f2cf8f56712344c1173a662ab1bd418108f9786fa2fb76664cf3ea2b67bece::state::State, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T2, T1, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8, arg6, arg7, arg11);
        let v1 = 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>>(arg0);
        0x55f2cf8f56712344c1173a662ab1bd418108f9786fa2fb76664cf3ea2b67bece::swap_event::emit_common_swap<T0, T1>(0x55f2cf8f56712344c1173a662ab1bd418108f9786fa2fb76664cf3ea2b67bece::consts::DEX_AFLTERMATH_AMM(), 0x2::object::id_to_address(&v1), false, 0x2::coin::value<T1>(&arg8), 0x2::coin::value<T0>(&v0), true);
        v0
    }

    // decompiled from Move bytecode v6
}

