module 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_user_entry_all {
    public fun get_min_deposit<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<T0>) : u64 {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::get_min_deposit<T0>(arg0)
    }

    public fun get_protocol_balance<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<T0>, arg1: u8) : u128 {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::get_protocol_balance<T0>(arg0, arg1)
    }

    public fun get_protocol_ratio<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<T0>, arg1: u8) : u64 {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::get_protocol_ratio<T0>(arg0, arg1)
    }

    public fun is_protocol_enabled<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<T0>, arg1: u8) : bool {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::is_protocol_enabled<T0>(arg0, arg1)
    }

    public entry fun deposit<T0, T1, T2>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_admin::LLVGlobal, arg1: &mut 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u128, arg4: &mut 0xaa9b861f68083abba8e589eec665c272d2d4ee1fe0a25435db36aeeaa05e409b::market::Hearn, arg5: &mut 0xaa9b861f68083abba8e589eec665c272d2d4ee1fe0a25435db36aeeaa05e409b::meta_vault_core::Vault<T0, T1>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg7: u64, arg8: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: u8, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_admin::assert_version(arg0);
        assert!(!0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_admin::is_global_paused(arg0), 5);
        assert!(!0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::is_paused<T0>(arg1), 1);
        assert!(0x2::coin::value<T0>(&arg2) > 0, 2);
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_validation::validate_l1_l3_protocols<T0>(arg1, 0x2::object::id<0xaa9b861f68083abba8e589eec665c272d2d4ee1fe0a25435db36aeeaa05e409b::meta_vault_core::Vault<T0, T1>>(arg5), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>>(arg6), arg7, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg9), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg10), arg12, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>>(arg11), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg13), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg14));
        let (v0, v1) = 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_protocol_ops::deposit_to_pool<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        let v2 = v0;
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_deposit::mint_position_and_emit<T0>(arg1, &v2, 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_deposit::allocation(&v2), 0x2::tx_context::sender(arg16), v1, 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_deposit::shares_to_mint(&v2), arg15, arg16);
    }

    public entry fun deposit_sui<T0, T1, T2>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_admin::LLVGlobal, arg1: &mut 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u128, arg4: &mut 0xaa9b861f68083abba8e589eec665c272d2d4ee1fe0a25435db36aeeaa05e409b::market::Hearn, arg5: &mut 0xaa9b861f68083abba8e589eec665c272d2d4ee1fe0a25435db36aeeaa05e409b::meta_vault_core::Vault<0x2::sui::SUI, T0>, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg13: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg14: &mut 0x3::sui_system::SuiSystemState, arg15: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg16: u64, arg17: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg18: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg20: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg21: u8, arg22: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg23: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_admin::assert_version(arg0);
        assert!(!0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_admin::is_global_paused(arg0), 5);
        assert!(!0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::is_paused<0x2::sui::SUI>(arg1), 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) > 0, 2);
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_validation::validate_all_protocols(arg1, 0x2::object::id<0xaa9b861f68083abba8e589eec665c272d2d4ee1fe0a25435db36aeeaa05e409b::meta_vault_core::Vault<0x2::sui::SUI, T0>>(arg5), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>>(arg7), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg6), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg8), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg9), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg10), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg11), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg12), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg13), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>>(arg15), arg16, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg18), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg19), arg21, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>>(arg20), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg22), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg23));
        let (v0, v1) = 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_protocol_ops::deposit_to_pool_sui<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25);
        let v2 = v0;
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_deposit::mint_position_and_emit<0x2::sui::SUI>(arg1, &v2, 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_deposit::allocation(&v2), 0x2::tx_context::sender(arg25), v1, 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_deposit::shares_to_mint(&v2), arg24, arg25);
    }

    public fun destroy_empty_position<T0>(arg0: 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::LLVPoolPosition<T0>) {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_withdraw::destroy_empty_position<T0>(arg0);
    }

    public fun estimate_position_profit<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<T0>, arg1: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::LLVPoolPosition<T0>) : (u128, bool) {
        let v0 = estimate_position_value<T0>(arg0, arg1);
        let v1 = 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::deposited_assets<T0>(arg1);
        if (v0 >= v1) {
            (v0 - v1, true)
        } else {
            (v1 - v0, false)
        }
    }

    public fun estimate_position_value<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<T0>, arg1: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::LLVPoolPosition<T0>) : u128 {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_math::calculate_assets_for_shares(0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::total_shares<T0>(arg0), 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::get_total_assets<T0>(arg0), 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::shares<T0>(arg1))
    }

    fun finalize_withdraw<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<T0>, arg1: 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::LLVPoolPosition<T0>, arg2: 0x2::balance::Balance<T0>, arg3: u128, arg4: u128, arg5: vector<0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_allocation_plan::ProtocolAmount>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_events::emit_withdrawn(0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::id<T0>(arg0), 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::id<T0>(&arg1), 0x2::tx_context::sender(arg7), arg3, (arg4 as u64), arg5, 0x2::clock::timestamp_ms(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg2, arg7), 0x2::tx_context::sender(arg7));
        if (0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_withdraw::deduct_from_position<T0>(arg0, &mut arg1, arg3, arg4) == 0) {
            0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_withdraw::destroy_empty_position<T0>(arg1);
        } else {
            0x2::transfer::public_transfer<0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::LLVPoolPosition<T0>>(arg1, 0x2::tx_context::sender(arg7));
        };
    }

    public fun is_pool_paused<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<T0>) : bool {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::is_paused<T0>(arg0)
    }

    public fun is_position_empty<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::LLVPoolPosition<T0>) : bool {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::is_empty<T0>(arg0)
    }

    public fun pool_total_assets<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<T0>) : u128 {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::get_total_assets<T0>(arg0)
    }

    public fun pool_total_shares<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<T0>) : u128 {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::total_shares<T0>(arg0)
    }

    public fun pool_yield_index<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<T0>) : u128 {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::global_yield_index<T0>(arg0)
    }

    public fun position_deposited_assets<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::LLVPoolPosition<T0>) : u128 {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::deposited_assets<T0>(arg0)
    }

    public fun position_shares<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::LLVPoolPosition<T0>) : u128 {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::shares<T0>(arg0)
    }

    public fun preview_deposit<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<T0>, arg1: u64) : (u128, vector<0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_deposit::calculate_deposit<T0>(arg0, arg1);
        (0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_deposit::shares_to_mint(&v0), *0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_deposit::allocation(&v0))
    }

    public fun preview_withdraw_all<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<T0>, arg1: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::LLVPoolPosition<T0>) : (u128, u128, vector<0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_withdraw::calculate_withdraw_all<T0>(arg0, arg1);
        (0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_withdraw::shares_to_burn(&v0), 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_withdraw::assets_to_receive(&v0), *0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_withdraw::recall_plan(&v0))
    }

    public fun preview_withdraw_by_assets<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<T0>, arg1: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::LLVPoolPosition<T0>, arg2: u64) : (u128, vector<0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_withdraw::calculate_withdraw_by_assets<T0>(arg0, arg1, arg2);
        (0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_withdraw::shares_to_burn(&v0), *0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_withdraw::recall_plan(&v0))
    }

    public fun preview_withdraw_by_shares<T0>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<T0>, arg1: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::LLVPoolPosition<T0>, arg2: u128) : (u128, vector<0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_withdraw::calculate_withdraw_by_shares<T0>(arg0, arg1, arg2);
        (0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_withdraw::assets_to_receive(&v0), *0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_withdraw::recall_plan(&v0))
    }

    public entry fun withdraw<T0, T1, T2>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_admin::LLVGlobal, arg1: &mut 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<T0>, arg2: 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::LLVPoolPosition<T0>, arg3: u128, arg4: u64, arg5: &mut 0xaa9b861f68083abba8e589eec665c272d2d4ee1fe0a25435db36aeeaa05e409b::market::Hearn, arg6: &mut 0xaa9b861f68083abba8e589eec665c272d2d4ee1fe0a25435db36aeeaa05e409b::meta_vault_core::Vault<T0, T1>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg8: u64, arg9: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg10: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg13: u8, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg17: &mut 0x3::sui_system::SuiSystemState, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_admin::assert_version(arg0);
        assert!(!0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_admin::is_global_paused(arg0), 5);
        assert!(!0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::is_paused<T0>(arg1), 1);
        assert!(arg3 > 0, 2);
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_validation::validate_l1_l3_protocols<T0>(arg1, 0x2::object::id<0xaa9b861f68083abba8e589eec665c272d2d4ee1fe0a25435db36aeeaa05e409b::meta_vault_core::Vault<T0, T1>>(arg6), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>>(arg7), arg8, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg10), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg11), arg13, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>>(arg12), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg14), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg15));
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_validation::validate_navi_oracle<T0>(arg1, 0x2::object::id<0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle>(arg16));
        let (v0, v1, v2, v3) = 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_protocol_ops::withdraw_from_pool<T0, T1, T2>(arg1, &arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
        finalize_withdraw<T0>(arg1, arg2, v0, v1, v2, v3, arg18, arg19);
    }

    public entry fun withdraw_sui<T0, T1, T2>(arg0: &0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_admin::LLVGlobal, arg1: &mut 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::LLVPool<0x2::sui::SUI>, arg2: 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_position::LLVPoolPosition<0x2::sui::SUI>, arg3: u128, arg4: u64, arg5: &mut 0xaa9b861f68083abba8e589eec665c272d2d4ee1fe0a25435db36aeeaa05e409b::market::Hearn, arg6: &mut 0xaa9b861f68083abba8e589eec665c272d2d4ee1fe0a25435db36aeeaa05e409b::meta_vault_core::Vault<0x2::sui::SUI, T0>, arg7: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg8: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg9: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg10: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg11: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg14: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg15: &mut 0x3::sui_system::SuiSystemState, arg16: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg17: u64, arg18: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg19: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg20: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg21: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg22: u8, arg23: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg24: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg25: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg26: &0x2::clock::Clock, arg27: &mut 0x2::tx_context::TxContext) {
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_admin::assert_version(arg0);
        assert!(!0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_admin::is_global_paused(arg0), 5);
        assert!(!0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_pool::is_paused<0x2::sui::SUI>(arg1), 1);
        assert!(arg3 > 0, 2);
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_validation::validate_all_protocols(arg1, 0x2::object::id<0xaa9b861f68083abba8e589eec665c272d2d4ee1fe0a25435db36aeeaa05e409b::meta_vault_core::Vault<0x2::sui::SUI, T0>>(arg6), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>>(arg8), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg7), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg9), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg10), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg11), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg12), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg13), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg14), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>>(arg16), arg17, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg19), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg20), arg22, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>>(arg21), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg23), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg24));
        0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_validation::validate_navi_oracle<0x2::sui::SUI>(arg1, 0x2::object::id<0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle>(arg25));
        let (v0, v1, v2, v3) = 0xe74de2288a82c266e0f106961307c0f8a48589b1a09bee9c5a122637e9db0e61::llv_protocol_ops::withdraw_from_pool_sui<T0, T1, T2>(arg1, &arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27);
        finalize_withdraw<0x2::sui::SUI>(arg1, arg2, v0, v1, v2, v3, arg26, arg27);
    }

    // decompiled from Move bytecode v6
}

