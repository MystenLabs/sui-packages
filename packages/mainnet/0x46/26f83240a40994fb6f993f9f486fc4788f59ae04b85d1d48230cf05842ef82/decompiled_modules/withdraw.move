module 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::withdraw {
    fun withdraw<T0, T1>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &vector<u64>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T1>(arg0, *0x1::vector::borrow<u64>(arg1, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_to_index<T0, T1>(arg0)), arg2)
    }

    public fun all_coin_withdraw_2_coins<T0, T1, T2>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert_protocol_version(arg1);
        assert_pool_size_is(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 2);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x2::coin::value<T0>(&arg6);
        let v4 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_all_coin_withdraw<T0>(arg0, v3);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = withdraw<T0, T1>(arg0, &v4, arg7);
        let v6 = withdraw<T0, T2>(arg0, &v4, arg7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::protocol_fees::collect_fees_2_coins<T1, T2>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, v0, arg7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_withdraw_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_names<T0>(arg0), v4, v3);
        (v5, v6)
    }

    public fun all_coin_withdraw_3_coins<T0, T1, T2, T3>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>) {
        assert_protocol_version(arg1);
        assert_pool_size_is(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 3);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x2::coin::value<T0>(&arg6);
        let v4 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_all_coin_withdraw<T0>(arg0, v3);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = withdraw<T0, T1>(arg0, &v4, arg7);
        let v6 = withdraw<T0, T2>(arg0, &v4, arg7);
        let v7 = withdraw<T0, T3>(arg0, &v4, arg7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::protocol_fees::collect_fees_3_coins<T1, T2, T3>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, v0, arg7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_withdraw_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_names<T0>(arg0), v4, v3);
        (v5, v6, v7)
    }

    public fun all_coin_withdraw_4_coins<T0, T1, T2, T3, T4>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>) {
        assert_protocol_version(arg1);
        assert_pool_size_is(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 4);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T4>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x2::coin::value<T0>(&arg6);
        let v4 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_all_coin_withdraw<T0>(arg0, v3);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = withdraw<T0, T1>(arg0, &v4, arg7);
        let v6 = withdraw<T0, T2>(arg0, &v4, arg7);
        let v7 = withdraw<T0, T3>(arg0, &v4, arg7);
        let v8 = withdraw<T0, T4>(arg0, &v4, arg7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::protocol_fees::collect_fees_4_coins<T1, T2, T3, T4>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, &mut v8, v0, arg7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_withdraw_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_names<T0>(arg0), v4, v3);
        (v5, v6, v7, v8)
    }

    public fun all_coin_withdraw_5_coins<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>) {
        assert_protocol_version(arg1);
        assert_pool_size_is(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 5);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T5>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x2::coin::value<T0>(&arg6);
        let v4 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_all_coin_withdraw<T0>(arg0, v3);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = withdraw<T0, T1>(arg0, &v4, arg7);
        let v6 = withdraw<T0, T2>(arg0, &v4, arg7);
        let v7 = withdraw<T0, T3>(arg0, &v4, arg7);
        let v8 = withdraw<T0, T4>(arg0, &v4, arg7);
        let v9 = withdraw<T0, T5>(arg0, &v4, arg7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::protocol_fees::collect_fees_5_coins<T1, T2, T3, T4, T5>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, &mut v8, &mut v9, v0, arg7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_withdraw_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_names<T0>(arg0), v4, v3);
        (v5, v6, v7, v8, v9)
    }

    public fun all_coin_withdraw_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>) {
        assert_protocol_version(arg1);
        assert_pool_size_is(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 6);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T6>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x2::coin::value<T0>(&arg6);
        let v4 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_all_coin_withdraw<T0>(arg0, v3);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = withdraw<T0, T1>(arg0, &v4, arg7);
        let v6 = withdraw<T0, T2>(arg0, &v4, arg7);
        let v7 = withdraw<T0, T3>(arg0, &v4, arg7);
        let v8 = withdraw<T0, T4>(arg0, &v4, arg7);
        let v9 = withdraw<T0, T5>(arg0, &v4, arg7);
        let v10 = withdraw<T0, T6>(arg0, &v4, arg7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::protocol_fees::collect_fees_6_coins<T1, T2, T3, T4, T5, T6>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, &mut v8, &mut v9, &mut v10, v0, arg7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_withdraw_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_names<T0>(arg0), v4, v3);
        (v5, v6, v7, v8, v9, v10)
    }

    public fun all_coin_withdraw_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>, 0x2::coin::Coin<T7>) {
        assert_protocol_version(arg1);
        assert_pool_size_is(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 7);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T6>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T7>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x2::coin::value<T0>(&arg6);
        let v4 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_all_coin_withdraw<T0>(arg0, v3);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = withdraw<T0, T1>(arg0, &v4, arg7);
        let v6 = withdraw<T0, T2>(arg0, &v4, arg7);
        let v7 = withdraw<T0, T3>(arg0, &v4, arg7);
        let v8 = withdraw<T0, T4>(arg0, &v4, arg7);
        let v9 = withdraw<T0, T5>(arg0, &v4, arg7);
        let v10 = withdraw<T0, T6>(arg0, &v4, arg7);
        let v11 = withdraw<T0, T7>(arg0, &v4, arg7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::protocol_fees::collect_fees_7_coins<T1, T2, T3, T4, T5, T6, T7>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, &mut v8, &mut v9, &mut v10, &mut v11, v0, arg7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_withdraw_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_names<T0>(arg0), v4, v3);
        (v5, v6, v7, v8, v9, v10, v11)
    }

    public fun all_coin_withdraw_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>, 0x2::coin::Coin<T7>, 0x2::coin::Coin<T8>) {
        assert_protocol_version(arg1);
        assert_pool_size_is(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 8);
        assert_non_zero(0x2::coin::value<T0>(&arg6));
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T6>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T7>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T8>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x2::coin::value<T0>(&arg6);
        let v4 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_all_coin_withdraw<T0>(arg0, v3);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::burn_lp_coins<T0>(arg0, arg6);
        let v5 = withdraw<T0, T1>(arg0, &v4, arg7);
        let v6 = withdraw<T0, T2>(arg0, &v4, arg7);
        let v7 = withdraw<T0, T3>(arg0, &v4, arg7);
        let v8 = withdraw<T0, T4>(arg0, &v4, arg7);
        let v9 = withdraw<T0, T5>(arg0, &v4, arg7);
        let v10 = withdraw<T0, T6>(arg0, &v4, arg7);
        let v11 = withdraw<T0, T7>(arg0, &v4, arg7);
        let v12 = withdraw<T0, T8>(arg0, &v4, arg7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::protocol_fees::collect_fees_8_coins<T1, T2, T3, T4, T5, T6, T7, T8>(arg2, arg3, arg4, arg5, &mut v5, &mut v6, &mut v7, &mut v8, &mut v9, &mut v10, &mut v11, &mut v12, v0, arg7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_withdraw_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::type_names<T0>(arg0), v4, v3);
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

    fun assert_protocol_version(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry) {
        assert!(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::protocol_version(arg0) == 1, 30);
    }

    // decompiled from Move bytecode v6
}

