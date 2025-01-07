module 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::swap {
    fun assert_equal(arg0: u64, arg1: u64) {
        assert!(arg0 == arg1, 43);
    }

    fun assert_no_duplicates<T0>(arg0: &vector<T0>) {
        let v0 = 0x1::vector::length<T0>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<T0>(arg0, v1);
            let v3 = v1 + 1;
            while (v3 < v0) {
                assert!(v2 != 0x1::vector::borrow<T0>(arg0, v3), 45);
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
    }

    fun assert_non_zero(arg0: u64) {
        assert!(arg0 > 0, 42);
    }

    fun assert_pool_size_is_at_least(arg0: u64, arg1: u64) {
        assert!(arg1 <= arg0, 41);
    }

    fun assert_protocol_version(arg0: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry) {
        assert!(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::protocol_version(arg0) == 1, 40);
    }

    public fun multi_swap_exact_in_1_to_1<T0, T1, T2>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 1);
        assert_non_zero(0x2::coin::value<T1>(&arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut arg6, v0, arg9);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v1, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, 0x2::coin::value<T1>(&arg6));
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        let v4 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_multi_swap_exact_in<T0>(arg0, &v1, &v2, &v3, &arg7, arg8);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::join<T0, T1>(arg0, arg6);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_swap_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), v1, v2, v3, v4);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&v4, 0), arg9)
    }

    public fun multi_swap_exact_in_1_to_2<T0, T1, T2, T3>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 2);
        assert_pool_size_is_at_least(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 3);
        assert_non_zero(0x2::coin::value<T1>(&arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut arg6, v0, arg9);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, 0x2::coin::value<T1>(&arg6));
        let v5 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_multi_swap_exact_in<T0>(arg0, &v3, &v4, &v1, &arg7, arg8);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::join<T0, T1>(arg0, arg6);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_swap_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), v3, v4, v1, v5);
        (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&v5, 0), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&v5, 1), arg9))
    }

    public fun multi_swap_exact_in_1_to_3<T0, T1, T2, T3, T4>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 3);
        assert_pool_size_is_at_least(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 4);
        assert_non_zero(0x2::coin::value<T1>(&arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T4>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut arg6, v0, arg9);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, 0x2::coin::value<T1>(&arg6));
        let v5 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_multi_swap_exact_in<T0>(arg0, &v3, &v4, &v1, &arg7, arg8);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::join<T0, T1>(arg0, arg6);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_swap_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), v3, v4, v1, v5);
        (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&v5, 0), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&v5, 1), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T4>(arg0, *0x1::vector::borrow<u64>(&v5, 2), arg9))
    }

    public fun multi_swap_exact_in_1_to_4<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 4);
        assert_pool_size_is_at_least(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 5);
        assert_non_zero(0x2::coin::value<T1>(&arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T5>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut arg6, v0, arg9);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, 0x2::coin::value<T1>(&arg6));
        let v5 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_multi_swap_exact_in<T0>(arg0, &v3, &v4, &v1, &arg7, arg8);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::join<T0, T1>(arg0, arg6);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_swap_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), v3, v4, v1, v5);
        (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&v5, 0), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&v5, 1), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T4>(arg0, *0x1::vector::borrow<u64>(&v5, 2), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T5>(arg0, *0x1::vector::borrow<u64>(&v5, 3), arg9))
    }

    public fun multi_swap_exact_in_1_to_5<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 5);
        assert_pool_size_is_at_least(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 6);
        assert_non_zero(0x2::coin::value<T1>(&arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T6>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut arg6, v0, arg9);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, 0x2::coin::value<T1>(&arg6));
        let v5 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_multi_swap_exact_in<T0>(arg0, &v3, &v4, &v1, &arg7, arg8);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::join<T0, T1>(arg0, arg6);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_swap_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), v3, v4, v1, v5);
        (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&v5, 0), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&v5, 1), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T4>(arg0, *0x1::vector::borrow<u64>(&v5, 2), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T5>(arg0, *0x1::vector::borrow<u64>(&v5, 3), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T6>(arg0, *0x1::vector::borrow<u64>(&v5, 4), arg9))
    }

    public fun multi_swap_exact_in_1_to_6<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>, 0x2::coin::Coin<T7>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 6);
        assert_pool_size_is_at_least(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 7);
        assert_non_zero(0x2::coin::value<T1>(&arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T6>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T7>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut arg6, v0, arg9);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, 0x2::coin::value<T1>(&arg6));
        let v5 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_multi_swap_exact_in<T0>(arg0, &v3, &v4, &v1, &arg7, arg8);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::join<T0, T1>(arg0, arg6);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_swap_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), v3, v4, v1, v5);
        (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&v5, 0), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&v5, 1), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T4>(arg0, *0x1::vector::borrow<u64>(&v5, 2), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T5>(arg0, *0x1::vector::borrow<u64>(&v5, 3), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T6>(arg0, *0x1::vector::borrow<u64>(&v5, 4), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T7>(arg0, *0x1::vector::borrow<u64>(&v5, 5), arg9))
    }

    public fun multi_swap_exact_in_1_to_7<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>, 0x2::coin::Coin<T7>, 0x2::coin::Coin<T8>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 7);
        assert_pool_size_is_at_least(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 8);
        assert_non_zero(0x2::coin::value<T1>(&arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T6>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T7>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T8>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut arg6, v0, arg9);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, 0x2::coin::value<T1>(&arg6));
        let v5 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_multi_swap_exact_in<T0>(arg0, &v3, &v4, &v1, &arg7, arg8);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::join<T0, T1>(arg0, arg6);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_swap_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), v3, v4, v1, v5);
        (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&v5, 0), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&v5, 1), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T4>(arg0, *0x1::vector::borrow<u64>(&v5, 2), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T5>(arg0, *0x1::vector::borrow<u64>(&v5, 3), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T6>(arg0, *0x1::vector::borrow<u64>(&v5, 4), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T7>(arg0, *0x1::vector::borrow<u64>(&v5, 5), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T8>(arg0, *0x1::vector::borrow<u64>(&v5, 6), arg9))
    }

    public fun multi_swap_exact_out_1_to_1<T0, T1, T2>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: &mut 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 1);
        assert_pool_size_is_at_least(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 2);
        assert_non_zero(0x2::coin::value<T1>(arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v1, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        let v3 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v3, 0x2::coin::value<T1>(arg6));
        let v4 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_multi_swap_exact_out<T0>(arg0, &v2, &v3, &v1, &arg7, arg8);
        let v5 = *0x1::vector::borrow<u64>(&v4, 0);
        let v6 = 0x2::coin::split<T1>(arg6, 0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::minimum_before_fees(arg2, v5), arg9);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut v6, v0, arg9);
        assert!(0x2::coin::value<T1>(&v6) >= v5, 46);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::join<T0, T1>(arg0, v6);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_swap_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), v2, v4, v1, arg7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&arg7, 0), arg9)
    }

    public fun multi_swap_exact_out_1_to_2<T0, T1, T2, T3>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: &mut 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 2);
        assert_pool_size_is_at_least(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 3);
        assert_non_zero(0x2::coin::value<T1>(arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, 0x2::coin::value<T1>(arg6));
        let v5 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_multi_swap_exact_out<T0>(arg0, &v3, &v4, &v1, &arg7, arg8);
        let v6 = *0x1::vector::borrow<u64>(&v5, 0);
        let v7 = 0x2::coin::split<T1>(arg6, 0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::minimum_before_fees(arg2, v6), arg9);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut v7, v0, arg9);
        assert!(0x2::coin::value<T1>(&v7) >= v6, 46);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::join<T0, T1>(arg0, v7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_swap_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), v3, v5, v1, arg7);
        (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&arg7, 0), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&arg7, 1), arg9))
    }

    public fun multi_swap_exact_out_1_to_3<T0, T1, T2, T3, T4>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: &mut 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 3);
        assert_pool_size_is_at_least(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 4);
        assert_non_zero(0x2::coin::value<T1>(arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T4>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, 0x2::coin::value<T1>(arg6));
        let v5 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_multi_swap_exact_out<T0>(arg0, &v3, &v4, &v1, &arg7, arg8);
        let v6 = *0x1::vector::borrow<u64>(&v5, 0);
        let v7 = 0x2::coin::split<T1>(arg6, 0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::minimum_before_fees(arg2, v6), arg9);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut v7, v0, arg9);
        assert!(0x2::coin::value<T1>(&v7) >= v6, 46);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::join<T0, T1>(arg0, v7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_swap_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), v3, v5, v1, arg7);
        (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&arg7, 0), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&arg7, 1), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T4>(arg0, *0x1::vector::borrow<u64>(&arg7, 2), arg9))
    }

    public fun multi_swap_exact_out_1_to_4<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: &mut 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 4);
        assert_pool_size_is_at_least(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 5);
        assert_non_zero(0x2::coin::value<T1>(arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T5>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, 0x2::coin::value<T1>(arg6));
        let v5 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_multi_swap_exact_out<T0>(arg0, &v3, &v4, &v1, &arg7, arg8);
        let v6 = *0x1::vector::borrow<u64>(&v5, 0);
        let v7 = 0x2::coin::split<T1>(arg6, 0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::minimum_before_fees(arg2, v6), arg9);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut v7, v0, arg9);
        assert!(0x2::coin::value<T1>(&v7) >= v6, 46);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::join<T0, T1>(arg0, v7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_swap_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), v3, v5, v1, arg7);
        (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&arg7, 0), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&arg7, 1), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T4>(arg0, *0x1::vector::borrow<u64>(&arg7, 2), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T5>(arg0, *0x1::vector::borrow<u64>(&arg7, 3), arg9))
    }

    public fun multi_swap_exact_out_1_to_5<T0, T1, T2, T3, T4, T5, T6>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: &mut 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 5);
        assert_pool_size_is_at_least(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 6);
        assert_non_zero(0x2::coin::value<T1>(arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T6>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, 0x2::coin::value<T1>(arg6));
        let v5 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_multi_swap_exact_out<T0>(arg0, &v3, &v4, &v1, &arg7, arg8);
        let v6 = *0x1::vector::borrow<u64>(&v5, 0);
        let v7 = 0x2::coin::split<T1>(arg6, 0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::minimum_before_fees(arg2, v6), arg9);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut v7, v0, arg9);
        assert!(0x2::coin::value<T1>(&v7) >= v6, 46);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::join<T0, T1>(arg0, v7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_swap_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), v3, v5, v1, arg7);
        (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&arg7, 0), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&arg7, 1), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T4>(arg0, *0x1::vector::borrow<u64>(&arg7, 2), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T5>(arg0, *0x1::vector::borrow<u64>(&arg7, 3), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T6>(arg0, *0x1::vector::borrow<u64>(&arg7, 4), arg9))
    }

    public fun multi_swap_exact_out_1_to_6<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: &mut 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>, 0x2::coin::Coin<T7>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 6);
        assert_pool_size_is_at_least(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 7);
        assert_non_zero(0x2::coin::value<T1>(arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T6>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T7>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, 0x2::coin::value<T1>(arg6));
        let v5 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_multi_swap_exact_out<T0>(arg0, &v3, &v4, &v1, &arg7, arg8);
        let v6 = *0x1::vector::borrow<u64>(&v5, 0);
        let v7 = 0x2::coin::split<T1>(arg6, 0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::minimum_before_fees(arg2, v6), arg9);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut v7, v0, arg9);
        assert!(0x2::coin::value<T1>(&v7) >= v6, 46);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::join<T0, T1>(arg0, v7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_swap_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), v3, v5, v1, arg7);
        (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&arg7, 0), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&arg7, 1), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T4>(arg0, *0x1::vector::borrow<u64>(&arg7, 2), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T5>(arg0, *0x1::vector::borrow<u64>(&arg7, 3), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T6>(arg0, *0x1::vector::borrow<u64>(&arg7, 4), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T7>(arg0, *0x1::vector::borrow<u64>(&arg7, 5), arg9))
    }

    public fun multi_swap_exact_out_1_to_7<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: &mut 0x2::coin::Coin<T1>, arg7: vector<u64>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, 0x2::coin::Coin<T5>, 0x2::coin::Coin<T6>, 0x2::coin::Coin<T7>, 0x2::coin::Coin<T8>) {
        assert_protocol_version(arg1);
        assert_equal(0x1::vector::length<u64>(&arg7), 7);
        assert_pool_size_is_at_least(0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::size<T0>(arg0), 8);
        assert_non_zero(0x2::coin::value<T1>(arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T6>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T7>());
        0x1::vector::push_back<0x1::ascii::String>(v2, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T8>());
        assert_no_duplicates<0x1::ascii::String>(&v1);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, 0x2::coin::value<T1>(arg6));
        let v5 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_multi_swap_exact_out<T0>(arg0, &v3, &v4, &v1, &arg7, arg8);
        let v6 = *0x1::vector::borrow<u64>(&v5, 0);
        let v7 = 0x2::coin::split<T1>(arg6, 0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::minimum_before_fees(arg2, v6), arg9);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut v7, v0, arg9);
        assert!(0x2::coin::value<T1>(&v7) >= v6, 46);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::join<T0, T1>(arg0, v7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_swap_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), v3, v5, v1, arg7);
        (0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T2>(arg0, *0x1::vector::borrow<u64>(&arg7, 0), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T3>(arg0, *0x1::vector::borrow<u64>(&arg7, 1), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T4>(arg0, *0x1::vector::borrow<u64>(&arg7, 2), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T5>(arg0, *0x1::vector::borrow<u64>(&arg7, 3), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T6>(arg0, *0x1::vector::borrow<u64>(&arg7, 4), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T7>(arg0, *0x1::vector::borrow<u64>(&arg7, 5), arg9), 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T8>(arg0, *0x1::vector::borrow<u64>(&arg7, 6), arg9))
    }

    public fun swap_exact_in<T0, T1, T2>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_protocol_version(arg1);
        assert_non_zero(0x2::coin::value<T1>(&arg6));
        let v0 = 0x2::tx_context::sender(arg9);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut arg6, v0, arg9);
        let v1 = 0x2::coin::value<T1>(&arg6);
        let v2 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_swap_exact_in<T0, T1, T2>(arg0, v1, arg7, arg8);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::join<T0, T1>(arg0, arg6);
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, v1);
        let v5 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v5, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        let v6 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v6, v2);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_swap_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), v3, v4, v5, v6);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T2>(arg0, v2, arg9)
    }

    public fun swap_exact_out<T0, T1, T2>(arg0: &mut 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::Pool<T0>, arg1: &0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool_registry::PoolRegistry, arg2: &0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::ProtocolFeeVault, arg3: &mut 0x9e96e14585633f5f1f437164cf74a2052a62521a8b310dcb30ee7289b4d8698::treasury::Treasury, arg4: &mut 0xdc6c8b85cbefd0db26c59a83f915816b02bc7a08ca0eb3c3f21877cee7e71071::insurance_fund::InsuranceFund, arg5: &0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::ReferralVault, arg6: u64, arg7: &mut 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_protocol_version(arg1);
        assert_non_zero(0x2::coin::value<T1>(arg7));
        assert_non_zero(arg6);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::math::calc_swap_exact_out<T0, T1, T2>(arg0, arg8, arg6, arg9);
        let v2 = 0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::minimum_before_fees(arg2, v1);
        assert!(v2 <= 0x2::coin::value<T1>(arg7), 44);
        let v3 = 0x2::coin::split<T1>(arg7, v2, arg10);
        0x601207d00bf8862cc36dd06041b6e99707aa68baf7db175a74ceb15aa7a2310b::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, &mut v3, v0, arg10);
        assert!(0x2::coin::value<T1>(&v3) >= v1, 46);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::join<T0, T1>(arg0, v3);
        let v4 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v4, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T1>());
        let v5 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v5, v1);
        let v6 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v6, 0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::keys::type_to_string<T2>());
        let v7 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v7, arg6);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::events::emit_swap_event<T0>(arg0, v0, 0xdf857ebd99ad63680122f2960f46ae9f2377cbc31791848dff4d9719fee5f3ac::referral_vault::referrer_for(arg5, v0), v4, v5, v6, v7);
        0x20a65e88af1067e992c08c3d739df5411f4f34de38a7073102a709ae0aa6057e::pool::take<T0, T2>(arg0, arg6, arg10)
    }

    // decompiled from Move bytecode v6
}

