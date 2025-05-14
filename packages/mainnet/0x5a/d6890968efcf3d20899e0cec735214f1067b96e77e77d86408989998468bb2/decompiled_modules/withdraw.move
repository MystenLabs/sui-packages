module 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::withdraw {
    public fun all_coin_withdraw_2_coins<T0, T1, T2>(arg0: &mut 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::assert_interacting_with_most_up_to_date_package(arg1);
        let (v0, v1) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::withdraw::all_coin_withdraw_2_coins<T0, T1, T2>(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::borrow_mut_pool<T0>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T1>(arg0, &mut v3, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T2>(arg0, &mut v2, arg8);
        (v3, v2)
    }

    public fun all_coin_withdraw_3_coins<T0, T1, T2, T3>(arg0: &mut 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>) {
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::assert_interacting_with_most_up_to_date_package(arg1);
        let (v0, v1, v2) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::withdraw::all_coin_withdraw_3_coins<T0, T1, T2, T3>(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::borrow_mut_pool<T0>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T1>(arg0, &mut v5, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T2>(arg0, &mut v4, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T3>(arg0, &mut v3, arg8);
        (v5, v4, v3)
    }

    public fun all_coin_withdraw_4_coins<T0, T1, T2, T3, T4>(arg0: &mut 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>) {
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::assert_interacting_with_most_up_to_date_package(arg1);
        let (v0, v1, v2, v3) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::withdraw::all_coin_withdraw_4_coins<T0, T1, T2, T3, T4>(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::borrow_mut_pool<T0>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = v0;
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T1>(arg0, &mut v7, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T2>(arg0, &mut v6, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T3>(arg0, &mut v5, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T4>(arg0, &mut v4, arg8);
        (v7, v6, v5, v4)
    }

    public fun all_coin_withdraw_5_coins<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>) {
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::assert_interacting_with_most_up_to_date_package(arg1);
        let (v0, v1, v2, v3, v4) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::withdraw::all_coin_withdraw_5_coins<T0, T1, T2, T3, T4, T5>(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::borrow_mut_pool<T0>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = v0;
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T1>(arg0, &mut v9, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T2>(arg0, &mut v8, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T3>(arg0, &mut v7, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T4>(arg0, &mut v6, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T5>(arg0, &mut v5, arg8);
        (v9, v8, v7, v6, v5)
    }

    public fun all_coin_withdraw_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>) {
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::assert_interacting_with_most_up_to_date_package(arg1);
        let (v0, v1, v2, v3, v4, v5) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::withdraw::all_coin_withdraw_6_coins<T0, T1, T2, T3, T4, T5, T6>(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::borrow_mut_pool<T0>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        let v10 = v1;
        let v11 = v0;
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T1>(arg0, &mut v11, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T2>(arg0, &mut v10, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T3>(arg0, &mut v9, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T4>(arg0, &mut v8, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T5>(arg0, &mut v7, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T6>(arg0, &mut v6, arg8);
        (v11, v10, v9, v8, v7, v6)
    }

    public fun all_coin_withdraw_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &mut 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>, 0x2::coin::Coin<T7>) {
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::assert_interacting_with_most_up_to_date_package(arg1);
        let (v0, v1, v2, v3, v4, v5, v6) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::withdraw::all_coin_withdraw_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::borrow_mut_pool<T0>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        let v10 = v3;
        let v11 = v2;
        let v12 = v1;
        let v13 = v0;
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T1>(arg0, &mut v13, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T2>(arg0, &mut v12, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T3>(arg0, &mut v11, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T4>(arg0, &mut v10, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T5>(arg0, &mut v9, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T6>(arg0, &mut v8, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T7>(arg0, &mut v7, arg8);
        (v13, v12, v11, v10, v9, v8, v7)
    }

    public fun all_coin_withdraw_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>, 0x2::coin::Coin<T7>, 0x2::coin::Coin<T8>) {
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::assert_interacting_with_most_up_to_date_package(arg1);
        let (v0, v1, v2, v3, v4, v5, v6, v7) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::withdraw::all_coin_withdraw_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::borrow_mut_pool<T0>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = v3;
        let v13 = v2;
        let v14 = v1;
        let v15 = v0;
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T1>(arg0, &mut v15, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T2>(arg0, &mut v14, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T3>(arg0, &mut v13, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T4>(arg0, &mut v12, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T5>(arg0, &mut v11, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T6>(arg0, &mut v10, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T7>(arg0, &mut v9, arg8);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T8>(arg0, &mut v8, arg8);
        (v15, v14, v13, v12, v11, v10, v9, v8)
    }

    public fun withdraw_1_coin_direct<T0, T1>(arg0: &mut 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::assert_interacting_with_most_up_to_date_package(arg1);
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::withdraw::withdraw_1_coin_direct<T0, T1>(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::borrow_mut_pool<T0>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T1>(arg0, &mut v0, arg9);
        v0
    }

    public fun withdraw_2_coins_direct<T0, T1, T2>(arg0: &mut 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T0>, arg8: vector<u64>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::assert_interacting_with_most_up_to_date_package(arg1);
        let (v0, v1) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::withdraw::withdraw_2_coins_direct<T0, T1, T2>(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::borrow_mut_pool<T0>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v2 = v1;
        let v3 = v0;
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T1>(arg0, &mut v3, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T2>(arg0, &mut v2, arg10);
        (v3, v2)
    }

    public fun withdraw_3_coins_direct<T0, T1, T2, T3>(arg0: &mut 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T0>, arg8: vector<u64>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>) {
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::assert_interacting_with_most_up_to_date_package(arg1);
        let (v0, v1, v2) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::withdraw::withdraw_3_coins_direct<T0, T1, T2, T3>(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::borrow_mut_pool<T0>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T1>(arg0, &mut v5, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T2>(arg0, &mut v4, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T3>(arg0, &mut v3, arg10);
        (v5, v4, v3)
    }

    public fun withdraw_4_coins_direct<T0, T1, T2, T3, T4>(arg0: &mut 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T0>, arg8: vector<u64>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>) {
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::assert_interacting_with_most_up_to_date_package(arg1);
        let (v0, v1, v2, v3) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::withdraw::withdraw_4_coins_direct<T0, T1, T2, T3, T4>(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::borrow_mut_pool<T0>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = v0;
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T1>(arg0, &mut v7, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T2>(arg0, &mut v6, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T3>(arg0, &mut v5, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T4>(arg0, &mut v4, arg10);
        (v7, v6, v5, v4)
    }

    public fun withdraw_5_coins_direct<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T0>, arg8: vector<u64>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>) {
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::assert_interacting_with_most_up_to_date_package(arg1);
        let (v0, v1, v2, v3, v4) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::withdraw::withdraw_5_coins_direct<T0, T1, T2, T3, T4, T5>(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::borrow_mut_pool<T0>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = v0;
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T1>(arg0, &mut v9, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T2>(arg0, &mut v8, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T3>(arg0, &mut v7, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T4>(arg0, &mut v6, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T5>(arg0, &mut v5, arg10);
        (v9, v8, v7, v6, v5)
    }

    public fun withdraw_6_coins_direct<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T0>, arg8: vector<u64>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>) {
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::assert_interacting_with_most_up_to_date_package(arg1);
        let (v0, v1, v2, v3, v4, v5) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::withdraw::withdraw_6_coins_direct<T0, T1, T2, T3, T4, T5, T6>(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::borrow_mut_pool<T0>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        let v10 = v1;
        let v11 = v0;
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T1>(arg0, &mut v11, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T2>(arg0, &mut v10, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T3>(arg0, &mut v9, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T4>(arg0, &mut v8, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T5>(arg0, &mut v7, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T6>(arg0, &mut v6, arg10);
        (v11, v10, v9, v8, v7, v6)
    }

    public fun withdraw_7_coins_direct<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &mut 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T0>, arg8: vector<u64>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>, 0x2::coin::Coin<T7>) {
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::assert_interacting_with_most_up_to_date_package(arg1);
        let (v0, v1, v2, v3, v4, v5, v6) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::withdraw::withdraw_7_coins_direct<T0, T1, T2, T3, T4, T5, T6, T7>(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::borrow_mut_pool<T0>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        let v10 = v3;
        let v11 = v2;
        let v12 = v1;
        let v13 = v0;
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T1>(arg0, &mut v13, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T2>(arg0, &mut v12, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T3>(arg0, &mut v11, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T4>(arg0, &mut v10, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T5>(arg0, &mut v9, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T6>(arg0, &mut v8, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T7>(arg0, &mut v7, arg10);
        (v13, v12, v11, v10, v9, v8, v7)
    }

    public fun withdraw_8_coins_direct<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut 0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::DaoFeePool<T0>, arg1: &0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::Version, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg3: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: 0x2::coin::Coin<T0>, arg8: vector<u64>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>, 0x2::coin::Coin<T7>, 0x2::coin::Coin<T8>) {
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::version::assert_interacting_with_most_up_to_date_package(arg1);
        let (v0, v1, v2, v3, v4, v5, v6, v7) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::withdraw::withdraw_8_coins_direct<T0, T1, T2, T3, T4, T5, T6, T7, T8>(0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::borrow_mut_pool<T0>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = v3;
        let v13 = v2;
        let v14 = v1;
        let v15 = v0;
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T1>(arg0, &mut v15, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T2>(arg0, &mut v14, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T3>(arg0, &mut v13, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T4>(arg0, &mut v12, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T5>(arg0, &mut v11, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T6>(arg0, &mut v10, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T7>(arg0, &mut v9, arg10);
        0x6f60a091637054e23915b8745c0c0d47b1d49618ee3435b5f68eccf6a44fb53d::pool::collect_dao_fee<T0, T8>(arg0, &mut v8, arg10);
        (v15, v14, v13, v12, v11, v10, v9, v8)
    }

    // decompiled from Move bytecode v6
}

