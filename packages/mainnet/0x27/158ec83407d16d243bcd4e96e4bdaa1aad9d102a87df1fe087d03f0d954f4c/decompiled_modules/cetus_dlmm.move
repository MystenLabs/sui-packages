module 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::cetus_dlmm {
    struct OpenPositionReceipt {
        user: address,
        amount_a: u64,
        amount_b: u64,
    }

    struct ClosePositionReceipt {
        user: address,
        position_id: 0x2::object::ID,
    }

    struct CollectFeesReceipt {
        user: address,
    }

    struct OpenLimitOrderReceipt {
        user: address,
        amount: u64,
        target_bin_id: u32,
        side: u8,
        reserved_gas: u64,
    }

    public fun close_limit_order<T0, T1>(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: &0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::OperatorCap, arg2: address, arg3: address, arg4: 0x2::object::ID, arg5: u32, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg8) / 1000;
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::operator::authorize_no_value(arg0, arg1, arg2, arg8, arg9);
        let v1 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_position(arg0, arg4);
        assert!(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_owner(v1) == arg3, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::position_not_owned_by_user());
        let v2 = *0x1::option::borrow<u32>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_target_bin_id(v1));
        let v3 = *0x1::option::borrow<u8>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_limit_side(v1));
        let v4 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_amount_a(v1);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_amount_b(v1);
        let v5 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_token_a(v1);
        let v6 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::bin_math::is_limit_order_filled(arg5, v2, v3);
        if (!v6) {
            assert!(arg5 != v2, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::cannot_cancel_active_bin());
        };
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::gas::release_limit_order_gas(arg0, arg3, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_reserved_gas(v1), arg4, v0);
        let v7 = 0x2::coin::value<T0>(&arg6);
        let v8 = 0x2::coin::value<T1>(&arg7);
        let v9 = v7;
        let v10 = v8;
        if (v6) {
            let v11 = 0x2::coin::into_balance<T0>(arg6);
            let v12 = 0x2::coin::into_balance<T1>(arg7);
            if (v3 == 0) {
                0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::charge_limit_order_fee<T0>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_fee_pool_mut(arg0), &mut v11, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::calculate_limit_order_fee(v7, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::cfg_limit_order_fee_bps(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::config(arg0))));
            } else {
                0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::charge_limit_order_fee<T1>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_fee_pool_mut(arg0), &mut v12, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::calculate_limit_order_fee(v8, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::cfg_limit_order_fee_bps(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::config(arg0))));
            };
            v9 = 0x2::balance::value<T0>(&v11);
            v10 = 0x2::balance::value<T1>(&v12);
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::user_join<T0>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_user_pool_mut(arg0), v11);
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::user_join<T1>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_user_pool_mut(arg0), v12);
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::events::emit_limit_order_filled(arg3, arg4, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()), v7, v8, 0, v0);
        } else {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::user_join<T0>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_user_pool_mut(arg0), 0x2::coin::into_balance<T0>(arg6));
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::user_join<T1>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_user_pool_mut(arg0), 0x2::coin::into_balance<T1>(arg7));
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::events::emit_limit_order_cancelled(arg3, arg4, 0, v0);
        };
        let v13 = if (v6) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::status_filled()
        } else {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::status_closed()
        };
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::set_position_status(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_position_mut(arg0, arg4), v13);
        let v14 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, arg3);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::remove_position_id(v14, &arg4);
        let v15 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_active_limit_orders(v14);
        if (v15 > 0) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::set_active_limit_orders(v14, v15 - 1);
        };
        if (v4 > 0) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::unlock_amount(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_locked_mut(v14), v5, v4);
        };
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::debit_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_deposits_mut(v14), v5, v4);
        if (v9 > 0) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::credit_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_deposits_mut(v14), v5, v9);
        };
        if (v10 > 0) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::credit_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_deposits_mut(v14), 0x1::type_name::with_defining_ids<T1>(), v10);
        };
    }

    public fun drop_collect_receipt(arg0: &0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::OperatorCap, arg1: CollectFeesReceipt) {
        let CollectFeesReceipt {  } = arg1;
    }

    public fun finalize_close_position<T0, T1>(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: ClosePositionReceipt, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let ClosePositionReceipt {
            user        : v0,
            position_id : v1,
        } = arg1;
        let v2 = v1;
        let v3 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_position(arg0, v2);
        let v4 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_amount_a(v3);
        let v5 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_amount_b(v3);
        let v6 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_token_a(v3);
        let v7 = *0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_token_b(v3);
        let v8 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::cfg_yield_fee_bps(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::config(arg0));
        let v9 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::calculate_yield_fee(0x2::coin::value<T0>(&arg2), v4, v8);
        let v10 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::calculate_yield_fee(0x2::coin::value<T1>(&arg3), v5, v8);
        if (v9 > 0) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::fee_join<T0>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_fee_pool_mut(arg0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v9, arg5)));
        };
        if (v10 > 0) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::fee_join<T1>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_fee_pool_mut(arg0), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v10, arg5)));
        };
        let v11 = 0x2::coin::value<T0>(&arg2);
        let v12 = 0x2::coin::value<T1>(&arg3);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::user_join<T0>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_user_pool_mut(arg0), 0x2::coin::into_balance<T0>(arg2));
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::user_join<T1>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_user_pool_mut(arg0), 0x2::coin::into_balance<T1>(arg3));
        let v13 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, v0);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::unlock_amount(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_locked_mut(v13), v6, v4);
        if (0x1::option::is_some<0x1::type_name::TypeName>(&v7)) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::unlock_amount(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_locked_mut(v13), 0x1::option::destroy_some<0x1::type_name::TypeName>(v7), v5);
        };
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::debit_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_deposits_mut(v13), v6, v4);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::credit_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_deposits_mut(v13), v6, v11);
        if (v12 > 0) {
            let v14 = 0x1::type_name::with_defining_ids<T1>();
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::debit_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_deposits_mut(v13), v14, v5);
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::credit_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_deposits_mut(v13), v14, v12);
        };
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::remove_position_id(v13, &v2);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::set_position_status(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_position_mut(arg0, v2), 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::status_closed());
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::events::emit_close_position(v0, v2, v11, v12, v9, v10, 0x2::clock::timestamp_ms(arg4) / 1000);
    }

    public fun finalize_collect_fees<T0, T1>(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: CollectFeesReceipt, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>) {
        let CollectFeesReceipt { user: v0 } = arg1;
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = 0x2::coin::value<T1>(&arg3);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::user_join<T0>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_user_pool_mut(arg0), 0x2::coin::into_balance<T0>(arg2));
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::user_join<T1>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_user_pool_mut(arg0), 0x2::coin::into_balance<T1>(arg3));
        let v3 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, v0);
        if (v1 > 0) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::credit_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_deposits_mut(v3), 0x1::type_name::with_defining_ids<T0>(), v1);
        };
        if (v2 > 0) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::credit_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_deposits_mut(v3), 0x1::type_name::with_defining_ids<T1>(), v2);
        };
    }

    public fun finalize_open_limit_order<T0, T1, T2: store + key>(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: T2, arg2: OpenLimitOrderReceipt, arg3: &0x2::clock::Clock) {
        let OpenLimitOrderReceipt {
            user          : v0,
            amount        : v1,
            target_bin_id : v2,
            side          : v3,
            reserved_gas  : v4,
        } = arg2;
        let v5 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v6 = 0x2::object::id<T2>(&arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, T2>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::vault_uid_mut(arg0), v6, arg1);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::add_position(arg0, v6, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::new_position_record(v0, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_type_limit_order(), 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::protocol_cetus_dlmm(), 0x1::type_name::with_defining_ids<T0>(), 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T1>()), v1, 0, 0x1::option::some<u32>(v2), 0x1::option::some<u8>(v3), v4, v5));
        let v7 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, v0);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::add_position_id(v7, v6);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::set_active_limit_orders(v7, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_active_limit_orders(v7) + 1);
        let v8 = if (v3 == 0) {
            0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())
        } else {
            0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
        };
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::events::emit_limit_order_created(v0, v6, v8, v1, v2, v3, v4, v5);
    }

    public fun finalize_open_position<T0, T1, T2: store + key>(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: T2, arg2: OpenPositionReceipt, arg3: &0x2::clock::Clock) {
        let OpenPositionReceipt {
            user     : v0,
            amount_a : v1,
            amount_b : v2,
        } = arg2;
        let v3 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v4 = 0x2::object::id<T2>(&arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, T2>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::vault_uid_mut(arg0), v4, arg1);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::add_position(arg0, v4, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::new_position_record(v0, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_type_lp(), 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::protocol_cetus_dlmm(), 0x1::type_name::with_defining_ids<T0>(), 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T1>()), v1, v2, 0x1::option::none<u32>(), 0x1::option::none<u8>(), 0, v3));
        let v5 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, v0);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::add_position_id(v5, v4);
        assert!(0x2::vec_set::length<0x2::object::ID>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_position_ids(v5)) <= 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::cfg_max_positions_per_user(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::config(arg0)), 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::max_positions_reached());
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::events::emit_open_position(v0, v4, v4, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()), v1, v2, v3);
    }

    fun gas_cost_open_position(arg0: &0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::VaultConfig) : u64 {
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::cfg_gas_cost_open_position(arg0)
    }

    public fun prepare_add_liquidity<T0, T1>(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: &0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::OperatorCap, arg2: address, arg3: address, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::operator::authorize(arg0, arg1, arg2, 0, arg7, arg8);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::gas::deduct_gas(arg0, arg3, gas_cost_open_position(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::config(arg0)), 0x1::ascii::string(b"add_liquidity"), 0x2::clock::timestamp_ms(arg7) / 1000);
        assert!(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_owner(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_position(arg0, arg4)) == arg3, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::position_not_owned_by_user());
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account(arg0, arg3);
        let v3 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::get_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_deposits(v2), &v0);
        let v4 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::get_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_deposits(v2), &v1);
        let v5 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, arg3);
        if (arg5 > 0) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::lock_amount(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_locked_mut(v5), v0, arg5, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::get_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_max_lock(v2), &v0), v3);
        };
        if (arg6 > 0) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::lock_amount(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_locked_mut(v5), v1, arg6, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::get_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_max_lock(v2), &v1), v4);
        };
        let v6 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_position_mut(arg0, arg4);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::set_position_amounts(v6, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_amount_a(v6) + arg5, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_amount_b(v6) + arg6);
        let v7 = if (arg5 > 0) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::user_split<T0>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_user_pool_mut(arg0), arg5)
        } else {
            0x2::balance::zero<T0>()
        };
        let v8 = if (arg6 > 0) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::user_split<T1>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_user_pool_mut(arg0), arg6)
        } else {
            0x2::balance::zero<T1>()
        };
        (0x2::coin::from_balance<T0>(v7, arg8), 0x2::coin::from_balance<T1>(v8, arg8))
    }

    public fun prepare_close_position<T0: store + key>(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: &0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::OperatorCap, arg2: address, arg3: address, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (T0, ClosePositionReceipt) {
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::operator::authorize(arg0, arg1, arg2, 0, arg5, arg6);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::gas::deduct_gas(arg0, arg3, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::cfg_gas_cost_close_position(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::config(arg0)), 0x1::ascii::string(b"close_position"), 0x2::clock::timestamp_ms(arg5) / 1000);
        assert!(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_owner(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_position(arg0, arg4)) == arg3, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::position_not_owned_by_user());
        let v0 = ClosePositionReceipt{
            user        : arg3,
            position_id : arg4,
        };
        (0x2::dynamic_object_field::remove<0x2::object::ID, T0>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::vault_uid_mut(arg0), arg4), v0)
    }

    public fun prepare_collect_fees(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: &0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::OperatorCap, arg2: address, arg3: address, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : CollectFeesReceipt {
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::operator::authorize_no_value(arg0, arg1, arg2, arg5, arg6);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::gas::deduct_gas(arg0, arg3, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::cfg_gas_cost_collect_fees(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::config(arg0)), 0x1::ascii::string(b"collect_fees"), 0x2::clock::timestamp_ms(arg5) / 1000);
        assert!(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_owner(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_position(arg0, arg4)) == arg3, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::position_not_owned_by_user());
        CollectFeesReceipt{user: arg3}
    }

    public fun prepare_open_limit_order<T0>(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: &0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::OperatorCap, arg2: address, arg3: address, arg4: u64, arg5: u32, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, OpenLimitOrderReceipt) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::operator::authorize(arg0, arg1, arg2, 0, arg7, arg8);
        assert!(arg6 <= 1, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::invalid_limit_side());
        let v1 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::config(arg0);
        let v2 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account(arg0, arg3);
        assert!(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_active_limit_orders(v2) < 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::cfg_max_limit_orders_per_user(v1), 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::max_limit_orders_reached());
        assert!(v0 >= 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_last_order_created_at(v2) + 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::cfg_order_cooldown_ms(v1), 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::order_cooldown());
        let v3 = 0x2::object::new(arg8);
        0x2::object::delete(v3);
        let v4 = 0x1::type_name::with_defining_ids<T0>();
        let v5 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account(arg0, arg3);
        let v6 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::get_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_deposits(v5), &v4);
        let v7 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, arg3);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::lock_amount(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_locked_mut(v7), v4, arg4, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::get_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_max_lock(v5), &v4), v6);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::set_last_order_created_at(v7, v0);
        let v8 = OpenLimitOrderReceipt{
            user          : arg3,
            amount        : arg4,
            target_bin_id : arg5,
            side          : arg6,
            reserved_gas  : 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::gas::reserve_limit_order_gas(arg0, arg3, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::cfg_gas_cost_open_limit_order(v1), 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::cfg_gas_cost_close_limit_order(v1), 0x2::object::uid_to_inner(&v3), 0x2::clock::timestamp_ms(arg7) / 1000),
        };
        (0x2::coin::from_balance<T0>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::user_split<T0>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_user_pool_mut(arg0), arg4), arg8), v8)
    }

    public fun prepare_open_position<T0, T1>(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: &0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::OperatorCap, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, OpenPositionReceipt) {
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::operator::authorize(arg0, arg1, arg2, 0, arg6, arg7);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::gas::deduct_gas(arg0, arg3, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::cfg_gas_cost_open_position(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::config(arg0)), 0x1::ascii::string(b"open_position"), 0x2::clock::timestamp_ms(arg6) / 1000);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account(arg0, arg3);
        let v3 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::get_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_deposits(v2), &v0);
        let v4 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::get_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_deposits(v2), &v1);
        let v5 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, arg3);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::lock_amount(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_locked_mut(v5), v0, arg4, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::get_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_max_lock(v2), &v0), v3);
        if (arg5 > 0) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::lock_amount(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_locked_mut(v5), v1, arg5, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::get_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_max_lock(v2), &v1), v4);
        };
        let v6 = if (arg5 > 0) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::user_split<T1>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_user_pool_mut(arg0), arg5)
        } else {
            0x2::balance::zero<T1>()
        };
        let v7 = OpenPositionReceipt{
            user     : arg3,
            amount_a : arg4,
            amount_b : arg5,
        };
        (0x2::coin::from_balance<T0>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::user_split<T0>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_user_pool_mut(arg0), arg4), arg7), 0x2::coin::from_balance<T1>(v6, arg7), v7)
    }

    // decompiled from Move bytecode v7
}

