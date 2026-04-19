module 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::gas {
    public(friend) fun credit_gas_escrow(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: address, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::gas_join(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_gas_pool_mut(arg0), arg2);
        let v1 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, arg1);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::set_gas_escrow(v1, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_gas_escrow(v1) + v0);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::events::emit_gas_deposit(arg1, v0, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_gas_escrow(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account(arg0, arg1)), arg3);
    }

    public(friend) fun deduct_gas(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: address, arg2: u64, arg3: 0x1::ascii::String, arg4: u64) {
        let v0 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, arg1);
        let v1 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_gas_escrow(v0);
        assert!(v1 >= arg2, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::insufficient_gas_escrow());
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::set_gas_escrow(v0, v1 - arg2);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::events::emit_gas_deducted(arg1, arg3, arg2, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_gas_escrow(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account(arg0, arg1)), arg4);
    }

    public(friend) fun refund_reserved_gas(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: address, arg2: u64, arg3: 0x2::object::ID, arg4: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, arg1);
        let v1 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_gas_reserved(v0);
        assert!(v1 >= arg2, 0);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::set_gas_reserved(v0, v1 - arg2);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::set_gas_escrow(v0, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_gas_escrow(v0) + arg2);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::events::emit_gas_released(arg1, arg3, arg2, arg4);
    }

    public(friend) fun release_limit_order_gas(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: address, arg2: u64, arg3: 0x2::object::ID, arg4: u64) {
        let v0 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, arg1);
        let v1 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_gas_reserved(v0);
        assert!(v1 >= arg2, 0);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::set_gas_reserved(v0, v1 - arg2);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::events::emit_gas_released(arg1, arg3, arg2, arg4);
    }

    public(friend) fun reserve_limit_order_gas(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: address, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: u64) : u64 {
        let v0 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, arg1);
        let v1 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_gas_escrow(v0);
        let v2 = arg2 + arg3;
        assert!(v1 >= v2, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::insufficient_gas_escrow());
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::set_gas_escrow(v0, v1 - v2);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::set_gas_reserved(v0, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_gas_reserved(v0) + arg3);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::events::emit_gas_deducted(arg1, 0x1::ascii::string(b"open_limit_order"), arg2, v1 - v2, arg5);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::events::emit_gas_reserved(arg1, arg4, arg3, arg5);
        arg3
    }

    public(friend) fun withdraw_gas_escrow(arg0: &mut 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::Vault, arg1: address, arg2: u64, arg3: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account_mut(arg0, arg1);
        let v1 = 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_gas_escrow(v0);
        assert!(v1 >= arg2, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::errors::insufficient_gas_escrow());
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::set_gas_escrow(v0, v1 - arg2);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::events::emit_gas_withdraw(arg1, arg2, 0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::account_gas_escrow(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_account(arg0, arg1)), arg3);
        0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::pools::gas_split(0x27158ec83407d16d243bcd4e96e4bdaa1aad9d102a87df1fe087d03f0d954f4c::vault_core::borrow_gas_pool_mut(arg0), arg2)
    }

    // decompiled from Move bytecode v7
}

