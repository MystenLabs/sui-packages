module 0x50af6aacd792f05276dc0e3ef9c3461d4b14d453c2d39c07c184dc9a5769dced::admin {
    struct VaultCreatedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        deposit_type: 0x1::type_name::TypeName,
        borrow_type: 0x1::type_name::TypeName,
        target_leverage: u8,
    }

    public fun add_swap_route<T0, T1, T2, T3>(arg0: &0x50af6aacd792f05276dc0e3ef9c3461d4b14d453c2d39c07c184dc9a5769dced::vault::VaultCap, arg1: &mut 0x50af6aacd792f05276dc0e3ef9c3461d4b14d453c2d39c07c184dc9a5769dced::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        0x50af6aacd792f05276dc0e3ef9c3461d4b14d453c2d39c07c184dc9a5769dced::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x50af6aacd792f05276dc0e3ef9c3461d4b14d453c2d39c07c184dc9a5769dced::vault::add_swap_route<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun collect_withdrawal_fees<T0, T1, T2>(arg0: &0x50af6aacd792f05276dc0e3ef9c3461d4b14d453c2d39c07c184dc9a5769dced::vault::VaultCap, arg1: &mut 0x50af6aacd792f05276dc0e3ef9c3461d4b14d453c2d39c07c184dc9a5769dced::vault::Vault<T0, T1, T2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x50af6aacd792f05276dc0e3ef9c3461d4b14d453c2d39c07c184dc9a5769dced::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2::coin::from_balance<T0>(0x50af6aacd792f05276dc0e3ef9c3461d4b14d453c2d39c07c184dc9a5769dced::vault::withdraw_fees<T0, T1, T2>(arg1, arg2), arg3)
    }

    public fun initialize<T0, T1, T2>(arg0: 0x2::coin::TreasuryCap<T2>, arg1: 0x2::object::ID, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultCreatedEvent{
            vault_id        : 0x50af6aacd792f05276dc0e3ef9c3461d4b14d453c2d39c07c184dc9a5769dced::vault::initialize<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6),
            pool_id         : arg1,
            deposit_type    : 0x1::type_name::get<T0>(),
            borrow_type     : 0x1::type_name::get<T1>(),
            target_leverage : arg2,
        };
        0x2::event::emit<VaultCreatedEvent>(v0);
    }

    public fun update_withdrawal_fees<T0, T1, T2>(arg0: &0x50af6aacd792f05276dc0e3ef9c3461d4b14d453c2d39c07c184dc9a5769dced::vault::VaultCap, arg1: &mut 0x50af6aacd792f05276dc0e3ef9c3461d4b14d453c2d39c07c184dc9a5769dced::vault::Vault<T0, T1, T2>, arg2: u64) {
        0x50af6aacd792f05276dc0e3ef9c3461d4b14d453c2d39c07c184dc9a5769dced::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x50af6aacd792f05276dc0e3ef9c3461d4b14d453c2d39c07c184dc9a5769dced::vault::update_withdrawal_fees<T0, T1, T2>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

