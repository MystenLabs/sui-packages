module 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::wind_down {
    struct WindDownStartedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct PositionClosedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        debt_repaid: u64,
        collateral_withdrawn: u64,
        flash_swap_repayment: u64,
        final_assets: u64,
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

    struct RewardStoredEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        total_stored: u64,
        sender: address,
    }

    struct RewardClaimedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        harvest_cap_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct RewardSettledEvent has copy, drop {
        vault_id: 0x2::object::ID,
        harvest_cap_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_amount: u64,
        sender: address,
    }

    public fun begin<T0: store, T1, T2>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::VaultCap, arg1: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg2: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg2);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::begin_wind_down<T0, T1, T2>(arg1);
        let v0 = WindDownStartedEvent{vault_id: 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg1)};
        0x2::event::emit<WindDownStartedEvent>(v0);
    }

    public fun claim_stored_reward<T0, T1, T2, T3>(arg0: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg1: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::HarvestCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::take_wind_down_reward<T0, T1, T2, T3>(arg0, arg1, arg2);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = RewardClaimedEvent{
            vault_id       : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg0),
            harvest_cap_id : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::HarvestCap>(arg1),
            reward_type    : 0x1::type_name::get<T3>(),
            amount         : 0x2::balance::value<T3>(&v0),
            recipient      : v1,
        };
        0x2::event::emit<RewardClaimedEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v0, arg2), v1);
    }

    public fun collect_reward<T0, T1, T2, T3>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::VaultCap, arg1: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg2: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg3: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg4: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &0x2::clock::Clock, arg7: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg7);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_unwinding<T0, T1, T2>(arg1);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_vault_obligation<T0, T1, T2>(arg1, arg5);
        let v0 = 0x2::coin::into_balance<T3>(0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::redeem_rewards<T3>(arg2, arg3, arg4, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::obligation_key_mut<T0, T1, T2>(arg1), arg5, arg6, arg8));
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::store_wind_down_reward<T0, T1, T2, T3>(arg1, v0);
        let v1 = RewardStoredEvent{
            vault_id     : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg1),
            reward_type  : 0x1::type_name::get<T3>(),
            amount       : 0x2::balance::value<T3>(&v0),
            total_stored : 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::stored_wind_down_reward<T0, T1, T2, T3>(arg1),
            sender       : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<RewardStoredEvent>(v1);
    }

    public fun consume_finalized_reward_swap<T0: store, T1, T2, T3>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::HarvestCap, arg1: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg2: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg3: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::VaultAcl, arg4: u64, arg5: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg5);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_finalized<T0, T1, T2>(arg2);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_harvest_cap<T0, T1, T2>(arg2, arg0, arg6);
        let v0 = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::access(arg3);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut arg1, v0, b"flow_id") == 6, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::invalid_flow_id());
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut arg1, v0, b"vault_id");
        assert!(v1 == 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg2), 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::invalid_vault());
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut arg1, v0, b"funds");
        let v3 = 0x2::coin::value<T0>(&v2);
        assert!(v3 >= arg4, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::slippage_exceeded());
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::join_settled_reward_a<T0, T1, T2>(arg2, 0x2::coin::into_balance<T0>(v2));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut arg1, v0, b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut arg1, v0, b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg1);
        let v4 = RewardSettledEvent{
            vault_id       : v1,
            harvest_cap_id : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::HarvestCap>(arg0),
            reward_type    : 0x1::type_name::get<T3>(),
            input_amount   : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut arg1, v0, b"input_amount"),
            output_amount  : v3,
            sender         : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<RewardSettledEvent>(v4);
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

    public fun issue_close_position_receipt<T0, T1, T2>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::VaultCap, arg1: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::VaultAcl, arg5: &0x8139c475c58f2ec95163b91d41d9969729b75176b166d53c9ee415acff32449a::acl::AggregatorAcl, arg6: &0x2::clock::Clock, arg7: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version, arg8: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg9: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg7);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_unwinding<T0, T1, T2>(arg1);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_vault_obligation<T0, T1, T2>(arg1, arg2);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg8, arg3, arg2, arg6);
        let (_, v1) = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::info<T0, T1, T2>(arg1, arg2);
        assert!(v1 > 0, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::zero_amount());
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::access(arg4), 0x1::option::some<0x2::object::ID>(0x8139c475c58f2ec95163b91d41d9969729b75176b166d53c9ee415acff32449a::acl::access_id(arg5)), arg9);
        let (v3, v4) = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::slippage<T0, T1, T2>(arg1);
        let v5 = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::access(arg4);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u128, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"slippage_up", v3);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u128, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"slippage_down", v4);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"amount", v1);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"input_type", 0x1::type_name::get<T0>());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, bool, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"fix_input", false);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"pool_id", 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::pool_id<T0, T1, T2>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"flow_id", 5);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"vault_id", 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v2, v5, b"expected_debt", v1);
        v2
    }

    public fun issue_stored_reward_swap<T0, T1, T2, T3>(arg0: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg1: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::HarvestCap, arg2: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::VaultAcl, arg3: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg4: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg4);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_finalized<T0, T1, T2>(arg0);
        let v0 = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::take_wind_down_reward<T0, T1, T2, T3>(arg0, arg1, arg5);
        let v1 = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::get_swap_route<T0, T1, T2, T3>(arg0);
        let v2 = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::access(arg2);
        let v3 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(v2, 0x1::option::some<0x2::object::ID>(0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access_id(arg3)), arg5);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v3, v2, b"flow_id", 6);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v3, v2, b"vault_id", 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg0));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v3, v2, b"input_amount", 0x2::balance::value<T3>(&v0));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T3>, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v3, v2, b"funds", 0x2::coin::from_balance<T3>(v0, arg5));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v3, v2, b"current_index", 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v3, v2, b"final_index", ((0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1) - 1) as u8));
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1)) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(&mut v3, v2, (0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1) as u8), 0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v1));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v1);
        v3
    }

    public fun process_close_position_receipt<T0: store, T1, T2>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::VaultCap, arg1: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg2: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg7: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg8: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg10: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberTable, arg11: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber::VeScaSubscriberWhitelist, arg12: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::VaultAcl, arg13: &0x2::clock::Clock, arg14: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version, arg15: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg16: &mut 0x2::tx_context::TxContext) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg14);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_unwinding<T0, T1, T2>(arg1);
        let v0 = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::access(arg12);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(arg2, v0, b"flow_id") == 5, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::invalid_flow_id());
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(arg2, v0, b"vault_id");
        assert!(v1 == 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg1), 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::invalid_vault());
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(arg2, v0, b"expected_debt");
        let v3 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T1>, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(arg2, v0, b"funds");
        assert!(0x2::balance::value<T1>(&v3) == v2, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::slippage_exceeded());
        let v4 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(arg2, v0, b"repay_amount");
        let v5 = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::close_position_v2<T0, T1, T2>(arg1, 0x2::coin::from_balance<T1>(v3, arg16), arg15, arg3, arg4, arg6, arg5, arg7, arg8, arg9, arg10, arg11, arg13, arg16);
        let v6 = 0x2::coin::value<T0>(&v5);
        assert!(v6 >= v4, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::slippage_exceeded());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::Access>(arg2, v0, b"funds", 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v4, arg16)));
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::join_final_assets<T0, T1, T2>(arg1, 0x2::coin::into_balance<T0>(v5));
        let v7 = PositionClosedEvent{
            vault_id             : v1,
            debt_repaid          : v2,
            collateral_withdrawn : v6,
            flash_swap_repayment : v4,
            final_assets         : 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::final_assets<T0, T1, T2>(arg1),
        };
        0x2::event::emit<PositionClosedEvent>(v7);
    }

    fun proportional_share(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == arg2) {
            arg0
        } else {
            (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u64)
        }
    }

    public fun set_finalized_reward_route<T0, T1, T2, T3>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::VaultCap, arg1: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg3);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::assert_finalized<T0, T1, T2>(arg1);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::add_swap_route<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun settle_stored_reward_a<T0: store, T1, T2>(arg0: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg1: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::HarvestCap, arg2: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg2);
        let v0 = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::take_wind_down_reward<T0, T1, T2, T0>(arg0, arg1, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::join_settled_reward_a<T0, T1, T2>(arg0, v0);
        let v2 = RewardSettledEvent{
            vault_id       : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg0),
            harvest_cap_id : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::HarvestCap>(arg1),
            reward_type    : 0x1::type_name::get<T0>(),
            input_amount   : v1,
            output_amount  : v1,
            sender         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RewardSettledEvent>(v2);
    }

    public fun stored_reward_balance<T0, T1, T2, T3>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>) : u64 {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::stored_wind_down_reward<T0, T1, T2, T3>(arg0)
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

