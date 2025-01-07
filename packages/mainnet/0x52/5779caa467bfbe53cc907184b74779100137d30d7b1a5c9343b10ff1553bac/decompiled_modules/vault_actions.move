module 0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault_actions {
    struct VaultCreatedEvent has copy, drop {
        vaultId: 0x2::object::ID,
        createdBy: address,
        typeX: 0x1::type_name::TypeName,
        typeY: 0x1::type_name::TypeName,
    }

    public entry fun process_deposits<T0, T1>(arg0: &0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::VaultCap, arg1: &mut 0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &mut 0x2::coin::TreasuryCap<0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::VAULT>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::process_deposits<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun process_withdrawals<T0, T1>(arg0: &0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::VaultCap, arg1: &mut 0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &mut 0x2::coin::TreasuryCap<0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::VAULT>, arg4: &mut 0x2::tx_context::TxContext) {
        0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::process_withdrawals<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut 0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::add_deposit_request<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1), arg2);
    }

    public entry fun create_vault<T0, T1>(arg0: &0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::new_vault<T0, T1>(arg0, arg1);
        let v2 = v0;
        let v3 = VaultCreatedEvent{
            vaultId   : 0x2::object::id<0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::Vault<T0, T1>>(&v2),
            createdBy : 0x2::tx_context::sender(arg1),
            typeX     : 0x1::type_name::get<T0>(),
            typeY     : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<VaultCreatedEvent>(v3);
        0x2::transfer::public_share_object<0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::Vault<T0, T1>>(v2);
        0x2::transfer::public_transfer<0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::VaultCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun get_lp_token_share_value<T0, T1>(arg0: &0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::Vault<T0, T1>, arg1: &0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x2::coin::TreasuryCap<0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::VAULT>, arg3: u64) : (u64, u64) {
        0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::calculate_lp_token_share<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public entry fun submit_withdrawal_request<T0, T1>(arg0: &mut 0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::VAULT>, arg2: &mut 0x2::tx_context::TxContext) {
        0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::add_withdraw_request<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun whitelist_address_for_deepbook_access<T0, T1>(arg0: &0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::VaultCap, arg1: &mut 0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::Vault<T0, T1>, arg2: address) {
        0x525779caa467bfbe53cc907184b74779100137d30d7b1a5c9343b10ff1553bac::vault::whitelist_address_for_trading<T0, T1>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

