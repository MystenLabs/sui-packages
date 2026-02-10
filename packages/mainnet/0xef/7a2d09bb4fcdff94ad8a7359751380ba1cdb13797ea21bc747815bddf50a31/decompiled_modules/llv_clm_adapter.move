module 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_clm_adapter {
    public(friend) fun add_shares_to_position<T0>(arg0: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<T0>, arg1: &mut 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::LLVPoolPosition<T0>, arg2: u128, arg3: u128) {
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_deposit::add_to_position<T0>(arg0, arg1, arg2, arg3);
    }

    fun assert_clm_allowed<T0>(arg0: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_admin::LLVGlobal, arg1: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<T0>) {
        validate_for_clm<T0>(arg0, arg1);
    }

    public fun calculate_assets_for_shares<T0>(arg0: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<T0>, arg1: u128) : u128 {
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_math::calculate_assets_for_shares(0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::total_shares<T0>(arg0), 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::get_total_assets<T0>(arg0), arg1)
    }

    public fun calculate_shares_for_deposit<T0>(arg0: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<T0>, arg1: u64) : u128 {
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_math::calculate_shares_with_min(0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::total_shares<T0>(arg0), 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::get_total_assets<T0>(arg0), arg1)
    }

    public fun create_empty_position<T0>(arg0: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::LLVPoolPosition<T0> {
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_deposit::create_position<T0>(arg0, 0, 0, arg1)
    }

    public(friend) fun deduct_shares_from_position<T0>(arg0: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<T0>, arg1: &mut 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::LLVPoolPosition<T0>, arg2: u128, arg3: u128) : u128 {
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_withdraw::deduct_from_position<T0>(arg0, arg1, arg2, arg3)
    }

    public fun deposit_for_clm<T0, T1, T2>(arg0: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_admin::LLVGlobal, arg1: &mut 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<T0>, arg2: &mut 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::LLVPoolPosition<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::market::Hearn, arg5: &mut 0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::meta_vault_core::Vault<T0, T1>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg7: u64, arg8: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: u8, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (u128, u64) {
        assert!(0x2::coin::value<T0>(&arg3) > 0, 2);
        assert!(0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::pool_id<T0>(arg2) == 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::id<T0>(arg1), 1);
        assert_clm_allowed<T0>(arg0, arg1);
        let (v0, v1) = 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_protocol_ops::deposit_to_pool<T0, T1, T2>(arg1, arg3, 0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        let v2 = v0;
        let v3 = 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_deposit::shares_to_mint(&v2);
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_deposit::add_to_position<T0>(arg1, arg2, v3, (v1 as u128));
        (v3, v1)
    }

    public fun deposit_for_clm_sui<T0, T1, T2>(arg0: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_admin::LLVGlobal, arg1: &mut 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<0x2::sui::SUI>, arg2: &mut 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::LLVPoolPosition<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::market::Hearn, arg5: &mut 0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::meta_vault_core::Vault<0x2::sui::SUI, T0>, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg13: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg14: &mut 0x3::sui_system::SuiSystemState, arg15: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg16: u64, arg17: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg18: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg20: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg21: u8, arg22: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg23: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) : (u128, u64) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) > 0, 2);
        assert!(0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::pool_id<0x2::sui::SUI>(arg2) == 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::id<0x2::sui::SUI>(arg1), 1);
        assert_clm_allowed<0x2::sui::SUI>(arg0, arg1);
        let (v0, v1) = 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_protocol_ops::deposit_to_pool_sui<T0, T1, T2>(arg1, arg3, 0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25);
        let v2 = v0;
        let v3 = 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_deposit::shares_to_mint(&v2);
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_deposit::add_to_position<0x2::sui::SUI>(arg1, arg2, v3, (v1 as u128));
        (v3, v1)
    }

    public fun destroy_empty_position<T0>(arg0: 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::LLVPoolPosition<T0>) {
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_withdraw::destroy_empty_position<T0>(arg0);
    }

    public fun get_position_value<T0>(arg0: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<T0>, arg1: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::LLVPoolPosition<T0>) : u128 {
        calculate_assets_for_shares<T0>(arg0, 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::shares<T0>(arg1))
    }

    public fun get_share_price<T0>(arg0: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<T0>) : u128 {
        let v0 = 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::total_shares<T0>(arg0);
        if (v0 == 0) {
            return 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_math::scale()
        };
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_math::mul_div(0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::get_total_assets<T0>(arg0), 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_math::scale(), v0)
    }

    public fun is_position_empty<T0>(arg0: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::LLVPoolPosition<T0>) : bool {
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::is_empty<T0>(arg0)
    }

    public fun sync_and_accrue_all<T0, T1, T2>(arg0: &mut 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<0x2::sui::SUI>, arg1: &0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::market::Hearn, arg2: &0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::meta_vault_core::Vault<0x2::sui::SUI, T0>, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg5: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: u8, arg10: &0x2::clock::Clock) {
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_protocol_ops::sync_all_balances<T0, T1, T2>(arg0, arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::accrue_fees<0x2::sui::SUI>(arg0, 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::get_total_assets<0x2::sui::SUI>(arg0), 0x2::clock::timestamp_ms(arg10));
    }

    public fun sync_and_accrue_l1_l3<T0, T1, T2>(arg0: &mut 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<T0>, arg1: &0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::market::Hearn, arg2: &0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::meta_vault_core::Vault<T0, T1>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u8, arg7: &0x2::clock::Clock) {
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_protocol_ops::sync_l1_l3_balances<T0, T1, T2>(arg0, arg2, arg1, arg3, arg4, arg5, arg6, arg7);
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::accrue_fees<T0>(arg0, 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::get_total_assets<T0>(arg0), 0x2::clock::timestamp_ms(arg7));
    }

    public fun validate_all_protocols_for_clm(arg0: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: 0x2::object::ID, arg10: 0x2::object::ID, arg11: u64, arg12: 0x2::object::ID, arg13: 0x2::object::ID, arg14: u8, arg15: 0x2::object::ID, arg16: 0x2::object::ID, arg17: 0x2::object::ID) {
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_validation::validate_all_protocols(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
    }

    public fun validate_for_clm<T0>(arg0: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_admin::LLVGlobal, arg1: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<T0>) {
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_admin::assert_version(arg0);
        assert!(!0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_admin::is_global_paused(arg0), 100);
        assert!(!0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::is_paused<T0>(arg1), 101);
    }

    public fun validate_position_pool<T0>(arg0: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<T0>, arg1: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::LLVPoolPosition<T0>) {
        assert!(0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::pool_id<T0>(arg1) == 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::id<T0>(arg0), 1);
    }

    public fun validate_protocols_for_clm<T0>(arg0: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: u8, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: 0x2::object::ID) {
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_validation::validate_l1_l3_protocols<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun withdraw_for_clm<T0, T1, T2>(arg0: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_admin::LLVGlobal, arg1: &mut 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<T0>, arg2: &mut 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::LLVPoolPosition<T0>, arg3: u128, arg4: &mut 0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::market::Hearn, arg5: &mut 0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::meta_vault_core::Vault<T0, T1>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg7: u64, arg8: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg9: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg12: u8, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg15: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg16: &mut 0x3::sui_system::SuiSystemState, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u128, u128) {
        assert!(arg3 > 0, 2);
        assert!(0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::pool_id<T0>(arg2) == 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::id<T0>(arg1), 1);
        assert_clm_allowed<T0>(arg0, arg1);
        let (v0, v1, v2, _) = 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_protocol_ops::withdraw_from_pool<T0, T1, T2>(arg1, arg2, arg3, 0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_withdraw::deduct_from_position<T0>(arg1, arg2, v1, v2);
        (0x2::coin::from_balance<T0>(v0, arg18), v1, v2)
    }

    public fun withdraw_for_clm_sui<T0, T1, T2>(arg0: &0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_admin::LLVGlobal, arg1: &mut 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::LLVPool<0x2::sui::SUI>, arg2: &mut 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::LLVPoolPosition<0x2::sui::SUI>, arg3: u128, arg4: &mut 0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::market::Hearn, arg5: &mut 0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::meta_vault_core::Vault<0x2::sui::SUI, T0>, arg6: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg7: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg8: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg9: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg13: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg14: &mut 0x3::sui_system::SuiSystemState, arg15: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg16: u64, arg17: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg18: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg20: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg21: u8, arg22: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg23: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg24: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, u128, u128) {
        assert!(arg3 > 0, 2);
        assert!(0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_position::pool_id<0x2::sui::SUI>(arg2) == 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_pool::id<0x2::sui::SUI>(arg1), 1);
        assert_clm_allowed<0x2::sui::SUI>(arg0, arg1);
        let (v0, v1, v2, _) = 0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_protocol_ops::withdraw_from_pool_sui<T0, T1, T2>(arg1, arg2, arg3, 0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26);
        0xef7a2d09bb4fcdff94ad8a7359751380ba1cdb13797ea21bc747815bddf50a31::llv_withdraw::deduct_from_position<0x2::sui::SUI>(arg1, arg2, v1, v2);
        (0x2::coin::from_balance<0x2::sui::SUI>(v0, arg26), v1, v2)
    }

    // decompiled from Move bytecode v6
}

