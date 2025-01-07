module 0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::admin {
    struct VaultCreatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        deposit_type: 0x1::type_name::TypeName,
        borrow_type: 0x1::type_name::TypeName,
        target_leverage: u64,
    }

    public fun add_swap_route<T0, T1, T2, T3>(arg0: &0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::VaultCap, arg1: &mut 0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::add_swap_route<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun collect_performance_fees<T0, T1, T2>(arg0: &0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::VaultCap, arg1: &mut 0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::Vault<T0, T1, T2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2::coin::from_balance<T2>(0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::withdraw_performance_fees<T0, T1, T2>(arg1, arg2), arg3)
    }

    public fun collect_withdrawal_fees<T0, T1, T2>(arg0: &0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::VaultCap, arg1: &mut 0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::Vault<T0, T1, T2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2::coin::from_balance<T0>(0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::withdraw_withdrawal_fees<T0, T1, T2>(arg1, arg2), arg3)
    }

    public fun initialize<T0, T1, T2>(arg0: 0x2::coin::TreasuryCap<T2>, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: u8, arg5: u128, arg6: u128, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultCreatedEvent{
            vault_id        : 0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::initialize<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10),
            pool_id         : arg1,
            deposit_type    : 0x1::type_name::get<T0>(),
            borrow_type     : 0x1::type_name::get<T1>(),
            target_leverage : arg2,
        };
        0x2::event::emit<VaultCreatedEvent>(v0);
    }

    public fun set_deposit_limit<T0, T1, T2>(arg0: &0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::VaultCap, arg1: &mut 0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::Vault<T0, T1, T2>, arg2: u64) {
        0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::set_deposit_limit<T0, T1, T2>(arg1, arg2);
    }

    public fun set_deposits_enabled<T0, T1, T2>(arg0: &0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::VaultCap, arg1: &mut 0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::Vault<T0, T1, T2>, arg2: bool) {
        0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::set_deposits_enabled<T0, T1, T2>(arg1, arg2);
    }

    public fun set_slippage<T0, T1, T2>(arg0: &0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::VaultCap, arg1: &mut 0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::Vault<T0, T1, T2>, arg2: u128, arg3: u128) {
        0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::set_slippage<T0, T1, T2>(arg1, arg2, arg3);
    }

    public fun update_performance_fees<T0, T1, T2>(arg0: &0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::VaultCap, arg1: &mut 0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::Vault<T0, T1, T2>, arg2: u64) {
        0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::update_performance_fees<T0, T1, T2>(arg1, arg2);
    }

    public fun update_withdrawal_fees<T0, T1, T2>(arg0: &0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::VaultCap, arg1: &mut 0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::Vault<T0, T1, T2>, arg2: u64) {
        0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0xa515122dd351f8acf9e4a307fc713e7c21b076d0192c49d3674684a583354a85::vault::update_withdrawal_fees<T0, T1, T2>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

