module 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_factory {
    public fun create_lp_coin<T0: drop>(arg0: T0, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::CreatePoolCap<T0> {
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::create_lp_coin<T0>(arg0, arg1, arg2)
    }

    fun assert_non_zero(arg0: u64) {
        assert!(arg0 > 0, 11);
    }

    fun assert_protocol_version(arg0: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry) {
        assert!(0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::protocol_version(arg0) == 1, 10);
    }

    public fun create_pool_2_coins<T0, T1, T2>(arg0: 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::CreatePoolCap<T0>, arg1: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u64>, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: 0x2::coin::Coin<T1>, arg14: 0x2::coin::Coin<T2>, arg15: 0x1::option::Option<vector<u8>>, arg16: bool, arg17: 0x1::option::Option<u8>, arg18: &mut 0x2::tx_context::TxContext) : (0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, 0x2::coin::Coin<T0>) {
        assert_protocol_version(arg1);
        assert_non_zero(0x2::coin::value<T1>(&arg13));
        assert_non_zero(0x2::coin::value<T2>(&arg14));
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T2>());
        let v2 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::new<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16, arg17, arg18);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(&arg13));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(&arg14));
        let v5 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalize_amounts<T0>(&v2, &v3);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T1>(arg1, &mut v2, arg13);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T2>(arg1, &mut v2, arg14);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::events::emit_created_pool_event<T0>(&v2);
        (v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_lp_supply<T0>(&mut v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::unnormalize_lp_amount<T0>(&v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::math::calc_invariant<T0>(&v2, &v5)), arg18))
    }

    public fun create_pool_3_coins<T0, T1, T2, T3>(arg0: 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::CreatePoolCap<T0>, arg1: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u64>, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: 0x2::coin::Coin<T1>, arg14: 0x2::coin::Coin<T2>, arg15: 0x2::coin::Coin<T3>, arg16: 0x1::option::Option<vector<u8>>, arg17: bool, arg18: 0x1::option::Option<u8>, arg19: &mut 0x2::tx_context::TxContext) : (0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, 0x2::coin::Coin<T0>) {
        assert_protocol_version(arg1);
        assert_non_zero(0x2::coin::value<T1>(&arg13));
        assert_non_zero(0x2::coin::value<T2>(&arg14));
        assert_non_zero(0x2::coin::value<T3>(&arg15));
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T3>());
        let v2 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::new<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg16, arg17, arg18, arg19);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(&arg13));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(&arg14));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(&arg15));
        let v5 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalize_amounts<T0>(&v2, &v3);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T1>(arg1, &mut v2, arg13);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T2>(arg1, &mut v2, arg14);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T3>(arg1, &mut v2, arg15);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::events::emit_created_pool_event<T0>(&v2);
        (v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_lp_supply<T0>(&mut v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::unnormalize_lp_amount<T0>(&v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::math::calc_invariant<T0>(&v2, &v5)), arg19))
    }

    public fun create_pool_4_coins<T0, T1, T2, T3, T4>(arg0: 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::CreatePoolCap<T0>, arg1: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u64>, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: 0x2::coin::Coin<T1>, arg14: 0x2::coin::Coin<T2>, arg15: 0x2::coin::Coin<T3>, arg16: 0x2::coin::Coin<T4>, arg17: 0x1::option::Option<vector<u8>>, arg18: bool, arg19: 0x1::option::Option<u8>, arg20: &mut 0x2::tx_context::TxContext) : (0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, 0x2::coin::Coin<T0>) {
        assert_protocol_version(arg1);
        assert_non_zero(0x2::coin::value<T1>(&arg13));
        assert_non_zero(0x2::coin::value<T2>(&arg14));
        assert_non_zero(0x2::coin::value<T3>(&arg15));
        assert_non_zero(0x2::coin::value<T4>(&arg16));
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T4>());
        let v2 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::new<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg17, arg18, arg19, arg20);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(&arg13));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(&arg14));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(&arg15));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T4>(&arg16));
        let v5 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalize_amounts<T0>(&v2, &v3);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T1>(arg1, &mut v2, arg13);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T2>(arg1, &mut v2, arg14);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T3>(arg1, &mut v2, arg15);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T4>(arg1, &mut v2, arg16);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::events::emit_created_pool_event<T0>(&v2);
        (v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_lp_supply<T0>(&mut v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::unnormalize_lp_amount<T0>(&v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::math::calc_invariant<T0>(&v2, &v5)), arg20))
    }

    public fun create_pool_5_coins<T0, T1, T2, T3, T4, T5>(arg0: 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::CreatePoolCap<T0>, arg1: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u64>, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: 0x2::coin::Coin<T1>, arg14: 0x2::coin::Coin<T2>, arg15: 0x2::coin::Coin<T3>, arg16: 0x2::coin::Coin<T4>, arg17: 0x2::coin::Coin<T5>, arg18: 0x1::option::Option<vector<u8>>, arg19: bool, arg20: 0x1::option::Option<u8>, arg21: &mut 0x2::tx_context::TxContext) : (0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, 0x2::coin::Coin<T0>) {
        assert_protocol_version(arg1);
        assert_non_zero(0x2::coin::value<T1>(&arg13));
        assert_non_zero(0x2::coin::value<T2>(&arg14));
        assert_non_zero(0x2::coin::value<T3>(&arg15));
        assert_non_zero(0x2::coin::value<T4>(&arg16));
        assert_non_zero(0x2::coin::value<T5>(&arg17));
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T5>());
        let v2 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::new<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg18, arg19, arg20, arg21);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(&arg13));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(&arg14));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(&arg15));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T4>(&arg16));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T5>(&arg17));
        let v5 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalize_amounts<T0>(&v2, &v3);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T1>(arg1, &mut v2, arg13);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T2>(arg1, &mut v2, arg14);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T3>(arg1, &mut v2, arg15);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T4>(arg1, &mut v2, arg16);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T5>(arg1, &mut v2, arg17);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::events::emit_created_pool_event<T0>(&v2);
        (v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_lp_supply<T0>(&mut v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::unnormalize_lp_amount<T0>(&v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::math::calc_invariant<T0>(&v2, &v5)), arg21))
    }

    public fun create_pool_6_coins<T0, T1, T2, T3, T4, T5, T6>(arg0: 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::CreatePoolCap<T0>, arg1: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u64>, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: 0x2::coin::Coin<T1>, arg14: 0x2::coin::Coin<T2>, arg15: 0x2::coin::Coin<T3>, arg16: 0x2::coin::Coin<T4>, arg17: 0x2::coin::Coin<T5>, arg18: 0x2::coin::Coin<T6>, arg19: 0x1::option::Option<vector<u8>>, arg20: bool, arg21: 0x1::option::Option<u8>, arg22: &mut 0x2::tx_context::TxContext) : (0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, 0x2::coin::Coin<T0>) {
        assert_protocol_version(arg1);
        assert_non_zero(0x2::coin::value<T1>(&arg13));
        assert_non_zero(0x2::coin::value<T2>(&arg14));
        assert_non_zero(0x2::coin::value<T3>(&arg15));
        assert_non_zero(0x2::coin::value<T4>(&arg16));
        assert_non_zero(0x2::coin::value<T5>(&arg17));
        assert_non_zero(0x2::coin::value<T6>(&arg18));
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T6>());
        let v2 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::new<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg19, arg20, arg21, arg22);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(&arg13));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(&arg14));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(&arg15));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T4>(&arg16));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T5>(&arg17));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T6>(&arg18));
        let v5 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalize_amounts<T0>(&v2, &v3);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T1>(arg1, &mut v2, arg13);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T2>(arg1, &mut v2, arg14);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T3>(arg1, &mut v2, arg15);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T4>(arg1, &mut v2, arg16);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T5>(arg1, &mut v2, arg17);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T6>(arg1, &mut v2, arg18);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::events::emit_created_pool_event<T0>(&v2);
        (v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_lp_supply<T0>(&mut v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::unnormalize_lp_amount<T0>(&v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::math::calc_invariant<T0>(&v2, &v5)), arg22))
    }

    public fun create_pool_7_coins<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::CreatePoolCap<T0>, arg1: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u64>, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: 0x2::coin::Coin<T1>, arg14: 0x2::coin::Coin<T2>, arg15: 0x2::coin::Coin<T3>, arg16: 0x2::coin::Coin<T4>, arg17: 0x2::coin::Coin<T5>, arg18: 0x2::coin::Coin<T6>, arg19: 0x2::coin::Coin<T7>, arg20: 0x1::option::Option<vector<u8>>, arg21: bool, arg22: 0x1::option::Option<u8>, arg23: &mut 0x2::tx_context::TxContext) : (0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, 0x2::coin::Coin<T0>) {
        assert_protocol_version(arg1);
        assert_non_zero(0x2::coin::value<T1>(&arg13));
        assert_non_zero(0x2::coin::value<T2>(&arg14));
        assert_non_zero(0x2::coin::value<T3>(&arg15));
        assert_non_zero(0x2::coin::value<T4>(&arg16));
        assert_non_zero(0x2::coin::value<T5>(&arg17));
        assert_non_zero(0x2::coin::value<T6>(&arg18));
        assert_non_zero(0x2::coin::value<T7>(&arg19));
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T6>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T7>());
        let v2 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::new<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg20, arg21, arg22, arg23);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(&arg13));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(&arg14));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(&arg15));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T4>(&arg16));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T5>(&arg17));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T6>(&arg18));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T7>(&arg19));
        let v5 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalize_amounts<T0>(&v2, &v3);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T1>(arg1, &mut v2, arg13);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T2>(arg1, &mut v2, arg14);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T3>(arg1, &mut v2, arg15);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T4>(arg1, &mut v2, arg16);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T5>(arg1, &mut v2, arg17);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T6>(arg1, &mut v2, arg18);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T7>(arg1, &mut v2, arg19);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::events::emit_created_pool_event<T0>(&v2);
        (v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_lp_supply<T0>(&mut v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::unnormalize_lp_amount<T0>(&v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::math::calc_invariant<T0>(&v2, &v5)), arg23))
    }

    public fun create_pool_8_coins<T0, T1, T2, T3, T4, T5, T6, T7, T8>(arg0: 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::CreatePoolCap<T0>, arg1: &mut 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u64>, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: 0x2::coin::Coin<T1>, arg14: 0x2::coin::Coin<T2>, arg15: 0x2::coin::Coin<T3>, arg16: 0x2::coin::Coin<T4>, arg17: 0x2::coin::Coin<T5>, arg18: 0x2::coin::Coin<T6>, arg19: 0x2::coin::Coin<T7>, arg20: 0x2::coin::Coin<T8>, arg21: 0x1::option::Option<vector<u8>>, arg22: bool, arg23: 0x1::option::Option<u8>, arg24: &mut 0x2::tx_context::TxContext) : (0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, 0x2::coin::Coin<T0>) {
        assert_protocol_version(arg1);
        assert_non_zero(0x2::coin::value<T1>(&arg13));
        assert_non_zero(0x2::coin::value<T2>(&arg14));
        assert_non_zero(0x2::coin::value<T3>(&arg15));
        assert_non_zero(0x2::coin::value<T4>(&arg16));
        assert_non_zero(0x2::coin::value<T5>(&arg17));
        assert_non_zero(0x2::coin::value<T6>(&arg18));
        assert_non_zero(0x2::coin::value<T7>(&arg19));
        assert_non_zero(0x2::coin::value<T8>(&arg20));
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T1>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T2>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T3>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T4>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T5>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T6>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T7>());
        0x1::vector::push_back<0x1::ascii::String>(v1, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T8>());
        let v2 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::new<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg21, arg22, arg23, arg24);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T1>(&arg13));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T2>(&arg14));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T3>(&arg15));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T4>(&arg16));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T5>(&arg17));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T6>(&arg18));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T7>(&arg19));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T8>(&arg20));
        let v5 = 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::normalize_amounts<T0>(&v2, &v3);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T1>(arg1, &mut v2, arg13);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T2>(arg1, &mut v2, arg14);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T3>(arg1, &mut v2, arg15);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T4>(arg1, &mut v2, arg16);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T5>(arg1, &mut v2, arg17);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T6>(arg1, &mut v2, arg18);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T7>(arg1, &mut v2, arg19);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_liquidity<T0, T8>(arg1, &mut v2, arg20);
        0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::events::emit_created_pool_event<T0>(&v2);
        (v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::initialize_lp_supply<T0>(&mut v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::unnormalize_lp_amount<T0>(&v2, 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::math::calc_invariant<T0>(&v2, &v5)), arg24))
    }

    // decompiled from Move bytecode v6
}

