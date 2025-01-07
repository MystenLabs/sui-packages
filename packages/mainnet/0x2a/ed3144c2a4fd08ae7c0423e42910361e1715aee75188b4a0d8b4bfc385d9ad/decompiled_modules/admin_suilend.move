module 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::admin_suilend {
    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_type: 0x1::type_name::TypeName,
        vt_type: 0x1::type_name::TypeName,
    }

    public fun add_swap_route<T0, T1, T2, T3>(arg0: &0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::admin::AdminCap, arg1: &mut 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::add_swap_route<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun new_vault<T0, T1, T2>(arg0: &0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::admin::AdminCap, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::coin::TreasuryCap<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: u8, arg9: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultCreatedEvent{
            vault_id     : 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::new<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11),
            deposit_type : 0x1::type_name::get<T0>(),
            vt_type      : 0x1::type_name::get<T1>(),
        };
        0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::event::emit<VaultCreatedEvent>(v0);
    }

    public fun remove_swap_route<T0, T1, T2, T3>(arg0: &0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::admin::AdminCap, arg1: &mut 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::Vault<T0, T1, T2>) {
        0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::remove_swap_route<T0, T1, T2, T3>(arg1);
    }

    public fun set_deposit_limit<T0, T1, T2>(arg0: &0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::admin::AdminCap, arg1: &mut 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::Vault<T0, T1, T2>, arg2: u64) {
        0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::set_deposit_limit<T0, T1, T2>(arg1, arg2);
    }

    public fun set_deposits_enabled<T0, T1, T2>(arg0: &0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::admin::AdminCap, arg1: &mut 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::Vault<T0, T1, T2>, arg2: bool) {
        0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::set_deposits_enabled<T0, T1, T2>(arg1, arg2);
    }

    public fun set_performance_fees<T0, T1, T2>(arg0: &0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::admin::AdminCap, arg1: &mut 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::Vault<T0, T1, T2>, arg2: u64) {
        0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::set_performance_fees<T0, T1, T2>(arg1, arg2);
    }

    public fun set_withdrawal_fees<T0, T1, T2>(arg0: &0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::admin::AdminCap, arg1: &mut 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::Vault<T0, T1, T2>, arg2: u64) {
        0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::set_withdrawal_fees<T0, T1, T2>(arg1, arg2);
    }

    public fun withdraw_performance_fees<T0, T1, T2>(arg0: &0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::admin::AdminCap, arg1: &mut 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::Vault<T0, T1, T2>, arg2: u64) : 0x2::balance::Balance<T0> {
        0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::withdraw_performance_fees<T0, T1, T2>(arg1, arg2)
    }

    public fun withdraw_withdrawal_fees<T0, T1, T2>(arg0: &0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::admin::AdminCap, arg1: &mut 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::Vault<T0, T1, T2>, arg2: u64) : 0x2::balance::Balance<T0> {
        0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::withdraw_withdrawal_fees<T0, T1, T2>(arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

