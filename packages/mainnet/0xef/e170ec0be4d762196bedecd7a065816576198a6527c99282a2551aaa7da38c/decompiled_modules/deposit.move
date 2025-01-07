module 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::deposit {
    fun deposit<T0, T1>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T1>(arg0, 0x2::coin::split<T1>(arg1, arg2, arg3));
    }

    public fun all_coin_deposit_2_coins<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::coin::Coin<T2>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_protocol_version(arg1);
        assert_pool_size_is(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::size<T0>(arg0), 2);
        assert_non_zero(0x2::coin::value<T1>(arg6));
        assert_non_zero(0x2::coin::value<T2>(arg7));
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::protocol_fees::collect_fees_2_coins<T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, v0, arg8);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(arg6));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(arg7));
        let (v5, v6) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_all_coin_deposit<T0>(arg0, &v1, &v3);
        let v7 = v6;
        deposit<T0, T1>(arg0, arg6, *0x1::vector::borrow<u64>(&v7, 0), arg8);
        deposit<T0, T2>(arg0, arg7, *0x1::vector::borrow<u64>(&v7, 1), arg8);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_deposit_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v1, v7, v5);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::mint_lp_coins<T0>(arg0, v5, arg8)
    }

    public fun all_coin_deposit_3_coins<T0, T1, T2, T3>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::coin::Coin<T2>, arg8: &mut 0x2::coin::Coin<T3>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_protocol_version(arg1);
        assert_pool_size_is(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::size<T0>(arg0), 3);
        assert_non_zero(0x2::coin::value<T1>(arg6));
        assert_non_zero(0x2::coin::value<T2>(arg7));
        assert_non_zero(0x2::coin::value<T3>(arg8));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T3>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::protocol_fees::collect_fees_3_coins<T1, T2, T3>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, v0, arg9);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(arg6));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(arg7));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(arg8));
        let (v5, v6) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_all_coin_deposit<T0>(arg0, &v1, &v3);
        let v7 = v6;
        deposit<T0, T1>(arg0, arg6, *0x1::vector::borrow<u64>(&v7, 0), arg9);
        deposit<T0, T2>(arg0, arg7, *0x1::vector::borrow<u64>(&v7, 1), arg9);
        deposit<T0, T3>(arg0, arg8, *0x1::vector::borrow<u64>(&v7, 2), arg9);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_deposit_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v1, v7, v5);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::mint_lp_coins<T0>(arg0, v5, arg9)
    }

    public fun all_coin_deposit_4_coins<T0, T1, T2, T3, T4>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::coin::Coin<T2>, arg8: &mut 0x2::coin::Coin<T3>, arg9: &mut 0x2::coin::Coin<T4>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_protocol_version(arg1);
        assert_pool_size_is(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::size<T0>(arg0), 4);
        assert_non_zero(0x2::coin::value<T1>(arg6));
        assert_non_zero(0x2::coin::value<T2>(arg7));
        assert_non_zero(0x2::coin::value<T3>(arg8));
        assert_non_zero(0x2::coin::value<T4>(arg9));
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T4>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::protocol_fees::collect_fees_4_coins<T1, T2, T3, T4>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v0, arg10);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(arg6));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(arg7));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(arg8));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T4>(arg9));
        let (v5, v6) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_all_coin_deposit<T0>(arg0, &v1, &v3);
        let v7 = v6;
        deposit<T0, T1>(arg0, arg6, *0x1::vector::borrow<u64>(&v7, 0), arg10);
        deposit<T0, T2>(arg0, arg7, *0x1::vector::borrow<u64>(&v7, 1), arg10);
        deposit<T0, T3>(arg0, arg8, *0x1::vector::borrow<u64>(&v7, 2), arg10);
        deposit<T0, T4>(arg0, arg9, *0x1::vector::borrow<u64>(&v7, 3), arg10);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_deposit_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v1, v7, v5);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::mint_lp_coins<T0>(arg0, v5, arg10)
    }

    public fun all_coin_deposit_5_coins<T0, T1, T2, T3, T4, T5>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::coin::Coin<T2>, arg8: &mut 0x2::coin::Coin<T3>, arg9: &mut 0x2::coin::Coin<T4>, arg10: &mut 0x2::coin::Coin<T5>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_protocol_version(arg1);
        assert_pool_size_is(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::size<T0>(arg0), 5);
        assert_non_zero(0x2::coin::value<T1>(arg6));
        assert_non_zero(0x2::coin::value<T2>(arg7));
        assert_non_zero(0x2::coin::value<T3>(arg8));
        assert_non_zero(0x2::coin::value<T4>(arg9));
        assert_non_zero(0x2::coin::value<T5>(arg10));
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T5>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::protocol_fees::collect_fees_5_coins<T1, T2, T3, T4, T5>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v0, arg11);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(arg6));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(arg7));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(arg8));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T4>(arg9));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T5>(arg10));
        let (v5, v6) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_all_coin_deposit<T0>(arg0, &v1, &v3);
        let v7 = v6;
        deposit<T0, T1>(arg0, arg6, *0x1::vector::borrow<u64>(&v7, 0), arg11);
        deposit<T0, T2>(arg0, arg7, *0x1::vector::borrow<u64>(&v7, 1), arg11);
        deposit<T0, T3>(arg0, arg8, *0x1::vector::borrow<u64>(&v7, 2), arg11);
        deposit<T0, T4>(arg0, arg9, *0x1::vector::borrow<u64>(&v7, 3), arg11);
        deposit<T0, T5>(arg0, arg10, *0x1::vector::borrow<u64>(&v7, 4), arg11);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_deposit_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v1, v7, v5);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::mint_lp_coins<T0>(arg0, v5, arg11)
    }

    public fun all_coin_deposit_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::coin::Coin<T2>, arg8: &mut 0x2::coin::Coin<T3>, arg9: &mut 0x2::coin::Coin<T4>, arg10: &mut 0x2::coin::Coin<T5>, arg11: &mut 0x2::coin::Coin<T6>, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_protocol_version(arg1);
        assert_pool_size_is(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::size<T0>(arg0), 6);
        assert_non_zero(0x2::coin::value<T1>(arg6));
        assert_non_zero(0x2::coin::value<T2>(arg7));
        assert_non_zero(0x2::coin::value<T3>(arg8));
        assert_non_zero(0x2::coin::value<T4>(arg9));
        assert_non_zero(0x2::coin::value<T5>(arg10));
        assert_non_zero(0x2::coin::value<T6>(arg11));
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T6>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::protocol_fees::collect_fees_6_coins<T1, T2, T3, T4, T5, T6>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v0, arg12);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(arg6));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(arg7));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(arg8));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T4>(arg9));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T5>(arg10));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T6>(arg11));
        let (v5, v6) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_all_coin_deposit<T0>(arg0, &v1, &v3);
        let v7 = v6;
        deposit<T0, T1>(arg0, arg6, *0x1::vector::borrow<u64>(&v7, 0), arg12);
        deposit<T0, T2>(arg0, arg7, *0x1::vector::borrow<u64>(&v7, 1), arg12);
        deposit<T0, T3>(arg0, arg8, *0x1::vector::borrow<u64>(&v7, 2), arg12);
        deposit<T0, T4>(arg0, arg9, *0x1::vector::borrow<u64>(&v7, 3), arg12);
        deposit<T0, T5>(arg0, arg10, *0x1::vector::borrow<u64>(&v7, 4), arg12);
        deposit<T0, T6>(arg0, arg11, *0x1::vector::borrow<u64>(&v7, 5), arg12);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_deposit_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v1, v7, v5);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::mint_lp_coins<T0>(arg0, v5, arg12)
    }

    public fun all_coin_deposit_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::coin::Coin<T2>, arg8: &mut 0x2::coin::Coin<T3>, arg9: &mut 0x2::coin::Coin<T4>, arg10: &mut 0x2::coin::Coin<T5>, arg11: &mut 0x2::coin::Coin<T6>, arg12: &mut 0x2::coin::Coin<T7>, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_protocol_version(arg1);
        assert_pool_size_is(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::size<T0>(arg0), 7);
        assert_non_zero(0x2::coin::value<T1>(arg6));
        assert_non_zero(0x2::coin::value<T2>(arg7));
        assert_non_zero(0x2::coin::value<T3>(arg8));
        assert_non_zero(0x2::coin::value<T4>(arg9));
        assert_non_zero(0x2::coin::value<T5>(arg10));
        assert_non_zero(0x2::coin::value<T6>(arg11));
        assert_non_zero(0x2::coin::value<T7>(arg12));
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T6>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T7>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::protocol_fees::collect_fees_7_coins<T1, T2, T3, T4, T5, T6, T7>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v0, arg13);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(arg6));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(arg7));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(arg8));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T4>(arg9));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T5>(arg10));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T6>(arg11));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T7>(arg12));
        let (v5, v6) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_all_coin_deposit<T0>(arg0, &v1, &v3);
        let v7 = v6;
        deposit<T0, T1>(arg0, arg6, *0x1::vector::borrow<u64>(&v7, 0), arg13);
        deposit<T0, T2>(arg0, arg7, *0x1::vector::borrow<u64>(&v7, 1), arg13);
        deposit<T0, T3>(arg0, arg8, *0x1::vector::borrow<u64>(&v7, 2), arg13);
        deposit<T0, T4>(arg0, arg9, *0x1::vector::borrow<u64>(&v7, 3), arg13);
        deposit<T0, T5>(arg0, arg10, *0x1::vector::borrow<u64>(&v7, 4), arg13);
        deposit<T0, T6>(arg0, arg11, *0x1::vector::borrow<u64>(&v7, 5), arg13);
        deposit<T0, T7>(arg0, arg12, *0x1::vector::borrow<u64>(&v7, 6), arg13);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_deposit_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v1, v7, v5);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::mint_lp_coins<T0>(arg0, v5, arg13)
    }

    public fun all_coin_deposit_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::coin::Coin<T2>, arg8: &mut 0x2::coin::Coin<T3>, arg9: &mut 0x2::coin::Coin<T4>, arg10: &mut 0x2::coin::Coin<T5>, arg11: &mut 0x2::coin::Coin<T6>, arg12: &mut 0x2::coin::Coin<T7>, arg13: &mut 0x2::coin::Coin<T8>, arg14: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_protocol_version(arg1);
        assert_pool_size_is(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::size<T0>(arg0), 8);
        assert_non_zero(0x2::coin::value<T1>(arg6));
        assert_non_zero(0x2::coin::value<T2>(arg7));
        assert_non_zero(0x2::coin::value<T3>(arg8));
        assert_non_zero(0x2::coin::value<T4>(arg9));
        assert_non_zero(0x2::coin::value<T5>(arg10));
        assert_non_zero(0x2::coin::value<T6>(arg11));
        assert_non_zero(0x2::coin::value<T7>(arg12));
        assert_non_zero(0x2::coin::value<T8>(arg13));
        let v0 = 0x2::tx_context::sender(arg14);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T6>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T7>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T8>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::protocol_fees::collect_fees_8_coins<T1, T2, T3, T4, T5, T6, T7, T8>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v0, arg14);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(arg6));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(arg7));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(arg8));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T4>(arg9));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T5>(arg10));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T6>(arg11));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T7>(arg12));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T8>(arg13));
        let (v5, v6) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_all_coin_deposit<T0>(arg0, &v1, &v3);
        let v7 = v6;
        deposit<T0, T1>(arg0, arg6, *0x1::vector::borrow<u64>(&v7, 0), arg14);
        deposit<T0, T2>(arg0, arg7, *0x1::vector::borrow<u64>(&v7, 1), arg14);
        deposit<T0, T3>(arg0, arg8, *0x1::vector::borrow<u64>(&v7, 2), arg14);
        deposit<T0, T4>(arg0, arg9, *0x1::vector::borrow<u64>(&v7, 3), arg14);
        deposit<T0, T5>(arg0, arg10, *0x1::vector::borrow<u64>(&v7, 4), arg14);
        deposit<T0, T6>(arg0, arg11, *0x1::vector::borrow<u64>(&v7, 5), arg14);
        deposit<T0, T7>(arg0, arg12, *0x1::vector::borrow<u64>(&v7, 6), arg14);
        deposit<T0, T8>(arg0, arg13, *0x1::vector::borrow<u64>(&v7, 7), arg14);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_deposit_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v1, v7, v5);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::mint_lp_coins<T0>(arg0, v5, arg14)
    }

    fun assert_no_duplicates<T0>(arg0: &vector<T0>) {
        let v0 = 0x1::vector::length<T0>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<T0>(arg0, v1);
            let v3 = v1 + 1;
            while (v3 < v0) {
                assert!(v2 != 0x1::vector::borrow<T0>(arg0, v3), 23);
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
    }

    fun assert_non_zero(arg0: u64) {
        assert!(arg0 > 0, 22);
    }

    fun assert_pool_size_is(arg0: u64, arg1: u64) {
        assert!(arg0 == arg1, 21);
    }

    fun assert_pool_size_is_at_least(arg0: u64, arg1: u64) {
        assert!(arg1 <= arg0, 21);
    }

    fun assert_protocol_version(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry) {
        assert!(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::protocol_version(arg0) == 1, 20);
    }

    public fun deposit_1_coins<T0, T1>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: u128, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_protocol_version(arg1);
        assert_non_zero(0x2::coin::value<T1>(&arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut arg6, v0, arg9);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v1, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>());
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, 0x2::coin::value<T1>(&arg6));
        let v3 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_deposit_exact_in<T0>(arg0, &v1, &v2, arg7, arg8);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T1>(arg0, arg6);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_deposit_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v1, v2, v3);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::mint_lp_coins<T0>(arg0, v3, arg9)
    }

    public fun deposit_2_coins<T0, T1, T2>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: u128, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_protocol_version(arg1);
        assert_non_zero(0x2::coin::value<T1>(&arg6));
        assert_non_zero(0x2::coin::value<T2>(&arg7));
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::protocol_fees::collect_fees_2_coins<T1, T2>(arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, v0, arg10);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(&arg6));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(&arg7));
        let v5 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_deposit_exact_in<T0>(arg0, &v1, &v3, arg8, arg9);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T1>(arg0, arg6);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T2>(arg0, arg7);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_deposit_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v1, v3, v5);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::mint_lp_coins<T0>(arg0, v5, arg10)
    }

    public fun deposit_3_coins<T0, T1, T2, T3>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: u128, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_protocol_version(arg1);
        assert_pool_size_is_at_least(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::size<T0>(arg0), 3);
        assert_non_zero(0x2::coin::value<T1>(&arg6));
        assert_non_zero(0x2::coin::value<T2>(&arg7));
        assert_non_zero(0x2::coin::value<T3>(&arg8));
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T3>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::protocol_fees::collect_fees_3_coins<T1, T2, T3>(arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, v0, arg11);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(&arg6));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(&arg7));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(&arg8));
        let v5 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_deposit_exact_in<T0>(arg0, &v1, &v3, arg9, arg10);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T1>(arg0, arg6);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T2>(arg0, arg7);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T3>(arg0, arg8);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_deposit_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v1, v3, v5);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::mint_lp_coins<T0>(arg0, v5, arg11)
    }

    public fun deposit_4_coins<T0, T1, T2, T3, T4>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_protocol_version(arg1);
        assert_pool_size_is_at_least(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::size<T0>(arg0), 4);
        assert_non_zero(0x2::coin::value<T1>(&arg6));
        assert_non_zero(0x2::coin::value<T2>(&arg7));
        assert_non_zero(0x2::coin::value<T3>(&arg8));
        assert_non_zero(0x2::coin::value<T4>(&arg9));
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T4>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::protocol_fees::collect_fees_4_coins<T1, T2, T3, T4>(arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, &mut arg9, v0, arg12);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(&arg6));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(&arg7));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(&arg8));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T4>(&arg9));
        let v5 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_deposit_exact_in<T0>(arg0, &v1, &v3, arg10, arg11);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T1>(arg0, arg6);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T2>(arg0, arg7);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T3>(arg0, arg8);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T4>(arg0, arg9);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_deposit_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v1, v3, v5);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::mint_lp_coins<T0>(arg0, v5, arg12)
    }

    public fun deposit_5_coins<T0, T1, T2, T3, T4, T5>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: u128, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_protocol_version(arg1);
        assert_pool_size_is_at_least(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::size<T0>(arg0), 5);
        assert_non_zero(0x2::coin::value<T1>(&arg6));
        assert_non_zero(0x2::coin::value<T2>(&arg7));
        assert_non_zero(0x2::coin::value<T3>(&arg8));
        assert_non_zero(0x2::coin::value<T4>(&arg9));
        assert_non_zero(0x2::coin::value<T5>(&arg10));
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T5>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::protocol_fees::collect_fees_5_coins<T1, T2, T3, T4, T5>(arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, &mut arg9, &mut arg10, v0, arg13);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(&arg6));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(&arg7));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(&arg8));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T4>(&arg9));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T5>(&arg10));
        let v5 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_deposit_exact_in<T0>(arg0, &v1, &v3, arg11, arg12);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T1>(arg0, arg6);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T2>(arg0, arg7);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T3>(arg0, arg8);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T4>(arg0, arg9);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T5>(arg0, arg10);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_deposit_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v1, v3, v5);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::mint_lp_coins<T0>(arg0, v5, arg13)
    }

    public fun deposit_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: 0x2::coin::Coin<T6>, arg12: u128, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_protocol_version(arg1);
        assert_pool_size_is_at_least(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::size<T0>(arg0), 6);
        assert_non_zero(0x2::coin::value<T1>(&arg6));
        assert_non_zero(0x2::coin::value<T2>(&arg7));
        assert_non_zero(0x2::coin::value<T3>(&arg8));
        assert_non_zero(0x2::coin::value<T4>(&arg9));
        assert_non_zero(0x2::coin::value<T5>(&arg10));
        assert_non_zero(0x2::coin::value<T6>(&arg11));
        let v0 = 0x2::tx_context::sender(arg14);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T6>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::protocol_fees::collect_fees_6_coins<T1, T2, T3, T4, T5, T6>(arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, &mut arg9, &mut arg10, &mut arg11, v0, arg14);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(&arg6));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(&arg7));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(&arg8));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T4>(&arg9));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T5>(&arg10));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T6>(&arg11));
        let v5 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_deposit_exact_in<T0>(arg0, &v1, &v3, arg12, arg13);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T1>(arg0, arg6);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T2>(arg0, arg7);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T3>(arg0, arg8);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T4>(arg0, arg9);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T5>(arg0, arg10);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T6>(arg0, arg11);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_deposit_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v1, v3, v5);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::mint_lp_coins<T0>(arg0, v5, arg14)
    }

    public fun deposit_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: 0x2::coin::Coin<T6>, arg12: 0x2::coin::Coin<T7>, arg13: u128, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_protocol_version(arg1);
        assert_pool_size_is_at_least(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::size<T0>(arg0), 7);
        assert_non_zero(0x2::coin::value<T1>(&arg6));
        assert_non_zero(0x2::coin::value<T2>(&arg7));
        assert_non_zero(0x2::coin::value<T3>(&arg8));
        assert_non_zero(0x2::coin::value<T4>(&arg9));
        assert_non_zero(0x2::coin::value<T5>(&arg10));
        assert_non_zero(0x2::coin::value<T6>(&arg11));
        assert_non_zero(0x2::coin::value<T7>(&arg12));
        let v0 = 0x2::tx_context::sender(arg15);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T6>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T7>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::protocol_fees::collect_fees_7_coins<T1, T2, T3, T4, T5, T6, T7>(arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, &mut arg9, &mut arg10, &mut arg11, &mut arg12, v0, arg15);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(&arg6));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(&arg7));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(&arg8));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T4>(&arg9));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T5>(&arg10));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T6>(&arg11));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T7>(&arg12));
        let v5 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_deposit_exact_in<T0>(arg0, &v1, &v3, arg13, arg14);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T1>(arg0, arg6);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T2>(arg0, arg7);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T3>(arg0, arg8);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T4>(arg0, arg9);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T5>(arg0, arg10);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T6>(arg0, arg11);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T7>(arg0, arg12);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_deposit_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v1, v3, v5);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::mint_lp_coins<T0>(arg0, v5, arg15)
    }

    public fun deposit_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T4>, arg10: 0x2::coin::Coin<T5>, arg11: 0x2::coin::Coin<T6>, arg12: 0x2::coin::Coin<T7>, arg13: 0x2::coin::Coin<T8>, arg14: u128, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_protocol_version(arg1);
        assert_pool_size_is_at_least(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::size<T0>(arg0), 8);
        assert_non_zero(0x2::coin::value<T1>(&arg6));
        assert_non_zero(0x2::coin::value<T2>(&arg7));
        assert_non_zero(0x2::coin::value<T3>(&arg8));
        assert_non_zero(0x2::coin::value<T4>(&arg9));
        assert_non_zero(0x2::coin::value<T5>(&arg10));
        assert_non_zero(0x2::coin::value<T6>(&arg11));
        assert_non_zero(0x2::coin::value<T7>(&arg12));
        assert_non_zero(0x2::coin::value<T8>(&arg13));
        let v0 = 0x2::tx_context::sender(arg16);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T6>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T7>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T8>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::protocol_fees::collect_fees_8_coins<T1, T2, T3, T4, T5, T6, T7, T8>(arg2, arg3, arg4, arg5, &mut arg6, &mut arg7, &mut arg8, &mut arg9, &mut arg10, &mut arg11, &mut arg12, &mut arg13, v0, arg16);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(&arg6));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(&arg7));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(&arg8));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T4>(&arg9));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T5>(&arg10));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T6>(&arg11));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T7>(&arg12));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T8>(&arg13));
        let v5 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_deposit_exact_in<T0>(arg0, &v1, &v3, arg14, arg15);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T1>(arg0, arg6);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T2>(arg0, arg7);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T3>(arg0, arg8);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T4>(arg0, arg9);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T5>(arg0, arg10);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T6>(arg0, arg11);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T7>(arg0, arg12);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::join<T0, T8>(arg0, arg13);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events::emit_deposit_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v1, v3, v5);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::mint_lp_coins<T0>(arg0, v5, arg16)
    }

    // decompiled from Move bytecode v6
}

