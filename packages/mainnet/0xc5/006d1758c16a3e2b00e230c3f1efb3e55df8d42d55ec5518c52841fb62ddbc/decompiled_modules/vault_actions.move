module 0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault_actions {
    struct VaultCreatedEvent has copy, drop {
        vaultId: 0x2::object::ID,
        createdBy: address,
        typeX: 0x1::type_name::TypeName,
        typeY: 0x1::type_name::TypeName,
    }

    struct GetLpShareValueEvent has copy, drop {
        vaultId: 0x2::object::ID,
        lpTokenValue: u64,
        baseShare: u64,
        quoteShare: u64,
    }

    public entry fun claim_withdrawal<T0, T1>(arg0: &mut 0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::claim_withdrawal<T0, T1>(arg0, arg1);
    }

    public entry fun process_deposits<T0, T1>(arg0: &0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::VaultCap, arg1: &mut 0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &mut 0x2::coin::TreasuryCap<0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::VAULT>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::process_deposits<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun process_withdrawals<T0, T1>(arg0: &0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::VaultCap, arg1: &mut 0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &mut 0x2::coin::TreasuryCap<0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::VAULT>, arg4: &mut 0x2::tx_context::TxContext) {
        0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::process_withdrawals<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut 0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::add_deposit_request<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1), arg2);
    }

    public entry fun create_vault<T0, T1>(arg0: &0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::new_vault<T0, T1>(arg0, arg1);
        let v2 = v0;
        let v3 = VaultCreatedEvent{
            vaultId   : 0x2::object::id<0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::Vault<T0, T1>>(&v2),
            createdBy : 0x2::tx_context::sender(arg1),
            typeX     : 0x1::type_name::get<T0>(),
            typeY     : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<VaultCreatedEvent>(v3);
        0x2::transfer::public_share_object<0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::Vault<T0, T1>>(v2);
        0x2::transfer::public_transfer<0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::VaultCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun get_lp_token_share_value<T0, T1>(arg0: &0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::Vault<T0, T1>, arg1: &0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x2::coin::TreasuryCap<0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::VAULT>, arg3: u64) : (u64, u64) {
        let (v0, v1) = 0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::calculate_lp_token_share<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = GetLpShareValueEvent{
            vaultId      : 0x2::object::id<0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::Vault<T0, T1>>(arg0),
            lpTokenValue : arg3,
            baseShare    : v0,
            quoteShare   : v1,
        };
        0x2::event::emit<GetLpShareValueEvent>(v2);
        (v0, v1)
    }

    public entry fun submit_withdrawal_request<T0, T1>(arg0: &mut 0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::VAULT>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::add_withdraw_request<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun whitelist_address_for_deepbook_access<T0, T1>(arg0: &0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::VaultCap, arg1: &mut 0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::Vault<T0, T1>, arg2: address) {
        0xc5006d1758c16a3e2b00e230c3f1efb3e55df8d42d55ec5518c52841fb62ddbc::vault::whitelist_address_for_trading<T0, T1>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

