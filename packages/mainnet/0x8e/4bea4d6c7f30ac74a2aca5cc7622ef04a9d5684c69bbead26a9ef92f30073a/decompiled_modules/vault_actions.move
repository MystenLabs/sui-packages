module 0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault_actions {
    struct VaultCreatedEvent has copy, drop {
        vaultId: 0x2::object::ID,
        createdBy: address,
        typeX: 0x1::type_name::TypeName,
        typeY: 0x1::type_name::TypeName,
    }

    public entry fun claim_withdrawal<T0, T1>(arg0: &mut 0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::claim_withdrawal<T0, T1>(arg0, arg1);
    }

    public entry fun get_last_rebalanced_timestamp<T0, T1>(arg0: &0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::Vault<T0, T1>) : u64 {
        0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::get_last_rebalanced_timestamp<T0, T1>(arg0)
    }

    public entry fun get_unprocessed_deposits<T0, T1>(arg0: &0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::Vault<T0, T1>) : u64 {
        0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::get_unprocessed_deposits<T0, T1>(arg0)
    }

    public entry fun get_unprocessed_withdrawals<T0, T1>(arg0: &0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::Vault<T0, T1>, arg1: &0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x2::coin::TreasuryCap<0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::VAULT>) : (u64, u64, u64) {
        0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::get_unprocessed_withdrawals<T0, T1>(arg0, arg1, arg2)
    }

    public entry fun process_deposits<T0, T1>(arg0: &0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::VaultCap, arg1: &mut 0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &mut 0x2::coin::TreasuryCap<0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::VAULT>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::process_deposits<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun process_withdrawals<T0, T1>(arg0: &0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::VaultCap, arg1: &mut 0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &mut 0x2::coin::TreasuryCap<0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::VAULT>, arg4: &mut 0x2::tx_context::TxContext) {
        0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::process_withdrawals<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut 0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::add_deposit_request<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1), arg2);
    }

    public entry fun create_vault<T0, T1>(arg0: &0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::app::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::new_vault<T0, T1>(arg0, arg1, arg2);
        let v2 = v0;
        let v3 = VaultCreatedEvent{
            vaultId   : 0x2::object::id<0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::Vault<T0, T1>>(&v2),
            createdBy : 0x2::tx_context::sender(arg2),
            typeX     : 0x1::type_name::get<T0>(),
            typeY     : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<VaultCreatedEvent>(v3);
        0x2::transfer::public_share_object<0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::Vault<T0, T1>>(v2);
        0x2::transfer::public_transfer<0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::VaultCap>(v1, 0x2::tx_context::sender(arg2));
    }

    public entry fun get_lp_token_share_value<T0, T1>(arg0: &0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::Vault<T0, T1>, arg1: &0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x2::coin::TreasuryCap<0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::VAULT>, arg3: u64) : (u64, u64) {
        0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::calculate_lp_token_share<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public entry fun submit_withdrawal_request<T0, T1>(arg0: &mut 0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::VAULT>, arg2: &mut 0x2::tx_context::TxContext) {
        0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::add_withdraw_request<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun whitelist_address_for_deepbook_access<T0, T1>(arg0: &0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::VaultCap, arg1: &mut 0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::Vault<T0, T1>, arg2: address) {
        0x8e4bea4d6c7f30ac74a2aca5cc7622ef04a9d5684c69bbead26a9ef92f30073a::vault::whitelist_address_for_trading<T0, T1>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

