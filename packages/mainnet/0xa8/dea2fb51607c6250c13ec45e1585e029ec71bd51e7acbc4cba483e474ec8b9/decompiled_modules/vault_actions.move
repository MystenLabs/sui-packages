module 0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault_actions {
    struct VaultCreatedEvent has copy, drop {
        vaultId: 0x2::object::ID,
        createdBy: address,
        typeX: 0x1::type_name::TypeName,
        typeY: 0x1::type_name::TypeName,
    }

    public entry fun process_deposits<T0, T1>(arg0: &0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::VaultCap, arg1: &mut 0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &mut 0x2::coin::TreasuryCap<0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::VAULT>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::process_deposits<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun process_withdrawals<T0, T1>(arg0: &0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::VaultCap, arg1: &mut 0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &mut 0x2::coin::TreasuryCap<0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::VAULT>, arg4: &mut 0x2::tx_context::TxContext) {
        0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::process_withdrawals<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut 0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::add_deposit_request<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1), arg2);
    }

    public entry fun create_vault<T0, T1>(arg0: &0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::new_vault<T0, T1>(arg0, arg1);
        let v2 = v0;
        let v3 = VaultCreatedEvent{
            vaultId   : 0x2::object::id<0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::Vault<T0, T1>>(&v2),
            createdBy : 0x2::tx_context::sender(arg1),
            typeX     : 0x1::type_name::get<T0>(),
            typeY     : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<VaultCreatedEvent>(v3);
        0x2::transfer::public_share_object<0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::Vault<T0, T1>>(v2);
        0x2::transfer::public_transfer<0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::VaultCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun submit_withdrawal_request<T0, T1>(arg0: &mut 0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::VAULT>, arg2: &mut 0x2::tx_context::TxContext) {
        0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::add_withdraw_request<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun whitelist_address_for_deepbook_access<T0, T1>(arg0: &0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::VaultCap, arg1: &mut 0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::Vault<T0, T1>, arg2: address) {
        0xa8dea2fb51607c6250c13ec45e1585e029ec71bd51e7acbc4cba483e474ec8b9::vault::whitelist_address_for_trading<T0, T1>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

