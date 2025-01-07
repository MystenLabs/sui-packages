module 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::admin {
    struct VaultCreatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        deposit_type: 0x1::type_name::TypeName,
        borrow_type: 0x1::type_name::TypeName,
        target_leverage: u64,
    }

    public fun add_swap_route<T0, T1, T2, T3>(arg0: &0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::VaultCap, arg1: &mut 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::add_swap_route<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun collect_performance_fees<T0, T1, T2>(arg0: &0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::VaultCap, arg1: &mut 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::Vault<T0, T1, T2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2::coin::from_balance<T2>(0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::withdraw_performance_fees<T0, T1, T2>(arg1, arg2), arg3)
    }

    public fun collect_withdrawal_fees<T0, T1, T2>(arg0: &0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::VaultCap, arg1: &mut 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::Vault<T0, T1, T2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2::coin::from_balance<T0>(0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::withdraw_withdrawal_fees<T0, T1, T2>(arg1, arg2), arg3)
    }

    public fun initialize<T0, T1, T2>(arg0: 0x2::coin::TreasuryCap<T2>, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultCreatedEvent{
            vault_id        : 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::initialize<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8),
            pool_id         : arg1,
            deposit_type    : 0x1::type_name::get<T0>(),
            borrow_type     : 0x1::type_name::get<T1>(),
            target_leverage : arg2,
        };
        0x2::event::emit<VaultCreatedEvent>(v0);
    }

    public fun update_performance_fees<T0, T1, T2>(arg0: &0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::VaultCap, arg1: &mut 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::Vault<T0, T1, T2>, arg2: u64) {
        0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::update_performance_fees<T0, T1, T2>(arg1, arg2);
    }

    public fun update_withdrawal_fees<T0, T1, T2>(arg0: &0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::VaultCap, arg1: &mut 0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::Vault<T0, T1, T2>, arg2: u64) {
        0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0xea74470c6d6774c1e86621c46d8cc874b39a896288e66459abdee863a2bcdae3::vault::update_withdrawal_fees<T0, T1, T2>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

