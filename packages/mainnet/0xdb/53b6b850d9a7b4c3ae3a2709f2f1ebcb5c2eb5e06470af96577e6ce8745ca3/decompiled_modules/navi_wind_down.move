module 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_wind_down {
    struct WindDownStartedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct PositionClosedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount_withdrawn: u64,
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
        manage_cap_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct RewardSettledEvent has copy, drop {
        vault_id: 0x2::object::ID,
        manage_cap_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_amount: u64,
        sender: address,
    }

    fun assert_manager(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap, arg1: &0x2::tx_context::TxContext) {
        assert!(0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::is_whitelisted_manager(arg0, 0x2::tx_context::sender(arg1)), 205);
    }

    public fun begin<T0: store, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::VersionCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>) {
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::begin_wind_down<T0, T1>(arg1);
        let v0 = WindDownStartedEvent{vault_id: 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1)};
        0x2::event::emit<WindDownStartedEvent>(v0);
    }

    public fun begin_v2<T0, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::VersionCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>) {
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::begin_wind_down_v2<T0, T1>(arg1);
        let v0 = WindDownStartedEvent{vault_id: 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1)};
        0x2::event::emit<WindDownStartedEvent>(v0);
    }

    public fun claim_stored_reward<T0: store, T1, T2>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_manager(arg0, arg2);
        let v0 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::take_wind_down_reward<T0, T1, T2>(arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = RewardClaimedEvent{
            vault_id      : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1),
            manage_cap_id : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap>(arg0),
            reward_type   : 0x1::type_name::get<T2>(),
            amount        : 0x2::balance::value<T2>(&v0),
            recipient     : v1,
        };
        0x2::event::emit<RewardClaimedEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg2), v1);
    }

    public fun claim_stored_reward_v2<T0, T1, T2>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_manager(arg0, arg2);
        let v0 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::take_wind_down_reward<T0, T1, T2>(arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = RewardClaimedEvent{
            vault_id      : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1),
            manage_cap_id : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap>(arg0),
            reward_type   : 0x1::type_name::get<T2>(),
            amount        : 0x2::balance::value<T2>(&v0),
            recipient     : v1,
        };
        0x2::event::emit<RewardClaimedEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg2), v1);
    }

    public fun close_position<T0: store, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::VersionCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x2::clock::Clock) {
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::assert_unwinding<T0, T1>(arg1);
        let v0 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::deposited<T0, T1>(arg1, arg3, arg2);
        if (v0 > 0) {
            let v1 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::withdraw_<T0, T1>(arg1, v0, arg2, arg3, arg4, arg5, arg7, arg6);
            0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::join_final_assets<T0, T1>(arg1, v1);
            let v2 = PositionClosedEvent{
                vault_id         : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1),
                amount_withdrawn : 0x2::balance::value<T0>(&v1),
                final_assets     : 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::final_assets<T0, T1>(arg1),
            };
            0x2::event::emit<PositionClosedEvent>(v2);
        };
        assert!(0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::deposited<T0, T1>(arg1, arg3, arg2) == 0, 202);
    }

    public fun close_position_v2<T0, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::VersionCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0x2::clock::Clock) {
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::assert_unwinding<T0, T1>(arg1);
        let v0 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::deposited<T0, T1>(arg1, arg3, arg2);
        if (v0 > 0) {
            let v1 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::withdraw_<T0, T1>(arg1, v0, arg2, arg3, arg4, arg5, arg7, arg6);
            0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::join_final_assets_v2<T0, T1>(arg1, v1);
            let v2 = PositionClosedEvent{
                vault_id         : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1),
                amount_withdrawn : 0x2::balance::value<T0>(&v1),
                final_assets     : 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::final_assets_v2<T0, T1>(arg1),
            };
            0x2::event::emit<PositionClosedEvent>(v2);
        };
    }

    public fun collect_reward<T0: store, T1, T2>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>, arg5: vector<address>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_manager(arg0, arg7);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::assert_reward_collection_state<T0, T1>(arg1);
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T2>(arg6, arg3, arg2, arg4, 0x1::vector::singleton<0x1::ascii::String>(0x1::type_name::into_string(0x1::type_name::get<T0>())), arg5, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::account_cap<T0, T1>(arg1));
        store_reward_or_destroy_zero<T0, T1, T2>(arg1, v0, arg7);
    }

    public fun collect_reward_v2<T0: store, T1, T2>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T2>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_manager(arg0, arg6);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::assert_reward_collection_state<T0, T1>(arg1);
        let v0 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::claim_rewards<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5);
        store_reward_or_destroy_zero<T0, T1, T2>(arg1, v0, arg6);
    }

    public fun collect_reward_v2_v2<T0, T1, T2>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T2>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_manager(arg0, arg6);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::assert_reward_collection_state<T0, T1>(arg1);
        let v0 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::claim_rewards<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5);
        store_reward_or_destroy_zero<T0, T1, T2>(arg1, v0, arg6);
    }

    public fun collect_reward_v3_v2<T0, T1, T2>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>, arg5: vector<address>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_manager(arg0, arg7);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::assert_reward_collection_state<T0, T1>(arg1);
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T2>(arg6, arg3, arg2, arg4, 0x1::vector::singleton<0x1::ascii::String>(0x1::type_name::into_string(0x1::type_name::get<T0>())), arg5, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::account_cap<T0, T1>(arg1));
        store_reward_or_destroy_zero<T0, T1, T2>(arg1, v0, arg7);
    }

    public fun consume_finalized_reward_swap<T0: store, T1, T2>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Acl, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_manager(arg0, arg5);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::assert_finalized<T0, T1>(arg1);
        let v0 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::access(arg3);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut arg2, v0, b"flow_id") == 7, 204);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut arg2, v0, b"vault_id");
        assert!(v1 == 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1), 200);
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut arg2, v0, b"funds");
        assert!(meets_min_receive(0x2::coin::value<T0>(&v2), arg4), 203);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut arg2, v0, b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut arg2, v0, b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg2);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::join_settled_reward<T0, T1>(arg1, 0x2::coin::into_balance<T0>(v2));
        let v3 = RewardSettledEvent{
            vault_id      : v1,
            manage_cap_id : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap>(arg0),
            reward_type   : 0x1::type_name::get<T2>(),
            input_amount  : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut arg2, v0, b"input_amount"),
            output_amount : 0x2::coin::value<T0>(&v2),
            sender        : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<RewardSettledEvent>(v3);
    }

    public fun consume_finalized_reward_swap_v2<T0, T1, T2>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Acl, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_manager(arg0, arg5);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::assert_finalized<T0, T1>(arg1);
        let v0 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::access(arg3);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut arg2, v0, b"flow_id") == 7, 204);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut arg2, v0, b"vault_id");
        assert!(v1 == 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1), 200);
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut arg2, v0, b"funds");
        assert!(meets_min_receive(0x2::coin::value<T0>(&v2), arg4), 203);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut arg2, v0, b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut arg2, v0, b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg2);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::join_settled_reward_v2<T0, T1>(arg1, 0x2::coin::into_balance<T0>(v2));
        let v3 = RewardSettledEvent{
            vault_id      : v1,
            manage_cap_id : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap>(arg0),
            reward_type   : 0x1::type_name::get<T2>(),
            input_amount  : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut arg2, v0, b"input_amount"),
            output_amount : 0x2::coin::value<T0>(&v2),
            sender        : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<RewardSettledEvent>(v3);
    }

    public fun deposit_final_assets<T0: store, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::VersionCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: 0x2::coin::Coin<T0>) {
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::assert_unwinding<T0, T1>(arg1);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::join_final_assets<T0, T1>(arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun deposit_final_assets_v2<T0, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::VersionCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: 0x2::coin::Coin<T0>) {
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::assert_unwinding<T0, T1>(arg1);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::join_final_assets_v2<T0, T1>(arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun finalize<T0: store, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::VersionCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) {
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::assert_unwinding<T0, T1>(arg1);
        assert!(0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::deposited<T0, T1>(arg1, arg3, arg2) == 0, 202);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::finalize_wind_down<T0, T1>(arg1);
        let v0 = WindDownFinalizedEvent{
            vault_id        : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1),
            final_assets    : 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::final_assets<T0, T1>(arg1),
            total_vt_supply : 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::total_vt_supply<T0, T1>(arg1),
        };
        0x2::event::emit<WindDownFinalizedEvent>(v0);
    }

    public fun finalize_v2<T0, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::VersionCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) {
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::assert_unwinding<T0, T1>(arg1);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::finalize_wind_down_v2<T0, T1>(arg1);
        let v0 = WindDownFinalizedEvent{
            vault_id        : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1),
            final_assets    : 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::final_assets_v2<T0, T1>(arg1),
            total_vt_supply : 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::total_vt_supply<T0, T1>(arg1),
        };
        0x2::event::emit<WindDownFinalizedEvent>(v0);
    }

    public fun issue_stored_reward_swap<T0: store, T1, T2>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Acl, arg3: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg4: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        assert_manager(arg0, arg4);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::assert_finalized<T0, T1>(arg1);
        let v0 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::take_wind_down_reward<T0, T1, T2>(arg1);
        let v1 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::get_swap_route<T0, T1, T2>(arg1);
        assert!(!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1), 201);
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::access(arg2), 0x1::option::some<0x2::object::ID>(0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access_id(arg3)), arg4);
        let v3 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::access(arg2);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v2, v3, b"flow_id", 7);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v2, v3, b"vault_id", 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v2, v3, b"input_amount", 0x2::balance::value<T2>(&v0));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T2>, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v2, v3, b"funds", 0x2::coin::from_balance<T2>(v0, arg4));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v2, v3, b"current_index", 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v2, v3, b"final_index", ((0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1) - 1) as u8));
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1)) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v2, v3, (0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1) as u8), 0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v1));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v1);
        v2
    }

    public fun issue_stored_reward_swap_v2<T0, T1, T2>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Acl, arg3: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg4: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        assert_manager(arg0, arg4);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::assert_finalized<T0, T1>(arg1);
        let v0 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::take_wind_down_reward<T0, T1, T2>(arg1);
        let v1 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::get_swap_route<T0, T1, T2>(arg1);
        assert!(!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1), 201);
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::access(arg2), 0x1::option::some<0x2::object::ID>(0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access_id(arg3)), arg4);
        let v3 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::access(arg2);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v2, v3, b"flow_id", 7);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v2, v3, b"vault_id", 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v2, v3, b"input_amount", 0x2::balance::value<T2>(&v0));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T2>, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v2, v3, b"funds", 0x2::coin::from_balance<T2>(v0, arg4));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v2, v3, b"current_index", 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v2, v3, b"final_index", ((0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1) - 1) as u8));
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1)) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v2, v3, (0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v1) as u8), 0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v1));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v1);
        v2
    }

    fun meets_min_receive(arg0: u64, arg1: u64) : bool {
        arg0 >= arg1
    }

    public fun set_finalized_reward_route<T0: store, T1, T2>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::VersionCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::assert_finalized<T0, T1>(arg1);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::add_swap_route<T0, T1, T2>(arg1, arg2);
    }

    public fun set_finalized_reward_route_v2<T0, T1, T2>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::VersionCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::assert_finalized<T0, T1>(arg1);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::add_swap_route<T0, T1, T2>(arg1, arg2);
    }

    public fun settle_stored_base_reward<T0: store, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        assert_manager(arg0, arg2);
        let v0 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::take_wind_down_reward<T0, T1, T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::join_settled_reward<T0, T1>(arg1, v0);
        let v2 = RewardSettledEvent{
            vault_id      : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1),
            manage_cap_id : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap>(arg0),
            reward_type   : 0x1::type_name::get<T0>(),
            input_amount  : v1,
            output_amount : v1,
            sender        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RewardSettledEvent>(v2);
    }

    public fun settle_stored_base_reward_v2<T0, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        assert_manager(arg0, arg2);
        let v0 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::take_wind_down_reward<T0, T1, T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::join_settled_reward_v2<T0, T1>(arg1, v0);
        let v2 = RewardSettledEvent{
            vault_id      : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1),
            manage_cap_id : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap>(arg0),
            reward_type   : 0x1::type_name::get<T0>(),
            input_amount  : v1,
            output_amount : v1,
            sender        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RewardSettledEvent>(v2);
    }

    fun store_reward_or_destroy_zero<T0, T1, T2>(arg0: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg1: 0x2::balance::Balance<T2>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T2>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T2>(arg1);
            return
        };
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::store_wind_down_reward<T0, T1, T2>(arg0, arg1);
        let v1 = RewardStoredEvent{
            vault_id     : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg0),
            reward_type  : 0x1::type_name::get<T2>(),
            amount       : v0,
            total_stored : 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::stored_wind_down_reward<T0, T1, T2>(arg0),
            sender       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RewardStoredEvent>(v1);
    }

    public fun stored_reward_balance<T0, T1, T2>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>) : u64 {
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::stored_wind_down_reward<T0, T1, T2>(arg0)
    }

    public fun withdraw<T0: store, T1>(arg0: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::take_finalized_share<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg3), arg2);
        let v2 = v0;
        let v3 = FinalWithdrawalEvent{
            vault_id            : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg0),
            user                : 0x2::tx_context::sender(arg3),
            vt_burned           : v1,
            amount_out          : 0x2::balance::value<T0>(&v2),
            remaining_assets    : 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::final_assets<T0, T1>(arg0),
            remaining_vt_supply : 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::total_vt_supply<T0, T1>(arg0),
        };
        0x2::event::emit<FinalWithdrawalEvent>(v3);
        v2
    }

    public fun withdraw_v2<T0, T1>(arg0: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::take_finalized_share_v2<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg3), arg2);
        let v2 = v0;
        let v3 = FinalWithdrawalEvent{
            vault_id            : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg0),
            user                : 0x2::tx_context::sender(arg3),
            vt_burned           : v1,
            amount_out          : 0x2::balance::value<T0>(&v2),
            remaining_assets    : 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::final_assets_v2<T0, T1>(arg0),
            remaining_vt_supply : 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::total_vt_supply<T0, T1>(arg0),
        };
        0x2::event::emit<FinalWithdrawalEvent>(v3);
        v2
    }

    // decompiled from Move bytecode v7
}

