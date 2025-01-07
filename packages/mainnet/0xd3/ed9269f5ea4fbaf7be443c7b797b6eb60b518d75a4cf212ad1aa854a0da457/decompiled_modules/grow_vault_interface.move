module 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault_interface {
    public fun actuate_alt_assets<T0, T1, T2>(arg0: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap, arg1: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::GrowVault<T0, T1>, arg2: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::lending_assets::LendingParams<T0, T1, T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::Version) {
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::assert_current_version(arg5);
        let v0 = 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::lending_assets::total_lending_assets<T0, T1, T2>(arg1, arg2) + 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::alternative_assets<T0, T1>(arg1);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::update_assets<T0, T1>(arg1, v0, v0 + arg3, unrealized_gains<T0, T1>(arg1, arg4), arg4);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::update_alt_assets<T0, T1>(arg1, arg3);
    }

    public fun compound<T0, T1, T2>(arg0: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap, arg1: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::GrowVault<T0, T1>, arg2: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::vault_reserve::VaultReserve<T0, T1>, arg3: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::lending_assets::LendingParams<T0, T1, T2>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::Version) : 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::SessionFlow<T0, T1> {
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::assert_current_version(arg6);
        let v0 = 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::lending_assets::total_lending_assets<T0, T1, T2>(arg1, arg3) + 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::alternative_assets<T0, T1>(arg1);
        let v1 = 0x2::coin::value<T0>(&arg4);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::vault_reserve::deposit<T0, T1>(arg2, arg4);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::update_assets<T0, T1>(arg1, v0, v0 + v1, unrealized_gains<T0, T1>(arg1, arg5), arg5);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::events::assets_compounded(0x2::object::id_address<0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::GrowVault<T0, T1>>(arg1), v1);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::create_session<T0, T1>(0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::deposit_kind(), v1)
    }

    public fun finalize_deposit<T0, T1, T2>(arg0: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::GrowVault<T0, T1>, arg1: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::SessionFlow<T0, T1>, arg2: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::lending_assets::LendingParams<T0, T1, T2>, arg3: &0x2::clock::Clock, arg4: &0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::assert_current_version(arg4);
        assert!(0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::done<T0, T1>(arg1) == true, 9223372273077977089);
        let v0 = 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::value<T0, T1>(arg1);
        if (!0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::to_lending_pool<T0, T1>(arg1)) {
            0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::update_alt_assets<T0, T1>(arg0, 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::alternative_assets<T0, T1>(arg0) + v0);
        };
        let v1 = 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::convert_to_shares(v0, 0x2::coin::total_supply<T1>(0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::treasury_cap<T0, T1>(arg0)), total_assets<T0, T1, T2>(arg0, arg2, arg3) - v0);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::events::deposit(0x2::object::id_address<0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::GrowVault<T0, T1>>(arg0), v0, v1, 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::to_lending_pool<T0, T1>(arg1), 0x2::tx_context::sender(arg5));
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::allow_consoom<T0, T1>(arg1);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::mint<T0, T1>(arg0, v1, arg5)
    }

    public fun finalize_withdrawal<T0, T1>(arg0: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::GrowVault<T0, T1>, arg1: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::vault_reserve::VaultReserve<T0, T1>, arg2: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::SessionFlow<T0, T1>, arg3: &0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::assert_current_version(arg3);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::assert_withdrawal<T0, T1>(arg2);
        assert!(0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::done<T0, T1>(arg2) == true, 9223372599495622659);
        let v0 = 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::value<T0, T1>(arg2);
        assert!(v0 == 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::vault_reserve::value<T0, T1>(arg1), 9223372616675753991);
        if (!0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::from_lending_pool<T0, T1>(arg2)) {
            0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::update_alt_assets<T0, T1>(arg0, 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::alternative_assets<T0, T1>(arg0) - v0);
        };
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::events::withdraw(0x2::object::id_address<0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::GrowVault<T0, T1>>(arg0), v0, 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::from_lending_pool<T0, T1>(arg2), 0x2::tx_context::sender(arg4));
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::allow_consoom<T0, T1>(arg2);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::vault_reserve::withdraw<T0, T1>(arg1, arg4)
    }

    public fun initiate_deposit<T0, T1>(arg0: &0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::GrowVault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::vault_reserve::VaultReserve<T0, T1>, arg3: &0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::Version) : 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::SessionFlow<T0, T1> {
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::assert_current_version(arg3);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::vault_reserve::deposit<T0, T1>(arg2, arg1);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::create_session<T0, T1>(0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::deposit_kind(), 0x2::coin::value<T0>(&arg1))
    }

    public fun initiate_withdraw<T0, T1, T2>(arg0: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::GrowVault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::lending_assets::LendingParams<T0, T1, T2>, arg3: &0x2::clock::Clock, arg4: &0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::Version) : 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::SessionFlow<T0, T1> {
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::assert_current_version(arg4);
        let v0 = 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::convert_to_assets(0x2::coin::value<T1>(&arg1), 0x2::coin::total_supply<T1>(0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::treasury_cap<T0, T1>(arg0)), total_assets<T0, T1, T2>(arg0, arg2, arg3));
        let v1 = v0;
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::burn<T0, T1>(arg0, arg1);
        if (0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::withdrawal_fee_bps<T0, T1>(arg0) > 0) {
            v1 = v0 * (10000 - 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::withdrawal_fee_bps<T0, T1>(arg0)) / 10000;
        };
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::create_session<T0, T1>(0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::withdrawal_kind(), v1)
    }

    public fun register_move<T0, T1>(arg0: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap, arg1: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::GrowVault<T0, T1>, arg2: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::SessionFlow<T0, T1>, arg3: &0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::Version) {
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::assert_current_version(arg3);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::assert_move<T0, T1>(arg2);
        assert!(0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::done<T0, T1>(arg2), 9223372749819609093);
        if (0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::from_lending_pool<T0, T1>(arg2) && !0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::to_lending_pool<T0, T1>(arg2)) {
            0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::update_alt_assets<T0, T1>(arg1, 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::alternative_assets<T0, T1>(arg1) + 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::value<T0, T1>(arg2));
        } else if (0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::to_lending_pool<T0, T1>(arg2) && !0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::from_lending_pool<T0, T1>(arg2)) {
            0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::update_alt_assets<T0, T1>(arg1, 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::alternative_assets<T0, T1>(arg1) - 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::value<T0, T1>(arg2));
        };
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::session_flow::allow_consoom<T0, T1>(arg2);
    }

    public fun take_fees<T0, T1, T2>(arg0: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap, arg1: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::GrowVault<T0, T1>, arg2: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::lending_assets::LendingParams<T0, T1, T2>, arg3: &0x2::clock::Clock, arg4: &0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::version::assert_current_version(arg4);
        let v0 = total_assets<T0, T1, T2>(arg1, arg2, arg3);
        let (v1, v2, v3) = 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::compute_fees<T0, T1>(arg1, v0, arg3);
        if (v3 == 0) {
            return 0x2::coin::zero<T1>(arg5)
        };
        let v4 = 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::convert_to_shares(v1 + v2, 0x2::coin::total_supply<T1>(0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::treasury_cap<T0, T1>(arg1)), v0);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::update_fee_checkpoint<T0, T1>(arg1, v0, arg3);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::events::fees_taken(0x2::object::id_address<0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::GrowVault<T0, T1>>(arg1), v1, v2, v4);
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::mint<T0, T1>(arg1, v4, arg5)
    }

    public fun total_assets<T0, T1, T2>(arg0: &0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::GrowVault<T0, T1>, arg1: &mut 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::lending_assets::LendingParams<T0, T1, T2>, arg2: &0x2::clock::Clock) : u64 {
        0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::alternative_assets<T0, T1>(arg0) + 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::lending_assets::total_lending_assets<T0, T1, T2>(arg0, arg1) - unrealized_gains<T0, T1>(arg0, arg2)
    }

    public fun unrealized_gains<T0, T1>(arg0: &0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::GrowVault<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        if (0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::last_update_ms<T0, T1>(arg0) + 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::cooldown_time_ms<T0, T1>(arg0) > 0x2::clock::timestamp_ms(arg1)) {
            0
        } else {
            0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::anticipated_profits<T0, T1>(arg0) - 1000000000 * 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::anticipated_profits<T0, T1>(arg0) * (0x2::clock::timestamp_ms(arg1) - 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::last_update_ms<T0, T1>(arg0)) / 0xd3ed9269f5ea4fbaf7be443c7b797b6eb60b518d75a4cf212ad1aa854a0da457::grow_vault::cooldown_time_ms<T0, T1>(arg0) / 1000000000
        }
    }

    // decompiled from Move bytecode v6
}

