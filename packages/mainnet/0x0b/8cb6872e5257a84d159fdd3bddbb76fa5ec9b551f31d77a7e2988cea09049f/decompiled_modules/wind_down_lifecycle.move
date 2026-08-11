module 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::wind_down_lifecycle {
    struct WindDownStartedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct WindDownFinalizedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        final_assets: u64,
        total_vt_supply: u64,
    }

    struct FinalWithdrawalEvent has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        vt_burned: u64,
        amount_out: u64,
        remaining_assets: u64,
        remaining_vt_supply: u64,
    }

    public fun begin<T0: store, T1, T2>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::VaultCap, arg1: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg2: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg2);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_begin<T0, T1, T2>(arg0, arg1);
        let v0 = WindDownStartedEvent{vault_id: 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg1)};
        0x2::event::emit<WindDownStartedEvent>(v0);
    }

    public fun begin_v2<T0, T1, T2>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::VaultCap, arg1: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg2: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg2);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_begin_v2<T0, T1, T2>(arg0, arg1);
        let v0 = WindDownStartedEvent{vault_id: 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg1)};
        0x2::event::emit<WindDownStartedEvent>(v0);
    }

    public fun deposit_final_assets<T0: store, T1, T2>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::VaultCap, arg1: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_deposit_final_assets<T0, T1, T2>(arg0, arg1, arg2);
    }

    public fun deposit_final_assets_v2<T0, T1, T2>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::VaultCap, arg1: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_deposit_final_assets_v2<T0, T1, T2>(arg0, arg1, arg2);
    }

    public fun finalize<T0: store, T1, T2>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::VaultCap, arg1: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg3);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_finalize<T0, T1, T2>(arg0, arg1, arg2);
        let v0 = WindDownFinalizedEvent{
            vault_id        : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg1),
            final_assets    : 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::final_assets<T0, T1, T2>(arg1),
            total_vt_supply : 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::total_vt_supply<T0, T1, T2>(arg1),
        };
        0x2::event::emit<WindDownFinalizedEvent>(v0);
    }

    public fun finalize_v2<T0, T1, T2>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::VaultCap, arg1: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg3);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_finalize_v2<T0, T1, T2>(arg0, arg1, arg2);
        let v0 = WindDownFinalizedEvent{
            vault_id        : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg1),
            final_assets    : 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::final_assets_v2<T0, T1, T2>(arg1),
            total_vt_supply : 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::total_vt_supply<T0, T1, T2>(arg1),
        };
        0x2::event::emit<WindDownFinalizedEvent>(v0);
    }

    public fun withdraw<T0: store, T1, T2>(arg0: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_final_withdraw<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = FinalWithdrawalEvent{
            vault_id            : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg0),
            user                : 0x2::tx_context::sender(arg3),
            vt_burned           : 0x2::coin::value<T2>(&arg1),
            amount_out          : 0x2::coin::value<T0>(&v0),
            remaining_assets    : 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::final_assets<T0, T1, T2>(arg0),
            remaining_vt_supply : 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2::event::emit<FinalWithdrawalEvent>(v1);
        v0
    }

    public fun withdraw_v2<T0, T1, T2>(arg0: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_final_withdraw_v2<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = FinalWithdrawalEvent{
            vault_id            : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg0),
            user                : 0x2::tx_context::sender(arg3),
            vt_burned           : 0x2::coin::value<T2>(&arg1),
            amount_out          : 0x2::coin::value<T0>(&v0),
            remaining_assets    : 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::final_assets_v2<T0, T1, T2>(arg0),
            remaining_vt_supply : 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2::event::emit<FinalWithdrawalEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

