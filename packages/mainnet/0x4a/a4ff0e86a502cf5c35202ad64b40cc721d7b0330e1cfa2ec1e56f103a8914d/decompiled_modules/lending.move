module 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::lending {
    struct LendingDepositReceipt {
        user: address,
        protocol: u8,
        amount: u64,
    }

    struct LendingWithdrawReceipt {
        user: address,
        position_id: 0x2::object::ID,
        protocol: u8,
    }

    public fun finalize_deposit<T0>(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: LendingDepositReceipt, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let LendingDepositReceipt {
            user     : v0,
            protocol : v1,
            amount   : v2,
        } = arg1;
        let v3 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v4 = 0x2::object::new(arg4);
        let v5 = 0x2::object::uid_to_inner(&v4);
        0x2::object::delete(v4);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::add_position(arg0, v5, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::new_position_record(v0, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_type_lending(), v1, 0x1::type_name::with_defining_ids<T0>(), 0x1::option::none<0x1::type_name::TypeName>(), v2, 0, 0x1::option::none<u32>(), 0x1::option::none<u8>(), 0, v3));
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::add_position_id(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, v0), v5);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::events::emit_lending_deposit(v0, v1, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v2, arg2, v3);
    }

    public fun finalize_deposit_with_ctoken<T0, T1: store + key>(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: LendingDepositReceipt, arg2: T1, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let LendingDepositReceipt {
            user     : v0,
            protocol : v1,
            amount   : v2,
        } = arg1;
        let v3 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v4 = 0x2::object::id<T1>(&arg2);
        0x2::dynamic_object_field::add<0x2::object::ID, T1>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::vault_uid_mut(arg0), v4, arg2);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::add_position(arg0, v4, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::new_position_record(v0, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_type_lending(), v1, 0x1::type_name::with_defining_ids<T0>(), 0x1::option::none<0x1::type_name::TypeName>(), v2, 0, 0x1::option::none<u32>(), 0x1::option::none<u8>(), 0, v3));
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::add_position_id(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, v0), v4);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::events::emit_lending_deposit(v0, v1, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v2, arg3, v3);
    }

    public fun finalize_withdraw<T0>(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: LendingWithdrawReceipt, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let LendingWithdrawReceipt {
            user        : v0,
            position_id : v1,
            protocol    : v2,
        } = arg1;
        let v3 = v1;
        let v4 = 0x2::coin::value<T0>(&arg2);
        let v5 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_position(arg0, v3);
        let v6 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_amount_a(v5);
        let v7 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_token_a(v5);
        let v8 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::calculate_yield_fee(v4, v6, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::cfg_yield_fee_bps(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::config(arg0)));
        let v9 = if (v4 > v6) {
            v4 - v6
        } else {
            0
        };
        if (v8 > 0) {
            0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::fee_join<T0>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_fee_pool_mut(arg0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v8, arg5)));
        };
        let v10 = 0x2::coin::value<T0>(&arg2);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::user_join<T0>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_user_pool_mut(arg0), 0x2::coin::into_balance<T0>(arg2));
        let v11 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, v0);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::unlock_amount(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_locked_mut(v11), v7, v6);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::debit_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_deposits_mut(v11), v7, v6);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::credit_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_deposits_mut(v11), v7, v10);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::remove_position_id(v11, &v3);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::set_position_status(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_position_mut(arg0, v3), 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::status_closed());
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::events::emit_lending_withdraw(v0, v2, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v10, arg3, v9, v8, 0x2::clock::timestamp_ms(arg4) / 1000);
    }

    public fun prepare_deposit<T0>(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: &0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::OperatorCap, arg2: address, arg3: address, arg4: u64, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, LendingDepositReceipt) {
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::operator::authorize(arg0, arg1, arg2, 0, arg6, arg7);
        let v0 = if (arg5 == 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::protocol_suilend()) {
            0x1::ascii::string(b"suilend_deposit")
        } else if (arg5 == 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::protocol_navi()) {
            0x1::ascii::string(b"navi_deposit")
        } else {
            0x1::ascii::string(b"alphalend_deposit")
        };
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::gas::deduct_gas(arg0, arg3, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::cfg_gas_cost_lending_deposit(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::config(arg0)), v0, 0x2::clock::timestamp_ms(arg6) / 1000);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account(arg0, arg3);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::lock_amount(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_locked_mut(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, arg3)), v1, arg4, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::get_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_max_lock(v2), &v1), 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::accounting::get_deposits(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_deposits(v2), &v1));
        let v3 = LendingDepositReceipt{
            user     : arg3,
            protocol : arg5,
            amount   : arg4,
        };
        (0x2::coin::from_balance<T0>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::user_split<T0>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_user_pool_mut(arg0), arg4), arg7), v3)
    }

    public fun prepare_withdraw(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: &0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::OperatorCap, arg2: address, arg3: address, arg4: 0x2::object::ID, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : LendingWithdrawReceipt {
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::operator::authorize(arg0, arg1, arg2, 0, arg6, arg7);
        let v0 = if (arg5 == 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::protocol_suilend()) {
            0x1::ascii::string(b"suilend_withdraw")
        } else if (arg5 == 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::protocol_navi()) {
            0x1::ascii::string(b"navi_withdraw")
        } else {
            0x1::ascii::string(b"alphalend_withdraw")
        };
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::gas::deduct_gas(arg0, arg3, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::cfg_gas_cost_lending_withdraw(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::config(arg0)), v0, 0x2::clock::timestamp_ms(arg6) / 1000);
        assert!(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_owner(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_position(arg0, arg4)) == arg3, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::position_not_owned_by_user());
        LendingWithdrawReceipt{
            user        : arg3,
            position_id : arg4,
            protocol    : arg5,
        }
    }

    public fun prepare_withdraw_with_ctoken<T0: store + key>(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: &0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::OperatorCap, arg2: address, arg3: address, arg4: 0x2::object::ID, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (T0, LendingWithdrawReceipt) {
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::operator::authorize(arg0, arg1, arg2, 0, arg6, arg7);
        let v0 = if (arg5 == 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::protocol_suilend()) {
            0x1::ascii::string(b"suilend_withdraw")
        } else if (arg5 == 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::protocol_navi()) {
            0x1::ascii::string(b"navi_withdraw")
        } else {
            0x1::ascii::string(b"alphalend_withdraw")
        };
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::gas::deduct_gas(arg0, arg3, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::cfg_gas_cost_lending_withdraw(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::config(arg0)), v0, 0x2::clock::timestamp_ms(arg6) / 1000);
        assert!(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::position_owner(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_position(arg0, arg4)) == arg3, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::position_not_owned_by_user());
        let v1 = LendingWithdrawReceipt{
            user        : arg3,
            position_id : arg4,
            protocol    : arg5,
        };
        (0x2::dynamic_object_field::remove<0x2::object::ID, T0>(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::vault_uid_mut(arg0), arg4), v1)
    }

    // decompiled from Move bytecode v7
}

