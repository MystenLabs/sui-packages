module 0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::swap {
    public fun swap_exact_in<T0, T1, T2>(arg0: &mut 0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::pool::DaoFeePool<T0>, arg1: &0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::version::assert_interacting_with_most_up_to_date_package(arg1);
        0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::pool::collect_dao_fee<T0, T1>(arg0, &mut arg7, arg10);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_in<T0, T1, T2>(0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::pool::borrow_mut_pool<T0>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun swap_exact_out<T0, T1, T2>(arg0: &mut 0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::pool::DaoFeePool<T0>, arg1: &0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: u64, arg8: &mut 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::version::assert_interacting_with_most_up_to_date_package(arg1);
        0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::pool::collect_dao_fee<T0, T1>(arg0, arg8, arg11);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::swap::swap_exact_out<T0, T1, T2>(0x49f13e910e0f604d5df7c5123259352c11edcbdb26a0855b5c8c03831095bf03::pool::borrow_mut_pool<T0>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    // decompiled from Move bytecode v6
}

