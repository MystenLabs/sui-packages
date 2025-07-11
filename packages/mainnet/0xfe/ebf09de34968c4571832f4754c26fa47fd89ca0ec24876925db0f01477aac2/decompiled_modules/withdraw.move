module 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::withdraw {
    fun withdraw<T0, T1>(arg0: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &vector<u64>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T1>(arg0, *0x1::vector::borrow<u64>(arg1, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::type_to_index<T0, T1>(arg0)), arg2)
    }

    public fun all_coin_withdraw_2_coins<T0, T1, T2>(arg0: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert_protocol_version(arg1);
        assert_pool_size_is(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::size<T0>(arg0), 2);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T2>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x2::coin::value<T0>(&arg6);
        let v4 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::math::calc_all_coin_withdraw<T0>(arg0, v3);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = withdraw<T0, T1>(arg0, &v4, arg7);
        let v6 = withdraw<T0, T2>(arg0, &v4, arg7);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::protocol_fees::collect_fees_2_coins<T1, T2>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, v0, arg7);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::events::emit_withdraw_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::type_names<T0>(arg0), v4, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::balances<T0>(arg0), v3);
        (v5, v6)
    }

    public fun all_coin_withdraw_3_coins<T0, T1, T2, T3>(arg0: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>) {
        assert_protocol_version(arg1);
        assert_pool_size_is(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::size<T0>(arg0), 3);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T3>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x2::coin::value<T0>(&arg6);
        let v4 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::math::calc_all_coin_withdraw<T0>(arg0, v3);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = withdraw<T0, T1>(arg0, &v4, arg7);
        let v6 = withdraw<T0, T2>(arg0, &v4, arg7);
        let v7 = withdraw<T0, T3>(arg0, &v4, arg7);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::protocol_fees::collect_fees_3_coins<T1, T2, T3>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, v0, arg7);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::events::emit_withdraw_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::type_names<T0>(arg0), v4, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::balances<T0>(arg0), v3);
        (v5, v6, v7)
    }

    public fun all_coin_withdraw_4_coins<T0, T1, T2, T3, T4>(arg0: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>) {
        assert_protocol_version(arg1);
        assert_pool_size_is(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::size<T0>(arg0), 4);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T4>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x2::coin::value<T0>(&arg6);
        let v4 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::math::calc_all_coin_withdraw<T0>(arg0, v3);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = withdraw<T0, T1>(arg0, &v4, arg7);
        let v6 = withdraw<T0, T2>(arg0, &v4, arg7);
        let v7 = withdraw<T0, T3>(arg0, &v4, arg7);
        let v8 = withdraw<T0, T4>(arg0, &v4, arg7);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::protocol_fees::collect_fees_4_coins<T1, T2, T3, T4>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, &mut v8, v0, arg7);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::events::emit_withdraw_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::type_names<T0>(arg0), v4, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::balances<T0>(arg0), v3);
        (v5, v6, v7, v8)
    }

    public fun all_coin_withdraw_5_coins<T0, T1, T2, T3, T4, T5>(arg0: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>) {
        assert_protocol_version(arg1);
        assert_pool_size_is(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::size<T0>(arg0), 5);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T5>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x2::coin::value<T0>(&arg6);
        let v4 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::math::calc_all_coin_withdraw<T0>(arg0, v3);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = withdraw<T0, T1>(arg0, &v4, arg7);
        let v6 = withdraw<T0, T2>(arg0, &v4, arg7);
        let v7 = withdraw<T0, T3>(arg0, &v4, arg7);
        let v8 = withdraw<T0, T4>(arg0, &v4, arg7);
        let v9 = withdraw<T0, T5>(arg0, &v4, arg7);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::protocol_fees::collect_fees_5_coins<T1, T2, T3, T4, T5>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, &mut v8, &mut v9, v0, arg7);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::events::emit_withdraw_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::type_names<T0>(arg0), v4, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::balances<T0>(arg0), v3);
        (v5, v6, v7, v8, v9)
    }

    public fun all_coin_withdraw_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>) {
        assert_protocol_version(arg1);
        assert_pool_size_is(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::size<T0>(arg0), 6);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T6>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x2::coin::value<T0>(&arg6);
        let v4 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::math::calc_all_coin_withdraw<T0>(arg0, v3);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = withdraw<T0, T1>(arg0, &v4, arg7);
        let v6 = withdraw<T0, T2>(arg0, &v4, arg7);
        let v7 = withdraw<T0, T3>(arg0, &v4, arg7);
        let v8 = withdraw<T0, T4>(arg0, &v4, arg7);
        let v9 = withdraw<T0, T5>(arg0, &v4, arg7);
        let v10 = withdraw<T0, T6>(arg0, &v4, arg7);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::protocol_fees::collect_fees_6_coins<T1, T2, T3, T4, T5, T6>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, &mut v8, &mut v9, &mut v10, v0, arg7);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::events::emit_withdraw_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::type_names<T0>(arg0), v4, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::balances<T0>(arg0), v3);
        (v5, v6, v7, v8, v9, v10)
    }

    public fun all_coin_withdraw_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>, 0x2::coin::Coin<T7>) {
        assert_protocol_version(arg1);
        assert_pool_size_is(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::size<T0>(arg0), 7);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T6>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T7>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x2::coin::value<T0>(&arg6);
        let v4 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::math::calc_all_coin_withdraw<T0>(arg0, v3);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = withdraw<T0, T1>(arg0, &v4, arg7);
        let v6 = withdraw<T0, T2>(arg0, &v4, arg7);
        let v7 = withdraw<T0, T3>(arg0, &v4, arg7);
        let v8 = withdraw<T0, T4>(arg0, &v4, arg7);
        let v9 = withdraw<T0, T5>(arg0, &v4, arg7);
        let v10 = withdraw<T0, T6>(arg0, &v4, arg7);
        let v11 = withdraw<T0, T7>(arg0, &v4, arg7);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::protocol_fees::collect_fees_7_coins<T1, T2, T3, T4, T5, T6, T7>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, &mut v8, &mut v9, &mut v10, &mut v11, v0, arg7);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::events::emit_withdraw_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::type_names<T0>(arg0), v4, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::balances<T0>(arg0), v3);
        (v5, v6, v7, v8, v9, v10, v11)
    }

    public fun all_coin_withdraw_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>, 0x2::coin::Coin<T7>, 0x2::coin::Coin<T8>) {
        assert_protocol_version(arg1);
        assert_pool_size_is(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::size<T0>(arg0), 8);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T6>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T7>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T8>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x2::coin::value<T0>(&arg6);
        let v4 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::math::calc_all_coin_withdraw<T0>(arg0, v3);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = withdraw<T0, T1>(arg0, &v4, arg7);
        let v6 = withdraw<T0, T2>(arg0, &v4, arg7);
        let v7 = withdraw<T0, T3>(arg0, &v4, arg7);
        let v8 = withdraw<T0, T4>(arg0, &v4, arg7);
        let v9 = withdraw<T0, T5>(arg0, &v4, arg7);
        let v10 = withdraw<T0, T6>(arg0, &v4, arg7);
        let v11 = withdraw<T0, T7>(arg0, &v4, arg7);
        let v12 = withdraw<T0, T8>(arg0, &v4, arg7);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::protocol_fees::collect_fees_8_coins<T1, T2, T3, T4, T5, T6, T7, T8>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, &mut v8, &mut v9, &mut v10, &mut v11, &mut v12, v0, arg7);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::events::emit_withdraw_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::type_names<T0>(arg0), v4, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::balances<T0>(arg0), v3);
        (v5, v6, v7, v8, v9, v10, v11, v12)
    }

    fun assert_equal(arg0: u64, arg1: u64) {
        assert!(arg0 == arg1, 33);
    }

    fun assert_no_duplicates<T0>(arg0: &vector<T0>) {
        let v0 = 0x1::vector::length<T0>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<T0>(arg0, v1);
            let v3 = v1 + 1;
            while (v3 < v0) {
                assert!(v2 != 0x1::vector::borrow<T0>(arg0, v3), 34);
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
    }

    fun assert_non_zero(arg0: u64) {
        assert!(arg0 > 0, 32);
    }

    fun assert_pool_size_is(arg0: u64, arg1: u64) {
        assert!(arg1 == arg0, 31);
    }

    fun assert_pool_size_is_at_least(arg0: u64, arg1: u64) {
        assert!(arg1 <= arg0, 31);
    }

    fun assert_protocol_version(arg0: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry) {
        assert!(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::protocol_version(arg0) == 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::current_protocol_version(), 30);
    }

    public fun withdraw_1_coins<T0, T1>(arg0: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 1);
        assert_pool_size_is_at_least(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::size<T0>(arg0), 1);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::coin::value<T0>(&arg6);
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v2, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T1>());
        let v3 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::math::calc_withdraw_exact_lp<T0>(arg0, &v2, v1, &arg7, arg8);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::burn_lp_coins<T0>(arg0, arg6);
        let v4 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T1>(arg0, *0x1::vector::borrow<u64>(&v3, 0), arg9);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::protocol_fees::collect_fees_1_coins<T1>(arg2, arg3, arg4, arg5, &mut v4, v0, arg9);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::events::emit_withdraw_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v2, v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::balances<T0>(arg0), v1);
        v4
    }

    public fun withdraw_2_coins<T0, T1, T2>(arg0: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 2);
        assert_pool_size_is_at_least(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::size<T0>(arg0), 2);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::coin::value<T0>(&arg6);
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T2>());
        assert_no_duplicates<0x1::ascii::String>(&v2);
        let v4 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::math::calc_withdraw_exact_lp<T0>(arg0, &v2, v1, &arg7, arg8);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T1>(arg0, *0x1::vector::borrow<u64>(&v4, 0), arg9);
        let v6 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&v4, 1), arg9);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::protocol_fees::collect_fees_2_coins<T1, T2>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, v0, arg9);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::events::emit_withdraw_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v2, v4, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::balances<T0>(arg0), v1);
        (v5, v6)
    }

    public fun withdraw_3_coins<T0, T1, T2, T3>(arg0: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 3);
        assert_pool_size_is_at_least(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::size<T0>(arg0), 3);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::coin::value<T0>(&arg6);
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T3>());
        assert_no_duplicates<0x1::ascii::String>(&v2);
        let v4 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::math::calc_withdraw_exact_lp<T0>(arg0, &v2, v1, &arg7, arg8);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T1>(arg0, *0x1::vector::borrow<u64>(&v4, 0), arg9);
        let v6 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&v4, 1), arg9);
        let v7 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&v4, 2), arg9);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::protocol_fees::collect_fees_3_coins<T1, T2, T3>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, v0, arg9);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::events::emit_withdraw_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v2, v4, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::balances<T0>(arg0), v1);
        (v5, v6, v7)
    }

    public fun withdraw_4_coins<T0, T1, T2, T3, T4>(arg0: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 4);
        assert_pool_size_is_at_least(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::size<T0>(arg0), 4);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::coin::value<T0>(&arg6);
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T4>());
        assert_no_duplicates<0x1::ascii::String>(&v2);
        let v4 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::math::calc_withdraw_exact_lp<T0>(arg0, &v2, v1, &arg7, arg8);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T1>(arg0, *0x1::vector::borrow<u64>(&v4, 0), arg9);
        let v6 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&v4, 1), arg9);
        let v7 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&v4, 2), arg9);
        let v8 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T4>(arg0, *0x1::vector::borrow<u64>(&v4, 3), arg9);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::protocol_fees::collect_fees_4_coins<T1, T2, T3, T4>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, &mut v8, v0, arg9);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::events::emit_withdraw_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v2, v4, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::balances<T0>(arg0), v1);
        (v5, v6, v7, v8)
    }

    public fun withdraw_5_coins<T0, T1, T2, T3, T4, T5>(arg0: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 5);
        assert_pool_size_is_at_least(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::size<T0>(arg0), 5);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::coin::value<T0>(&arg6);
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T5>());
        assert_no_duplicates<0x1::ascii::String>(&v2);
        let v4 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::math::calc_withdraw_exact_lp<T0>(arg0, &v2, v1, &arg7, arg8);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T1>(arg0, *0x1::vector::borrow<u64>(&v4, 0), arg9);
        let v6 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&v4, 1), arg9);
        let v7 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&v4, 2), arg9);
        let v8 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T4>(arg0, *0x1::vector::borrow<u64>(&v4, 3), arg9);
        let v9 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T5>(arg0, *0x1::vector::borrow<u64>(&v4, 4), arg9);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::protocol_fees::collect_fees_5_coins<T1, T2, T3, T4, T5>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, &mut v8, &mut v9, v0, arg9);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::events::emit_withdraw_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v2, v4, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::balances<T0>(arg0), v1);
        (v5, v6, v7, v8, v9)
    }

    public fun withdraw_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 6);
        assert_pool_size_is_at_least(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::size<T0>(arg0), 6);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::coin::value<T0>(&arg6);
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T6>());
        assert_no_duplicates<0x1::ascii::String>(&v2);
        let v4 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::math::calc_withdraw_exact_lp<T0>(arg0, &v2, v1, &arg7, arg8);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T1>(arg0, *0x1::vector::borrow<u64>(&v4, 0), arg9);
        let v6 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&v4, 1), arg9);
        let v7 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&v4, 2), arg9);
        let v8 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T4>(arg0, *0x1::vector::borrow<u64>(&v4, 3), arg9);
        let v9 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T5>(arg0, *0x1::vector::borrow<u64>(&v4, 4), arg9);
        let v10 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T6>(arg0, *0x1::vector::borrow<u64>(&v4, 5), arg9);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::protocol_fees::collect_fees_6_coins<T1, T2, T3, T4, T5, T6>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, &mut v8, &mut v9, &mut v10, v0, arg9);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::events::emit_withdraw_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v2, v4, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::balances<T0>(arg0), v1);
        (v5, v6, v7, v8, v9, v10)
    }

    public fun withdraw_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>, 0x2::coin::Coin<T7>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 7);
        assert_pool_size_is_at_least(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::size<T0>(arg0), 7);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::coin::value<T0>(&arg6);
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T6>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T7>());
        assert_no_duplicates<0x1::ascii::String>(&v2);
        let v4 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::math::calc_withdraw_exact_lp<T0>(arg0, &v2, v1, &arg7, arg8);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T1>(arg0, *0x1::vector::borrow<u64>(&v4, 0), arg9);
        let v6 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&v4, 1), arg9);
        let v7 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&v4, 2), arg9);
        let v8 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T4>(arg0, *0x1::vector::borrow<u64>(&v4, 3), arg9);
        let v9 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T5>(arg0, *0x1::vector::borrow<u64>(&v4, 4), arg9);
        let v10 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T6>(arg0, *0x1::vector::borrow<u64>(&v4, 5), arg9);
        let v11 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T7>(arg0, *0x1::vector::borrow<u64>(&v4, 6), arg9);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::protocol_fees::collect_fees_7_coins<T1, T2, T3, T4, T5, T6, T7>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, &mut v8, &mut v9, &mut v10, &mut v11, v0, arg9);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::events::emit_withdraw_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v2, v4, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::balances<T0>(arg0), v1);
        (v5, v6, v7, v8, v9, v10, v11)
    }

    public fun withdraw_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::Pool<T0>, arg1: &0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool_registry::PoolRegistry, arg2: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>, 0x2::coin::Coin<T7>, 0x2::coin::Coin<T8>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 8);
        assert_pool_size_is_at_least(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::size<T0>(arg0), 8);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::coin::value<T0>(&arg6);
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T6>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T7>());
        0x1::vector::push_back<0x1::ascii::String>(v3, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::keys::type_to_string<T8>());
        assert_no_duplicates<0x1::ascii::String>(&v2);
        let v4 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::math::calc_withdraw_exact_lp<T0>(arg0, &v2, v1, &arg7, arg8);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T1>(arg0, *0x1::vector::borrow<u64>(&v4, 0), arg9);
        let v6 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&v4, 1), arg9);
        let v7 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&v4, 2), arg9);
        let v8 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T4>(arg0, *0x1::vector::borrow<u64>(&v4, 3), arg9);
        let v9 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T5>(arg0, *0x1::vector::borrow<u64>(&v4, 4), arg9);
        let v10 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T6>(arg0, *0x1::vector::borrow<u64>(&v4, 5), arg9);
        let v11 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T7>(arg0, *0x1::vector::borrow<u64>(&v4, 6), arg9);
        let v12 = 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::take<T0, T8>(arg0, *0x1::vector::borrow<u64>(&v4, 7), arg9);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::protocol_fees::collect_fees_8_coins<T1, T2, T3, T4, T5, T6, T7, T8>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, &mut v8, &mut v9, &mut v10, &mut v11, &mut v12, v0, arg9);
        0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::events::emit_withdraw_event<T0>(arg0, v0, 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::referrer_for(arg5, v0), v2, v4, 0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::balances<T0>(arg0), v1);
        (v5, v6, v7, v8, v9, v10, v11, v12)
    }

    // decompiled from Move bytecode v6
}

