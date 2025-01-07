module 0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault_actions {
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

    public entry fun claim_withdrawal<T0, T1>(arg0: &mut 0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::claim_withdrawal<T0, T1>(arg0, arg1);
    }

    public entry fun get_last_rebalanced_timestamp<T0, T1>(arg0: &0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::Vault<T0, T1>) : u64 {
        0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::get_last_rebalanced_timestamp<T0, T1>(arg0)
    }

    public entry fun get_unprocessed_deposits<T0, T1>(arg0: &0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::Vault<T0, T1>) : u64 {
        0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::get_unprocessed_deposits<T0, T1>(arg0)
    }

    public entry fun get_unprocessed_withdrawals<T0, T1>(arg0: &0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::Vault<T0, T1>, arg1: &0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x2::coin::TreasuryCap<0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::VAULT>) : (u64, u64, u64) {
        0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::get_unprocessed_withdrawals<T0, T1>(arg0, arg1, arg2)
    }

    public entry fun process_deposits<T0, T1>(arg0: &0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::VaultCap, arg1: &mut 0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &mut 0x2::coin::TreasuryCap<0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::VAULT>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::process_deposits<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun process_withdrawals<T0, T1>(arg0: &0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::VaultCap, arg1: &mut 0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &mut 0x2::coin::TreasuryCap<0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::VAULT>, arg4: &mut 0x2::tx_context::TxContext) {
        0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::process_withdrawals<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut 0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::add_deposit_request<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1), arg2);
    }

    public entry fun create_vault<T0, T1>(arg0: &0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::app::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::new_vault<T0, T1>(arg0, arg1, arg2);
        let v2 = v0;
        let v3 = VaultCreatedEvent{
            vaultId   : 0x2::object::id<0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::Vault<T0, T1>>(&v2),
            createdBy : 0x2::tx_context::sender(arg2),
            typeX     : 0x1::type_name::get<T0>(),
            typeY     : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<VaultCreatedEvent>(v3);
        0x2::transfer::public_share_object<0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::Vault<T0, T1>>(v2);
        0x2::transfer::public_transfer<0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::VaultCap>(v1, 0x2::tx_context::sender(arg2));
    }

    public entry fun get_lp_token_share_value<T0, T1>(arg0: &0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::Vault<T0, T1>, arg1: &0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x2::coin::TreasuryCap<0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::VAULT>, arg3: u64) : (u64, u64) {
        let (v0, v1) = 0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::calculate_lp_token_share<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = GetLpShareValueEvent{
            vaultId      : 0x2::object::id<0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::Vault<T0, T1>>(arg0),
            lpTokenValue : arg3,
            baseShare    : v0,
            quoteShare   : v1,
        };
        0x2::event::emit<GetLpShareValueEvent>(v2);
        (v0, v1)
    }

    public entry fun submit_withdrawal_request<T0, T1>(arg0: &mut 0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::VAULT>, arg2: &mut 0x2::tx_context::TxContext) {
        0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::add_withdraw_request<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun whitelist_address_for_deepbook_access<T0, T1>(arg0: &0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::VaultCap, arg1: &mut 0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::Vault<T0, T1>, arg2: address) {
        0x9bd5830026c24d06ec255741074275b267e07319f62d503aefccb8b0f7d44ee3::vault::whitelist_address_for_trading<T0, T1>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

