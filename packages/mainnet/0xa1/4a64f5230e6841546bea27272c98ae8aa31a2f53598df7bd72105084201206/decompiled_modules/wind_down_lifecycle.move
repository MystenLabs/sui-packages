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
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::begin_wind_down<T0, T1, T2>(arg1);
        let v0 = WindDownStartedEvent{vault_id: 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg1)};
        0x2::event::emit<WindDownStartedEvent>(v0);
    }

    public fun deposit_final_assets<T0: store, T1, T2>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::VaultCap, arg1: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_unwinding<T0, T1, T2>(arg1);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::join_final_assets<T0, T1, T2>(arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun finalize<T0: store, T1, T2>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::VaultCap, arg1: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg3);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_unwinding<T0, T1, T2>(arg1);
        let (v0, v1) = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::info<T0, T1, T2>(arg1, arg2);
        assert!(v0 == 0 && v1 == 0, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::position_not_closed());
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::finalize_wind_down<T0, T1, T2>(arg1);
        let v2 = WindDownFinalizedEvent{
            vault_id        : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg1),
            final_assets    : 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::final_assets<T0, T1, T2>(arg1),
            total_vt_supply : 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::total_vt_supply<T0, T1, T2>(arg1),
        };
        0x2::event::emit<WindDownFinalizedEvent>(v2);
    }

    fun proportional_share(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == arg2) {
            arg0
        } else {
            (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u64)
        }
    }

    public fun withdraw<T0: store, T1, T2>(arg0: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_finalized<T0, T1, T2>(arg0);
        let v0 = 0x2::coin::value<T2>(&arg1);
        let v1 = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::total_vt_supply<T0, T1, T2>(arg0);
        assert!(v0 > 0 && v1 > 0, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::zero_amount());
        let v2 = proportional_share(0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::final_assets<T0, T1, T2>(arg0), v0, v1);
        assert!(v2 >= arg2, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::slippage_exceeded());
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::burn_vt<T0, T1, T2>(arg0, arg1);
        let v3 = FinalWithdrawalEvent{
            vault_id            : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg0),
            user                : 0x2::tx_context::sender(arg3),
            vt_burned           : v0,
            amount_out          : v2,
            remaining_assets    : 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::final_assets<T0, T1, T2>(arg0),
            remaining_vt_supply : 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2::event::emit<FinalWithdrawalEvent>(v3);
        0x2::coin::from_balance<T0>(0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::take_final_assets<T0, T1, T2>(arg0, v2), arg3)
    }

    // decompiled from Move bytecode v7
}

