module 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_ops {
    struct PrepareReceipt {
        user: address,
        protocol_id: u8,
        op_kind: u8,
        amount_a: u64,
        amount_b: u64,
        reserved_gas: u64,
        metadata: vector<u8>,
    }

    struct LimitFillOutcome has drop {
        side: u8,
        filled: bool,
    }

    public fun cleanup_closed_position(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::Vault, arg1: address, arg2: 0x2::object::ID, arg3: bool) {
        let v0 = if (arg3) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::status_filled()
        } else {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::status_closed()
        };
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::set_position_status(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_position_mut(arg0, arg2), v0);
        let v1 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_account_mut(arg0, arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_position_ids(v1), &arg2)) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::remove_position_id(v1, &arg2);
        };
    }

    public fun finalize_add_liquidity(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::Vault, arg1: PrepareReceipt, arg2: 0x2::object::ID) {
        let PrepareReceipt {
            user         : _,
            protocol_id  : _,
            op_kind      : v2,
            amount_a     : v3,
            amount_b     : v4,
            reserved_gas : _,
            metadata     : _,
        } = arg1;
        assert!(v2 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_add_liquidity(), 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::not_operator());
        let v7 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_position_mut(arg0, arg2);
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::set_position_amounts(v7, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::position_amount_a(v7) + v3, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::position_amount_b(v7) + v4);
    }

    fun finalize_internal<T0, T1>(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::Vault, arg1: PrepareReceipt, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: u8, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let PrepareReceipt {
            user         : v0,
            protocol_id  : _,
            op_kind      : v2,
            amount_a     : v3,
            amount_b     : v4,
            reserved_gas : v5,
            metadata     : _,
        } = arg1;
        let v7 = 0x2::coin::value<T0>(&arg2);
        let v8 = 0x2::coin::value<T1>(&arg3);
        let v9 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::cfg_yield_fee_bps(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::config(arg0));
        let v10 = v7;
        let v11 = v8;
        if (arg4 && arg6) {
            if (arg5 == 0) {
                let v12 = 0x2::coin::into_balance<T0>(arg2);
                0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::charge_limit_order_fee<T0>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_fee_pool_mut(arg0), &mut v12, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::calculate_limit_order_fee(v7, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::cfg_limit_order_fee_bps(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::config(arg0))));
                v10 = 0x2::balance::value<T0>(&v12);
                0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::user_join<T0>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_user_pool_mut(arg0), v12);
                0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::user_join<T1>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_user_pool_mut(arg0), 0x2::coin::into_balance<T1>(arg3));
            } else {
                let v13 = 0x2::coin::into_balance<T1>(arg3);
                0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::charge_limit_order_fee<T1>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_fee_pool_mut(arg0), &mut v13, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::calculate_limit_order_fee(v8, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::cfg_limit_order_fee_bps(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::config(arg0))));
                v11 = 0x2::balance::value<T1>(&v13);
                0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::user_join<T0>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_user_pool_mut(arg0), 0x2::coin::into_balance<T0>(arg2));
                0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::user_join<T1>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_user_pool_mut(arg0), v13);
            };
        } else if (arg4 && !arg6) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::user_join<T0>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_user_pool_mut(arg0), 0x2::coin::into_balance<T0>(arg2));
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::user_join<T1>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_user_pool_mut(arg0), 0x2::coin::into_balance<T1>(arg3));
        } else {
            if (v2 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_close_lp() || v2 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_lending_withdraw()) {
                let v14 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::calculate_yield_fee(v7, v3, v9);
                let v15 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::calculate_yield_fee(v8, v4, v9);
                if (v14 > 0) {
                    0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::fee_join<T0>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_fee_pool_mut(arg0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v14, arg8)));
                };
                if (v15 > 0) {
                    0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::fee_join<T1>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_fee_pool_mut(arg0), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v15, arg8)));
                };
            };
            v10 = 0x2::coin::value<T0>(&arg2);
            v11 = 0x2::coin::value<T1>(&arg3);
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::user_join<T0>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_user_pool_mut(arg0), 0x2::coin::into_balance<T0>(arg2));
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::user_join<T1>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_user_pool_mut(arg0), 0x2::coin::into_balance<T1>(arg3));
        };
        let v16 = 0x1::type_name::with_defining_ids<T0>();
        let v17 = 0x1::type_name::with_defining_ids<T1>();
        let v18 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_account_mut(arg0, v0);
        let v19 = if (v2 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_close_lp()) {
            true
        } else if (v2 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_close_limit()) {
            true
        } else {
            v2 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_lending_withdraw()
        };
        if (v19) {
            if (v3 > 0) {
                0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::unlock_amount(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_locked_mut(v18), v16, v3);
                0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::debit_deposits(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_deposits_mut(v18), v16, v3);
            };
            if (v4 > 0) {
                0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::unlock_amount(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_locked_mut(v18), v17, v4);
                0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::debit_deposits(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_deposits_mut(v18), v17, v4);
            };
        };
        if (v10 > 0) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::credit_deposits(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_deposits_mut(v18), v16, v10);
        };
        if (v11 > 0) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::credit_deposits(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_deposits_mut(v18), v17, v11);
        };
        if (v2 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_close_limit() && v5 > 0) {
            let v20 = 0x2::object::new(arg8);
            0x2::object::delete(v20);
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::gas::release_limit_order_gas(arg0, v0, v5, 0x2::object::uid_to_inner(&v20), 0x2::clock::timestamp_ms(arg7) / 1000);
            let v21 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_account_mut(arg0, v0);
            let v22 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_active_limit_orders(v21);
            if (v22 > 0) {
                0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::set_active_limit_orders(v21, v22 - 1);
            };
        };
    }

    public fun finalize_record_only<T0, T1>(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::Vault, arg1: PrepareReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let PrepareReceipt {
            user         : v0,
            protocol_id  : v1,
            op_kind      : v2,
            amount_a     : v3,
            amount_b     : v4,
            reserved_gas : _,
            metadata     : _,
        } = arg1;
        let v7 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v8 = if (v2 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_lending_deposit()) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::position_type_lending()
        } else {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::position_type_lp()
        };
        let v9 = 0x1::type_name::with_defining_ids<T0>();
        0x1::type_name::with_defining_ids<T1>();
        let v10 = 0x2::object::new(arg3);
        let v11 = 0x2::object::uid_to_inner(&v10);
        0x2::object::delete(v10);
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::add_position(arg0, v11, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::new_position_record(v0, v8, v1, v9, 0x1::option::none<0x1::type_name::TypeName>(), v3, v4, 0x1::option::none<u32>(), 0x1::option::none<u8>(), 0, v7));
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::add_position_id(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_account_mut(arg0, v0), v11);
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::events::emit_lending_deposit(v0, v1, 0x1::type_name::into_string(v9), v3, 0, v7);
    }

    public fun finalize_with_asset<T0, T1, T2: store + key>(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::Vault, arg1: PrepareReceipt, arg2: T2, arg3: &0x2::clock::Clock) {
        let PrepareReceipt {
            user         : v0,
            protocol_id  : v1,
            op_kind      : v2,
            amount_a     : v3,
            amount_b     : v4,
            reserved_gas : v5,
            metadata     : _,
        } = arg1;
        let v7 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v8 = 0x2::object::id<T2>(&arg2);
        0x2::dynamic_object_field::add<0x2::object::ID, T2>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::vault_uid_mut(arg0), v8, arg2);
        let v9 = if (v2 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_open_lp()) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::position_type_lp()
        } else if (v2 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_open_limit()) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::position_type_limit_order()
        } else if (v2 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_lending_deposit()) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::position_type_lending()
        } else {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::position_type_lp()
        };
        let v10 = if (v4 > 0) {
            true
        } else if (v2 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_open_lp()) {
            true
        } else {
            v2 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_open_limit()
        };
        let v11 = if (v10) {
            0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T1>())
        } else {
            0x1::option::none<0x1::type_name::TypeName>()
        };
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::add_position(arg0, v8, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::new_position_record(v0, v9, v1, 0x1::type_name::with_defining_ids<T0>(), v11, v3, v4, 0x1::option::none<u32>(), 0x1::option::none<u8>(), v5, v7));
        let v12 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_account_mut(arg0, v0);
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::add_position_id(v12, v8);
        assert!(0x2::vec_set::length<0x2::object::ID>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_position_ids(v12)) <= 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::cfg_max_positions_per_user(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::config(arg0)), 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::max_positions_reached());
        if (v2 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_open_limit()) {
            let v13 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_account_mut(arg0, v0);
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::set_active_limit_orders(v13, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_active_limit_orders(v13) + 1);
        };
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::events::emit_open_position(v0, v8, v8, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()), v3, v4, v7);
    }

    public fun finalize_with_coin<T0>(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::Vault, arg1: PrepareReceipt, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let PrepareReceipt {
            user         : v0,
            protocol_id  : _,
            op_kind      : v2,
            amount_a     : v3,
            amount_b     : _,
            reserved_gas : _,
            metadata     : _,
        } = arg1;
        let v7 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::calculate_yield_fee(0x2::coin::value<T0>(&arg2), v3, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::cfg_yield_fee_bps(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::config(arg0)));
        if (v7 > 0) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::fee_join<T0>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_fee_pool_mut(arg0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v7, arg4)));
        };
        let v8 = 0x2::coin::value<T0>(&arg2);
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::user_join<T0>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_user_pool_mut(arg0), 0x2::coin::into_balance<T0>(arg2));
        let v9 = 0x1::type_name::with_defining_ids<T0>();
        let v10 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_account_mut(arg0, v0);
        let v11 = if (v2 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_close_lp()) {
            true
        } else if (v2 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_close_limit()) {
            true
        } else {
            v2 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_lending_withdraw()
        };
        if (v11 && v3 > 0) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::unlock_amount(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_locked_mut(v10), v9, v3);
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::debit_deposits(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_deposits_mut(v10), v9, v3);
        };
        if (v8 > 0) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::credit_deposits(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_deposits_mut(v10), v9, v8);
        };
    }

    public fun finalize_with_coins<T0, T1>(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::Vault, arg1: PrepareReceipt, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        finalize_internal<T0, T1>(arg0, arg1, arg2, arg3, false, 0, false, arg4, arg5);
    }

    public fun finalize_with_coins_limit<T0, T1>(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::Vault, arg1: PrepareReceipt, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u8, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        finalize_internal<T0, T1>(arg0, arg1, arg2, arg3, true, arg4, arg5, arg6, arg7);
    }

    public fun new_limit_fill_outcome(arg0: u8, arg1: bool) : LimitFillOutcome {
        LimitFillOutcome{
            side   : arg0,
            filled : arg1,
        }
    }

    fun op_label(arg0: u8) : 0x1::ascii::String {
        if (arg0 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_open_lp()) {
            0x1::ascii::string(b"open_lp")
        } else if (arg0 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_close_lp()) {
            0x1::ascii::string(b"close_lp")
        } else if (arg0 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_add_liquidity()) {
            0x1::ascii::string(b"add_liquidity")
        } else if (arg0 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_remove_liquidity()) {
            0x1::ascii::string(b"remove_liquidity")
        } else if (arg0 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_collect_fees()) {
            0x1::ascii::string(b"collect_fees")
        } else if (arg0 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_open_limit()) {
            0x1::ascii::string(b"open_limit")
        } else if (arg0 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_close_limit()) {
            0x1::ascii::string(b"close_limit")
        } else if (arg0 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_lending_deposit()) {
            0x1::ascii::string(b"lending_deposit")
        } else if (arg0 == 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_lending_withdraw()) {
            0x1::ascii::string(b"lending_withdraw")
        } else {
            0x1::ascii::string(b"unknown_op")
        }
    }

    public fun prepare_lock<T0, T1>(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::Vault, arg1: &0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::OperatorCap, arg2: address, arg3: address, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, PrepareReceipt) {
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::operator::authorize(arg0, arg1, arg2, 0, arg9, arg10);
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::gas::deduct_gas(arg0, arg3, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::cfg_gas_cost(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::config(arg0), arg4), op_label(arg4), 0x2::clock::timestamp_ms(arg9) / 1000);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_account(arg0, arg3);
        let v3 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::get_deposits(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_deposits(v2), &v0);
        let v4 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::get_deposits(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_deposits(v2), &v1);
        let v5 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_account_mut(arg0, arg3);
        if (arg6 > 0) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::lock_amount(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_locked_mut(v5), v0, arg6, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::get_deposits(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_max_lock(v2), &v0), v3);
        };
        if (arg7 > 0) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::lock_amount(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_locked_mut(v5), v1, arg7, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::get_deposits(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_max_lock(v2), &v1), v4);
        };
        let v6 = if (arg6 > 0) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::user_split<T0>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_user_pool_mut(arg0), arg6)
        } else {
            0x2::balance::zero<T0>()
        };
        let v7 = if (arg7 > 0) {
            0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::user_split<T1>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_user_pool_mut(arg0), arg7)
        } else {
            0x2::balance::zero<T1>()
        };
        let v8 = PrepareReceipt{
            user         : arg3,
            protocol_id  : arg5,
            op_kind      : arg4,
            amount_a     : arg6,
            amount_b     : arg7,
            reserved_gas : 0,
            metadata     : arg8,
        };
        (0x2::coin::from_balance<T0>(v6, arg10), 0x2::coin::from_balance<T1>(v7, arg10), v8)
    }

    public fun prepare_lock_limit<T0>(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::Vault, arg1: &0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::OperatorCap, arg2: address, arg3: address, arg4: u8, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, PrepareReceipt) {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::operator::authorize(arg0, arg1, arg2, 0, arg8, arg9);
        let v1 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::config(arg0);
        let v2 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::cfg_gas_cost(v1, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_open_limit());
        let v3 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::cfg_max_limit_orders_per_user(v1);
        let v4 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::cfg_order_cooldown_ms(v1);
        let v5 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_account(arg0, arg3);
        assert!(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_active_limit_orders(v5) < v3, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::max_limit_orders_reached());
        assert!(v0 >= 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_last_order_created_at(v5) + v4, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::order_cooldown());
        let v6 = 0x2::object::new(arg9);
        0x2::object::delete(v6);
        let v7 = 0x1::type_name::with_defining_ids<T0>();
        let v8 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_account(arg0, arg3);
        let v9 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::get_deposits(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_deposits(v8), &v7);
        let v10 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_account_mut(arg0, arg3);
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::lock_amount(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_locked_mut(v10), v7, arg5, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::get_deposits(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_max_lock(v8), &v7), v9);
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::set_last_order_created_at(v10, v0);
        let v11 = PrepareReceipt{
            user         : arg3,
            protocol_id  : arg4,
            op_kind      : 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::op_open_limit(),
            amount_a     : arg5,
            amount_b     : 0,
            reserved_gas : 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::gas::reserve_limit_order_gas(arg0, arg3, v2, arg6, 0x2::object::uid_to_inner(&v6), 0x2::clock::timestamp_ms(arg8) / 1000),
            metadata     : arg7,
        };
        (0x2::coin::from_balance<T0>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::user_split<T0>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_user_pool_mut(arg0), arg5), arg9), v11)
    }

    public fun prepare_no_lock(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::Vault, arg1: &0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::OperatorCap, arg2: address, arg3: address, arg4: u8, arg5: u8, arg6: 0x2::object::ID, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : PrepareReceipt {
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::operator::authorize(arg0, arg1, arg2, 0, arg8, arg9);
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::gas::deduct_gas(arg0, arg3, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::cfg_gas_cost(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::config(arg0), arg4), op_label(arg4), 0x2::clock::timestamp_ms(arg8) / 1000);
        assert!(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::position_owner(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_position(arg0, arg6)) == arg3, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::position_not_owned_by_user());
        PrepareReceipt{
            user         : arg3,
            protocol_id  : arg5,
            op_kind      : arg4,
            amount_a     : 0,
            amount_b     : 0,
            reserved_gas : 0,
            metadata     : arg7,
        }
    }

    public fun prepare_unlock<T0: store + key>(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::Vault, arg1: &0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::OperatorCap, arg2: address, arg3: address, arg4: u8, arg5: u8, arg6: 0x2::object::ID, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (T0, PrepareReceipt) {
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::operator::authorize(arg0, arg1, arg2, 0, arg8, arg9);
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::gas::deduct_gas(arg0, arg3, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::cfg_gas_cost(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::config(arg0), arg4), op_label(arg4), 0x2::clock::timestamp_ms(arg8) / 1000);
        let v0 = 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_position(arg0, arg6);
        assert!(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::position_owner(v0) == arg3, 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::errors::position_not_owned_by_user());
        let v1 = PrepareReceipt{
            user         : arg3,
            protocol_id  : arg5,
            op_kind      : arg4,
            amount_a     : 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::position_amount_a(v0),
            amount_b     : 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::position_amount_b(v0),
            reserved_gas : 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::position_reserved_gas(v0),
            metadata     : arg7,
        };
        (0x2::dynamic_object_field::remove<0x2::object::ID, T0>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::vault_uid_mut(arg0), arg6), v1)
    }

    public fun receipt_amount_a(arg0: &PrepareReceipt) : u64 {
        arg0.amount_a
    }

    public fun receipt_amount_b(arg0: &PrepareReceipt) : u64 {
        arg0.amount_b
    }

    public fun receipt_metadata(arg0: &PrepareReceipt) : &vector<u8> {
        &arg0.metadata
    }

    public fun receipt_op_kind(arg0: &PrepareReceipt) : u8 {
        arg0.op_kind
    }

    public fun receipt_protocol_id(arg0: &PrepareReceipt) : u8 {
        arg0.protocol_id
    }

    public fun receipt_reserved_gas(arg0: &PrepareReceipt) : u64 {
        arg0.reserved_gas
    }

    public fun receipt_user(arg0: &PrepareReceipt) : address {
        arg0.user
    }

    public fun sweep_dust<T0>(arg0: &mut 0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::Vault, arg1: &PrepareReceipt, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
            return
        };
        let v1 = arg1.user;
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::pools::user_join<T0>(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_user_pool_mut(arg0), 0x2::coin::into_balance<T0>(arg2));
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::accounting::credit_deposits(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::account_deposits_mut(0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::vault_core::borrow_account_mut(arg0, v1)), v2, v0);
        0xea12745027e33bcb9c42b40db7ca8e252a4a9221f7e6fe5933fa55f2fcec2935::events::emit_dust_swept(v1, 0x1::type_name::into_string(v2), v0, 0x2::clock::timestamp_ms(arg3) / 1000);
    }

    // decompiled from Move bytecode v7
}

