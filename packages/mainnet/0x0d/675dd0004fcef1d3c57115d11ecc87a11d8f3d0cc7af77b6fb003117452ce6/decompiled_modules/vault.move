module 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::vault {
    public fun transfer<T0>(arg0: &mut 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::Vault, arg1: &mut 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::vault_owner(arg0) == 0x2::tx_context::sender(arg3), 0);
        let v0 = withdraw_internal<T0>(arg0, arg2, arg3);
        deposit_internal<T0>(arg1, v0);
        0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::events::emit_transfer<T0>(0x2::object::id_address<0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::Vault>(arg0), 0x2::object::id_address<0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::Vault>(arg1), arg2);
    }

    public fun create_agent_cap(arg0: &mut 0x2::tx_context::TxContext) {
        0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::create_agent_cap(0x2::tx_context::sender(arg0), arg0);
    }

    public fun create_vault(arg0: &mut 0x2::tx_context::TxContext) {
        0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::create_vault(0x2::tx_context::sender(arg0), arg0);
    }

    public fun vault_owner(arg0: &0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::Vault) : address {
        0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::vault_owner(arg0)
    }

    public fun deposit<T0>(arg0: &mut 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::borrow_mut_balances(arg0);
        let v1 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(v0, v1)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v0, v1, 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v0, v1), 0x2::coin::into_balance<T0>(arg1));
        };
        0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::events::emit_deposit<T0>(0x2::object::id_address<0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::Vault>(arg0), 0x2::tx_context::sender(arg2), 0x2::coin::value<T0>(&arg1));
    }

    public(friend) fun deposit_internal<T0>(arg0: &mut 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::Vault, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::borrow_mut_balances(arg0);
        let v1 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(v0, v1)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v0, v1, 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v0, v1), 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun withdraw<T0>(arg0: &mut 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::vault_owner(arg0) == v0, 0);
        let v1 = withdraw_internal<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0);
        0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::events::emit_withdraw<T0>(0x2::object::id_address<0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::Vault>(arg0), v0, arg1);
    }

    public(friend) fun withdraw_internal<T0>(arg0: &mut 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::borrow_mut_balances(arg0);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(v0, v1), 1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v0, v1), arg1), arg2)
    }

    // decompiled from Move bytecode v7
}

