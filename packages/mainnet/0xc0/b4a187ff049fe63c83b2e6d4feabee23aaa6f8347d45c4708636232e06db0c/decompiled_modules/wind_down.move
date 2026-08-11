module 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::wind_down {
    struct WindDownStartedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct PositionClosedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        debt_repaid: u64,
        collateral_withdrawn: u64,
        flash_swap_repayment: u64,
        final_assets: u64,
        final_debt_assets: u64,
    }

    struct WindDownFinalizedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        final_assets: u64,
        final_debt_assets: u64,
        total_vt_supply: u64,
    }

    struct FinalWithdrawalEvent has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        vt_burned: u64,
        amount_a_out: u64,
        amount_b_out: u64,
        remaining_assets: u64,
        remaining_debt_assets: u64,
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
        returns_a: bool,
        sender: address,
    }

    public fun begin<T0: store, T1: store, T2>(arg0: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::VaultCap, arg1: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg2: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::Version) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::assert_current_version(arg2);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::begin_wind_down<T0, T1, T2>(arg1);
        let v0 = WindDownStartedEvent{vault_id: 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg1)};
        0x2::event::emit<WindDownStartedEvent>(v0);
    }

    public fun begin_v2<T0, T1, T2>(arg0: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::VaultCap, arg1: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg2: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::Version) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::assert_current_version(arg2);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::begin_wind_down_v2<T0, T1, T2>(arg1);
        let v0 = WindDownStartedEvent{vault_id: 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg1)};
        0x2::event::emit<WindDownStartedEvent>(v0);
    }

    public fun claim_stored_reward<T0, T1, T2, T3>(arg0: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg1: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::HarvestCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::take_wind_down_reward<T0, T1, T2, T3>(arg0, arg1, arg2);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = RewardClaimedEvent{
            vault_id       : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg0),
            harvest_cap_id : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::HarvestCap>(arg1),
            reward_type    : 0x1::type_name::get<T3>(),
            amount         : 0x2::balance::value<T3>(&v0),
            recipient      : v1,
        };
        0x2::event::emit<RewardClaimedEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v0, arg2), v1);
    }

    public fun collect_reward<T0, T1, T2, T3>(arg0: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::VaultCap, arg1: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg2: bool, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T3>, arg6: vector<address>, arg7: &0x2::clock::Clock, arg8: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::Version, arg9: &0x2::tx_context::TxContext) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::assert_current_version(arg8);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_reward_collection_state<T0, T1, T2>(arg1);
        let v0 = if (arg2) {
            0x1::vector::singleton<0x1::ascii::String>(0x1::type_name::into_string(0x1::type_name::get<T0>()))
        } else {
            0x1::vector::singleton<0x1::ascii::String>(0x1::type_name::into_string(0x1::type_name::get<T1>()))
        };
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T3>(arg7, arg4, arg3, arg5, v0, arg6, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::account_cap<T0, T1, T2>(arg1));
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::store_wind_down_reward<T0, T1, T2, T3>(arg1, v1);
        let v2 = RewardStoredEvent{
            vault_id     : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg1),
            reward_type  : 0x1::type_name::get<T3>(),
            amount       : 0x2::balance::value<T3>(&v1),
            total_stored : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::stored_wind_down_reward<T0, T1, T2, T3>(arg1),
            sender       : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<RewardStoredEvent>(v2);
    }

    public fun collect_reward_v2<T0, T1, T2, T3>(arg0: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::VaultCap, arg1: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg2: bool, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T3>, arg6: &0x2::clock::Clock, arg7: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::Version, arg8: &0x2::tx_context::TxContext) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::assert_current_version(arg7);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_reward_collection_state<T0, T1, T2>(arg1);
        let (v0, v1) = if (arg2) {
            (0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::a_index<T0, T1, T2>(arg1), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::option_supply())
        } else {
            (0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::b_index<T0, T1, T2>(arg1), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::option_borrow())
        };
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T3>(arg6, arg4, arg5, arg3, v0, v1, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::account_cap<T0, T1, T2>(arg1));
        let v3 = 0x2::balance::value<T3>(&v2);
        if (v3 == 0) {
            0x2::balance::destroy_zero<T3>(v2);
            return
        };
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::store_wind_down_reward<T0, T1, T2, T3>(arg1, v2);
        let v4 = RewardStoredEvent{
            vault_id     : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg1),
            reward_type  : 0x1::type_name::get<T3>(),
            amount       : v3,
            total_stored : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::stored_wind_down_reward<T0, T1, T2, T3>(arg1),
            sender       : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<RewardStoredEvent>(v4);
    }

    public fun consume_finalized_reward_swap<T0: store, T1: store, T2, T3>(arg0: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::HarvestCap, arg1: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg2: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg3: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::VaultAcl, arg4: u64, arg5: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::assert_current_version(arg5);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_finalized<T0, T1, T2>(arg2);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_harvest_cap<T0, T1, T2>(arg2, arg0, arg6);
        let v0 = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::access(arg3);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut arg1, v0, b"flow_id") == 6, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::invalid_flow_id());
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut arg1, v0, b"vault_id");
        assert!(v1 == 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg2), 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::invalid_vault());
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, bool, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut arg1, v0, b"returns_a");
        let v3 = if (v2) {
            let v4 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut arg1, v0, b"funds");
            let v5 = 0x2::coin::value<T0>(&v4);
            assert!(v5 >= arg4, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::slippage_exceeded());
            0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::join_settled_reward_a<T0, T1, T2>(arg2, 0x2::coin::into_balance<T0>(v4));
            v5
        } else {
            let v6 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T1>, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut arg1, v0, b"funds");
            let v7 = 0x2::coin::value<T1>(&v6);
            assert!(v7 >= arg4, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::slippage_exceeded());
            0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::join_settled_reward_b<T0, T1, T2>(arg2, 0x2::coin::into_balance<T1>(v6));
            v7
        };
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut arg1, v0, b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut arg1, v0, b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg1);
        let v8 = RewardSettledEvent{
            vault_id       : v1,
            harvest_cap_id : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::HarvestCap>(arg0),
            reward_type    : 0x1::type_name::get<T3>(),
            input_amount   : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut arg1, v0, b"input_amount"),
            output_amount  : v3,
            returns_a      : v2,
            sender         : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<RewardSettledEvent>(v8);
    }

    public fun consume_finalized_reward_swap_v2<T0, T1, T2, T3>(arg0: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::HarvestCap, arg1: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg2: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg3: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::VaultAcl, arg4: u64, arg5: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::assert_current_version(arg5);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_finalized<T0, T1, T2>(arg2);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_harvest_cap<T0, T1, T2>(arg2, arg0, arg6);
        let v0 = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::access(arg3);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut arg1, v0, b"flow_id") == 6, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::invalid_flow_id());
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut arg1, v0, b"vault_id");
        assert!(v1 == 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg2), 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::invalid_vault());
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, bool, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut arg1, v0, b"returns_a");
        let v3 = if (v2) {
            let v4 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut arg1, v0, b"funds");
            let v5 = 0x2::coin::value<T0>(&v4);
            assert!(v5 >= arg4, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::slippage_exceeded());
            0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::join_settled_reward_a_v2<T0, T1, T2>(arg2, 0x2::coin::into_balance<T0>(v4));
            v5
        } else {
            let v6 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T1>, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut arg1, v0, b"funds");
            let v7 = 0x2::coin::value<T1>(&v6);
            assert!(v7 >= arg4, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::slippage_exceeded());
            0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::join_settled_reward_b_v2<T0, T1, T2>(arg2, 0x2::coin::into_balance<T1>(v6));
            v7
        };
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut arg1, v0, b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut arg1, v0, b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg1);
        let v8 = RewardSettledEvent{
            vault_id       : v1,
            harvest_cap_id : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::HarvestCap>(arg0),
            reward_type    : 0x1::type_name::get<T3>(),
            input_amount   : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut arg1, v0, b"input_amount"),
            output_amount  : v3,
            returns_a      : v2,
            sender         : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<RewardSettledEvent>(v8);
    }

    public fun deposit_final_assets<T0: store, T1, T2>(arg0: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::VaultCap, arg1: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_unwinding<T0, T1, T2>(arg1);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::join_final_assets<T0, T1, T2>(arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun deposit_final_assets_v2<T0, T1, T2>(arg0: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::VaultCap, arg1: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_unwinding<T0, T1, T2>(arg1);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::join_final_assets_v2<T0, T1, T2>(arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun finalize<T0: store, T1: store, T2>(arg0: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::VaultCap, arg1: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::Version) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::assert_current_version(arg5);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_unwinding<T0, T1, T2>(arg1);
        let (v0, v1) = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::info<T0, T1, T2>(arg1, arg3, arg4, arg2);
        assert!(v0 == 0 && v1 == 0, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::position_not_closed());
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::finalize_wind_down<T0, T1, T2>(arg1);
        let v2 = WindDownFinalizedEvent{
            vault_id          : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg1),
            final_assets      : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::final_assets<T0, T1, T2>(arg1),
            final_debt_assets : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::final_debt_assets<T0, T1, T2>(arg1),
            total_vt_supply   : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::total_vt_supply<T0, T1, T2>(arg1),
        };
        0x2::event::emit<WindDownFinalizedEvent>(v2);
    }

    public fun finalize_v2<T0, T1, T2>(arg0: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::VaultCap, arg1: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::Version) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::assert_current_version(arg5);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_unwinding<T0, T1, T2>(arg1);
        let (v0, v1) = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::info<T0, T1, T2>(arg1, arg3, arg4, arg2);
        assert!(v0 == 0 && v1 == 0, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::position_not_closed());
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::finalize_wind_down<T0, T1, T2>(arg1);
        let v2 = WindDownFinalizedEvent{
            vault_id          : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg1),
            final_assets      : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::final_assets_v2<T0, T1, T2>(arg1),
            final_debt_assets : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::final_debt_assets_v2<T0, T1, T2>(arg1),
            total_vt_supply   : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::total_vt_supply<T0, T1, T2>(arg1),
        };
        0x2::event::emit<WindDownFinalizedEvent>(v2);
    }

    public fun issue_close_position_receipt<T0, T1, T2>(arg0: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::VaultCap, arg1: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::VaultAcl, arg6: &0x8139c475c58f2ec95163b91d41d9969729b75176b166d53c9ee415acff32449a::acl::AggregatorAcl, arg7: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::Version, arg8: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::assert_current_version(arg7);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_unwinding<T0, T1, T2>(arg1);
        let (_, v1) = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::info<T0, T1, T2>(arg1, arg3, arg4, arg2);
        assert!(v1 > 0, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::zero_amount());
        let v2 = v1 + 0x1::u64::max(v1 / 10000, 1);
        let v3 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::access(arg5), 0x1::option::some<0x2::object::ID>(0x8139c475c58f2ec95163b91d41d9969729b75176b166d53c9ee415acff32449a::acl::access_id(arg6)), arg8);
        let (v4, v5) = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::slippage<T0, T1, T2>(arg1);
        let v6 = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::access(arg5);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u128, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v6, b"slippage_up", v4);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u128, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v6, b"slippage_down", v5);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v6, b"amount", v2);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v6, b"input_type", 0x1::type_name::get<T0>());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, bool, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v6, b"fix_input", false);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v6, b"pool_id", 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::pool_id<T0, T1, T2>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v6, b"flow_id", 5);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v6, b"vault_id", 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v6, b"expected_debt", v1);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v6, b"requested_debt", v2);
        v3
    }

    public fun issue_stored_reward_swap<T0, T1, T2, T3>(arg0: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg1: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::HarvestCap, arg2: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::VaultAcl, arg3: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg4: bool, arg5: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::Version, arg6: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::assert_current_version(arg5);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_finalized<T0, T1, T2>(arg0);
        let v0 = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::take_wind_down_reward<T0, T1, T2, T3>(arg0, arg1, arg6);
        let v1 = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::get_swap_route<T0, T1, T2, T3>(arg0);
        let v2 = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::access(arg2);
        let v3 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(v2, 0x1::option::some<0x2::object::ID>(0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access_id(arg3)), arg6);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v2, b"flow_id", 6);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v2, b"vault_id", 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg0));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v2, b"input_amount", 0x2::balance::value<T3>(&v0));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, bool, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v2, b"returns_a", arg4);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T3>, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v2, b"funds", 0x2::coin::from_balance<T3>(v0, arg6));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v2, b"current_index", 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v2, b"final_index", ((0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1) - 1) as u8));
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1)) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(&mut v3, v2, (0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1) as u8), 0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v1));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v1);
        v3
    }

    public fun process_close_position_receipt<T0: store, T1: store, T2>(arg0: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::VaultCap, arg1: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg2: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::VaultAcl, arg10: &0x2::clock::Clock, arg11: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::Version, arg12: &mut 0x2::tx_context::TxContext) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::assert_current_version(arg11);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_unwinding<T0, T1, T2>(arg1);
        let v0 = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::access(arg9);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(arg2, v0, b"flow_id") == 5, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::invalid_flow_id());
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(arg2, v0, b"vault_id");
        assert!(v1 == 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg1), 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::invalid_vault());
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T1>, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(arg2, v0, b"funds");
        assert!(0x2::balance::value<T1>(&v2) == 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(arg2, v0, b"requested_debt"), 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::slippage_exceeded());
        let v3 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(arg2, v0, b"repay_amount");
        let (v4, v5) = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::close_position_<T0, T1, T2>(arg1, 0x2::coin::from_balance<T1>(v2, arg12), arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg12);
        let v6 = v4;
        let v7 = 0x2::coin::value<T0>(&v6);
        assert!(v7 >= v3, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::slippage_exceeded());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(arg2, v0, b"funds", 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, v3, arg12)));
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::join_final_assets<T0, T1, T2>(arg1, 0x2::coin::into_balance<T0>(v6));
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::join_final_debt_assets<T0, T1, T2>(arg1, v5);
        let v8 = PositionClosedEvent{
            vault_id             : v1,
            debt_repaid          : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(arg2, v0, b"expected_debt"),
            collateral_withdrawn : v7,
            flash_swap_repayment : v3,
            final_assets         : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::final_assets<T0, T1, T2>(arg1),
            final_debt_assets    : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::final_debt_assets<T0, T1, T2>(arg1),
        };
        0x2::event::emit<PositionClosedEvent>(v8);
    }

    public fun process_close_position_receipt_v2<T0, T1, T2>(arg0: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::VaultCap, arg1: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg2: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::VaultAcl, arg10: &0x2::clock::Clock, arg11: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::Version, arg12: &mut 0x2::tx_context::TxContext) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::assert_current_version(arg11);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_unwinding<T0, T1, T2>(arg1);
        let v0 = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::access(arg9);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(arg2, v0, b"flow_id") == 5, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::invalid_flow_id());
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(arg2, v0, b"vault_id");
        assert!(v1 == 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg1), 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::invalid_vault());
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T1>, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(arg2, v0, b"funds");
        assert!(0x2::balance::value<T1>(&v2) == 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(arg2, v0, b"requested_debt"), 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::slippage_exceeded());
        let v3 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(arg2, v0, b"repay_amount");
        let (v4, v5) = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::close_position_<T0, T1, T2>(arg1, 0x2::coin::from_balance<T1>(v2, arg12), arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg12);
        let v6 = v4;
        let v7 = 0x2::coin::value<T0>(&v6);
        assert!(v7 >= v3, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::slippage_exceeded());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(arg2, v0, b"funds", 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, v3, arg12)));
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::join_final_assets_v2<T0, T1, T2>(arg1, 0x2::coin::into_balance<T0>(v6));
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::join_final_debt_assets_v2<T0, T1, T2>(arg1, v5);
        let v8 = PositionClosedEvent{
            vault_id             : v1,
            debt_repaid          : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault_acl::Access>(arg2, v0, b"expected_debt"),
            collateral_withdrawn : v7,
            flash_swap_repayment : v3,
            final_assets         : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::final_assets_v2<T0, T1, T2>(arg1),
            final_debt_assets    : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::final_debt_assets_v2<T0, T1, T2>(arg1),
        };
        0x2::event::emit<PositionClosedEvent>(v8);
    }

    fun proportional_share(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == arg2) {
            arg0
        } else {
            (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u64)
        }
    }

    public fun set_finalized_reward_route<T0, T1, T2, T3>(arg0: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::VaultCap, arg1: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::Version) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::assert_current_version(arg3);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_finalized<T0, T1, T2>(arg1);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::add_swap_route<T0, T1, T2, T3>(arg1, arg2);
    }

    public fun settle_stored_reward_a<T0: store, T1, T2>(arg0: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg1: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::HarvestCap, arg2: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::assert_current_version(arg2);
        let v0 = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::take_wind_down_reward<T0, T1, T2, T0>(arg0, arg1, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::join_settled_reward_a<T0, T1, T2>(arg0, v0);
        let v2 = RewardSettledEvent{
            vault_id       : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg0),
            harvest_cap_id : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::HarvestCap>(arg1),
            reward_type    : 0x1::type_name::get<T0>(),
            input_amount   : v1,
            output_amount  : v1,
            returns_a      : true,
            sender         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RewardSettledEvent>(v2);
    }

    public fun settle_stored_reward_a_v2<T0, T1, T2>(arg0: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg1: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::HarvestCap, arg2: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::assert_current_version(arg2);
        let v0 = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::take_wind_down_reward<T0, T1, T2, T0>(arg0, arg1, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::join_settled_reward_a_v2<T0, T1, T2>(arg0, v0);
        let v2 = RewardSettledEvent{
            vault_id       : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg0),
            harvest_cap_id : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::HarvestCap>(arg1),
            reward_type    : 0x1::type_name::get<T0>(),
            input_amount   : v1,
            output_amount  : v1,
            returns_a      : true,
            sender         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RewardSettledEvent>(v2);
    }

    public fun settle_stored_reward_b<T0, T1: store, T2>(arg0: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg1: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::HarvestCap, arg2: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::assert_current_version(arg2);
        let v0 = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::take_wind_down_reward<T0, T1, T2, T1>(arg0, arg1, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::join_settled_reward_b<T0, T1, T2>(arg0, v0);
        let v2 = RewardSettledEvent{
            vault_id       : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg0),
            harvest_cap_id : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::HarvestCap>(arg1),
            reward_type    : 0x1::type_name::get<T1>(),
            input_amount   : v1,
            output_amount  : v1,
            returns_a      : false,
            sender         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RewardSettledEvent>(v2);
    }

    public fun settle_stored_reward_b_v2<T0, T1, T2>(arg0: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg1: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::HarvestCap, arg2: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::version::assert_current_version(arg2);
        let v0 = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::take_wind_down_reward<T0, T1, T2, T1>(arg0, arg1, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::join_settled_reward_b_v2<T0, T1, T2>(arg0, v0);
        let v2 = RewardSettledEvent{
            vault_id       : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg0),
            harvest_cap_id : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::HarvestCap>(arg1),
            reward_type    : 0x1::type_name::get<T1>(),
            input_amount   : v1,
            output_amount  : v1,
            returns_a      : false,
            sender         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RewardSettledEvent>(v2);
    }

    public fun stored_reward_balance<T0, T1, T2, T3>(arg0: &0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>) : u64 {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::stored_wind_down_reward<T0, T1, T2, T3>(arg0)
    }

    public fun withdraw<T0: store, T1: store, T2>(arg0: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_finalized<T0, T1, T2>(arg0);
        let v0 = 0x2::coin::value<T2>(&arg1);
        let v1 = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::total_vt_supply<T0, T1, T2>(arg0);
        assert!(v0 > 0 && v1 > 0, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::zero_amount());
        let v2 = proportional_share(0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::final_assets<T0, T1, T2>(arg0), v0, v1);
        let v3 = proportional_share(0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::final_debt_assets<T0, T1, T2>(arg0), v0, v1);
        assert!(v2 >= arg2 && v3 >= arg3, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::slippage_exceeded());
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::burn_vt<T0, T1, T2>(arg0, arg1);
        let v4 = FinalWithdrawalEvent{
            vault_id              : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg0),
            user                  : 0x2::tx_context::sender(arg4),
            vt_burned             : v0,
            amount_a_out          : v2,
            amount_b_out          : v3,
            remaining_assets      : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::final_assets<T0, T1, T2>(arg0),
            remaining_debt_assets : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::final_debt_assets<T0, T1, T2>(arg0),
            remaining_vt_supply   : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2::event::emit<FinalWithdrawalEvent>(v4);
        let v5 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::take_final_assets<T0, T1, T2>(arg0, v2), arg4), v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::take_final_debt_assets<T0, T1, T2>(arg0, v3), arg4), v5);
    }

    public fun withdraw_v2<T0, T1, T2>(arg0: &mut 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::assert_finalized<T0, T1, T2>(arg0);
        let v0 = 0x2::coin::value<T2>(&arg1);
        let v1 = 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::total_vt_supply<T0, T1, T2>(arg0);
        assert!(v0 > 0 && v1 > 0, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::zero_amount());
        let v2 = proportional_share(0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::final_assets_v2<T0, T1, T2>(arg0), v0, v1);
        let v3 = proportional_share(0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::final_debt_assets_v2<T0, T1, T2>(arg0), v0, v1);
        assert!(v2 >= arg2 && v3 >= arg3, 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error::slippage_exceeded());
        0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::burn_vt<T0, T1, T2>(arg0, arg1);
        let v4 = FinalWithdrawalEvent{
            vault_id              : 0x2::object::id<0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::Vault<T0, T1, T2>>(arg0),
            user                  : 0x2::tx_context::sender(arg4),
            vt_burned             : v0,
            amount_a_out          : v2,
            amount_b_out          : v3,
            remaining_assets      : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::final_assets_v2<T0, T1, T2>(arg0),
            remaining_debt_assets : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::final_debt_assets_v2<T0, T1, T2>(arg0),
            remaining_vt_supply   : 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2::event::emit<FinalWithdrawalEvent>(v4);
        let v5 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::take_final_assets_v2<T0, T1, T2>(arg0, v2), arg4), v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::vault::take_final_debt_assets_v2<T0, T1, T2>(arg0, v3), arg4), v5);
    }

    // decompiled from Move bytecode v7
}

