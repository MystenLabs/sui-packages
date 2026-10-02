module 0xa6ccb9275438a7a1cda2df2f2ff86e211b687aaacc3d556c3f7972fcddc63fea::navi_service {
    struct ServiceCreated has copy, drop {
        service_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        timestamp_ms: u64,
    }

    struct Deposited has copy, drop {
        service_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        user_allocation_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        strategy_allocation_id: 0x2::object::ID,
        amount: u64,
        shares_minted: u64,
        total_supplied: u64,
        total_shares: u64,
        timestamp_ms: u64,
        depositor: address,
    }

    struct Withdrawn has copy, drop {
        service_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        user_allocation_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        strategy_allocation_id: 0x2::object::ID,
        shares_burned: u64,
        amount: u64,
        total_supplied: u64,
        total_shares: u64,
        timestamp_ms: u64,
        withdrawer: address,
    }

    struct RebalanceWithdrawal has copy, drop {
        service_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        user_allocation_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        strategy_allocation_id: 0x2::object::ID,
        shares_burned: u64,
        amount: u64,
        total_supplied: u64,
        total_shares: u64,
        timestamp_ms: u64,
    }

    struct RebalanceDeposit has copy, drop {
        service_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        user_allocation_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        strategy_allocation_id: 0x2::object::ID,
        amount: u64,
        shares_minted: u64,
        total_supplied: u64,
        total_shares: u64,
        timestamp_ms: u64,
    }

    struct UserRewardsCollected has copy, drop {
        service_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        user_allocation_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp_ms: u64,
        claimer: address,
    }

    struct StrategyFeesCollected has copy, drop {
        service_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        strategy_allocation_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp_ms: u64,
    }

    struct ProtocolFeesCollected has copy, drop {
        service_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp_ms: u64,
        admin: address,
    }

    struct ServicePaused has copy, drop {
        service_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct ServiceUnpaused has copy, drop {
        service_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct ServiceUpdated<phantom T0> has copy, drop {
        service_id: 0x2::object::ID,
        total_supplied: u64,
        total_shares: u64,
        accrued_rewards_per_share: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
        external_rewards_distributed: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
        timestamp_ms: u64,
    }

    struct ProtocolYieldAccrued has copy, drop {
        service_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        gross: u64,
        fee: u64,
        net: u64,
        timestamp_ms: u64,
    }

    struct ProtocolLossRealized has copy, drop {
        service_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        loss: u64,
        timestamp_ms: u64,
    }

    struct AdminRewardsReleased has copy, drop {
        service_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp_ms: u64,
    }

    struct AdminRewardPoolAdded has copy, drop {
        service_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        requested_start_time: u64,
        effective_start_time: u64,
        end_time: u64,
        reward_per_ms: u128,
        pool_balance: u64,
        timestamp_ms: u64,
        sender: address,
    }

    struct ExternalIncentivesClaimed has copy, drop {
        service_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        gross: u64,
        fee: u64,
        net: u64,
        timestamp_ms: u64,
    }

    struct MinRewardDurationUpdated has copy, drop {
        service_id: 0x2::object::ID,
        old_ms: u64,
        new_ms: u64,
        timestamp_ms: u64,
    }

    struct FeeBpsUpdated has copy, drop {
        service_id: 0x2::object::ID,
        old_platform_bps: u64,
        new_platform_bps: u64,
        old_strategy_bps: u64,
        new_strategy_bps: u64,
        timestamp_ms: u64,
    }

    struct Service<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        service_cap: 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::ServiceCap,
        protocol_position_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        asset_id: u8,
        storage_id: 0x2::object::ID,
        user_data: UserAllocationData<T0>,
        strategy_data: StrategyAllocationData<T0>,
        rewards: 0x2::bag::Bag,
        admin_reward_pools: 0x2::vec_map::VecMap<0x1::type_name::TypeName, AdminRewardInfo>,
        external_rewards_distributed: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
        fee_collected: 0x2::bag::Bag,
        total_shares: u64,
        total_supplied: u64,
        platform_fee_bps: u64,
        strategy_fee_bps: u64,
        min_reward_duration_ms: u64,
        is_paused: bool,
    }

    struct UserAllocationData<phantom T0> has store {
        position_cap_data: 0x2::object_table::ObjectTable<0x2::object::ID, UserAllocationDataInner<T0>>,
        accrued_rewards_per_share: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
    }

    struct StrategyAllocationData<phantom T0> has store {
        strategies: 0x2::object_table::ObjectTable<0x2::object::ID, StrategyAllocationDataInner<T0>>,
        accrued_fees_per_share: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
    }

    struct UserAllocationDataInner<phantom T0> has store, key {
        id: 0x2::object::UID,
        strategy_allocations: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        last_accrued_rewards_per_share: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
        pending_rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        total_shares: u64,
    }

    struct StrategyAllocationDataInner<phantom T0> has store, key {
        id: 0x2::object::UID,
        strategy_id: 0x2::object::ID,
        last_accrued_fees_per_share: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
        pending_fees: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        total_shares: u64,
    }

    struct AdminRewardInfo has store, key {
        id: 0x2::object::UID,
        last_updated: u64,
        start_time: u64,
        end_time: u64,
        reward_per_ms: u128,
    }

    fun actual_supplied<T0>(arg0: &Service<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &0x2::clock::Clock) : u64 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, arg0.asset_id, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.protocol_position_cap));
        let (v2, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::calculate_current_index(arg3, arg1, arg0.asset_id);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg2, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v0, v2) as u64))
    }

    public fun admin_add_reward<T0, T1>(arg0: &mut Service<T0>, arg1: &0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::AdminCap, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg0.total_shares > 0, 4007);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        update_admin_rewards<T0, T1>(arg0, arg5);
        let v2 = if (!0x2::vec_map::contains<0x1::type_name::TypeName, AdminRewardInfo>(&arg0.admin_reward_pools, &v1) || v0 < 0x2::vec_map::get<0x1::type_name::TypeName, AdminRewardInfo>(&arg0.admin_reward_pools, &v1).start_time) {
            assert!(arg3 >= v0, 4001);
            arg3
        } else {
            v0
        };
        assert!(arg4 > v2, 4001);
        assert!(arg4 >= v2 + arg0.min_reward_duration_ms, 4008);
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, AdminRewardInfo>(&arg0.admin_reward_pools, &v1)) {
            let v3 = AdminRewardInfo{
                id            : 0x2::object::new(arg6),
                last_updated  : v2,
                start_time    : v2,
                end_time      : arg4,
                reward_per_ms : 0,
            };
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v3.id, v1, 0x2::balance::zero<T1>());
            0x2::vec_map::insert<0x1::type_name::TypeName, AdminRewardInfo>(&mut arg0.admin_reward_pools, v1, v3);
        };
        let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, AdminRewardInfo>(&mut arg0.admin_reward_pools, &v1);
        let v5 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v4.id, v1);
        0x2::balance::join<T1>(v5, 0x2::coin::into_balance<T1>(arg2));
        let v6 = 0x2::balance::value<T1>(v5);
        v4.start_time = v2;
        v4.last_updated = v2;
        v4.end_time = arg4;
        let v7 = (v6 as u128) * 1000000000000 / ((arg4 - v2) as u128);
        v4.reward_per_ms = v7;
        let v8 = AdminRewardPoolAdded{
            service_id           : 0x2::object::id<Service<T0>>(arg0),
            reward_type          : v1,
            amount               : 0x2::coin::value<T1>(&arg2),
            requested_start_time : arg3,
            effective_start_time : v2,
            end_time             : arg4,
            reward_per_ms        : v7,
            pool_balance         : v6,
            timestamp_ms         : v0,
            sender               : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<AdminRewardPoolAdded>(v8);
    }

    fun assert_all_rewards_collected<T0>(arg0: &Service<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg3: &0x2::clock::Clock) {
        let (v0, _, v2, _, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg3, arg1, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.protocol_position_cap)));
        let v5 = v4;
        let v6 = v2;
        let v7 = v0;
        let v8 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::pools(arg2);
        let v9 = 0;
        while (v9 < 0x1::vector::length<u256>(&v6)) {
            if (*0x1::vector::borrow<u256>(&v6, v9) > 0) {
                let (_, _, _, v13) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_pool_info(0x2::vec_map::get<0x1::ascii::String, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::AssetPool>(v8, 0x1::vector::borrow<0x1::ascii::String>(&v7, v9)));
                let v14 = 0x1::vector::borrow<vector<address>>(&v5, v9);
                let v15 = 0;
                while (v15 < 0x1::vector::length<address>(v14)) {
                    let (_, _, v18, _, _, _, _, _, _, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_rule_info(0x2::vec_map::get<address, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Rule>(v13, 0x1::vector::borrow<address>(v14, v15)));
                    assert!(!v18, 4004);
                    v15 = v15 + 1;
                };
            };
            v9 = v9 + 1;
        };
        let v26 = &arg0.admin_reward_pools;
        let v27 = 0;
        while (v27 < 0x2::vec_map::length<0x1::type_name::TypeName, AdminRewardInfo>(v26)) {
            let (_, v29) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, AdminRewardInfo>(v26, v27);
            assert!(v29.last_updated == 0x1::u64::max(v29.start_time, 0x1::u64::min(0x2::clock::timestamp_ms(arg3), v29.end_time)), 4003);
            v27 = v27 + 1;
        };
    }

    fun assert_storage<T0>(arg0: &Service<T0>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        assert!(0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg1) == arg0.storage_id, 4011);
    }

    fun assert_version<T0>(arg0: &Service<T0>) {
        assert!(arg0.version <= 1, 4002);
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::AdminCap, arg1: &mut Service<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version<T0>(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.fee_collected, v0)) {
            return 0x2::coin::zero<T1>(arg3)
        };
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.fee_collected, v0);
        let v2 = 0x2::balance::value<T1>(v1);
        let v3 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v1, v2), arg3);
        let v4 = ProtocolFeesCollected{
            service_id   : 0x2::object::id<Service<T0>>(arg1),
            reward_type  : v0,
            amount       : v2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            admin        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ProtocolFeesCollected>(v4);
        v3
    }

    public fun collect_strategy_fees<T0, T1>(arg0: &mut 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::Config, arg1: &mut Service<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::PositionCap, arg9: 0x2::object::ID, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version<T0>(arg1);
        assert_storage<T0>(arg1, arg2);
        0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::assert_strategy_creator(arg0, arg9, arg8);
        let v0 = 0x2::object::id<Service<T0>>(arg1);
        if (!0x2::object_table::contains<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg1.strategy_data.strategies, arg9)) {
            return 0x2::coin::zero<T1>(arg11)
        };
        update_all_rewards<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        update_strategy_fees<T0>(arg1, arg9);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, StrategyAllocationDataInner<T0>>(&mut arg1.strategy_data.strategies, arg9);
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v1.pending_fees, &v2)) {
            return 0x2::coin::zero<T1>(arg11)
        };
        let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v1.pending_fees, &v2);
        let v4 = *v3;
        *v3 = 0;
        let v5 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.rewards, v2);
        let v6 = if (v4 > 0x2::balance::value<T1>(v5)) {
            0x2::balance::value<T1>(v5)
        } else {
            v4
        };
        let v7 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v5, v6), arg11);
        let v8 = StrategyFeesCollected{
            service_id             : v0,
            strategy_id            : arg9,
            strategy_allocation_id : 0x2::object::id<StrategyAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg1.strategy_data.strategies, arg9)),
            reward_type            : v2,
            amount                 : v6,
            timestamp_ms           : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<StrategyFeesCollected>(v8);
        v7
    }

    public fun collect_user_rewards<T0, T1>(arg0: &mut Service<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::PositionCap, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version<T0>(arg0);
        assert_storage<T0>(arg0, arg1);
        let v0 = 0x2::object::id<0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::PositionCap>(arg7);
        let v1 = 0x2::object::id<Service<T0>>(arg0);
        if (!0x2::object_table::contains<0x2::object::ID, UserAllocationDataInner<T0>>(&arg0.user_data.position_cap_data, v0)) {
            return 0x2::coin::zero<T1>(arg9)
        };
        update_all_rewards<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9);
        update_user_global_rewards<T0>(arg0, v0);
        let v2 = 0x2::object_table::borrow_mut<0x2::object::ID, UserAllocationDataInner<T0>>(&mut arg0.user_data.position_cap_data, v0);
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v2.pending_rewards, &v3)) {
            return 0x2::coin::zero<T1>(arg9)
        };
        let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v2.pending_rewards, &v3);
        let v5 = *v4;
        *v4 = 0;
        let v6 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v3);
        let v7 = if (v5 > 0x2::balance::value<T1>(v6)) {
            0x2::balance::value<T1>(v6)
        } else {
            v5
        };
        let v8 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v6, v7), arg9);
        let v9 = UserRewardsCollected{
            service_id         : v1,
            position_cap_id    : v0,
            user_allocation_id : 0x2::object::id<UserAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, UserAllocationDataInner<T0>>(&arg0.user_data.position_cap_data, v0)),
            reward_type        : v3,
            amount             : v7,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg8),
            claimer            : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<UserRewardsCollected>(v9);
        v8
    }

    public fun create_service<T0>(arg0: &0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::AdminCap, arg1: &mut 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::Config, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 <= 10000, 4009);
        assert!(arg5 <= 10000, 4009);
        assert!(arg3 < 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg2), 4012);
        assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg2, arg3) == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 4012);
        let v0 = 0x2::object::new(arg8);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = UserAllocationData<T0>{
            position_cap_data         : 0x2::object_table::new<0x2::object::ID, UserAllocationDataInner<T0>>(arg8),
            accrued_rewards_per_share : 0x2::vec_map::empty<0x1::type_name::TypeName, u128>(),
        };
        let v3 = StrategyAllocationData<T0>{
            strategies             : 0x2::object_table::new<0x2::object::ID, StrategyAllocationDataInner<T0>>(arg8),
            accrued_fees_per_share : 0x2::vec_map::empty<0x1::type_name::TypeName, u128>(),
        };
        let v4 = Service<T0>{
            id                           : v0,
            version                      : 1,
            service_cap                  : 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::create_service_cap<T0>(arg0, arg1, v1, arg7, arg8),
            protocol_position_cap        : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg8),
            asset_id                     : arg3,
            storage_id                   : 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg2),
            user_data                    : v2,
            strategy_data                : v3,
            rewards                      : 0x2::bag::new(arg8),
            admin_reward_pools           : 0x2::vec_map::empty<0x1::type_name::TypeName, AdminRewardInfo>(),
            external_rewards_distributed : 0x2::vec_map::empty<0x1::type_name::TypeName, u128>(),
            fee_collected                : 0x2::bag::new(arg8),
            total_shares                 : 0,
            total_supplied               : 0,
            platform_fee_bps             : arg4,
            strategy_fee_bps             : arg5,
            min_reward_duration_ms       : arg6,
            is_paused                    : false,
        };
        let v5 = ServiceCreated{
            service_id   : v1,
            coin_type    : 0x1::type_name::with_defining_ids<T0>(),
            timestamp_ms : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<ServiceCreated>(v5);
        0x2::transfer::share_object<Service<T0>>(v4);
    }

    public fun deposit<T0>(arg0: &mut 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::Config, arg1: &mut Service<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::PositionCap, arg9: 0x2::object::ID, arg10: 0x2::coin::Coin<T0>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        assert_storage<T0>(arg1, arg2);
        assert!(!arg1.is_paused, 4005);
        0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::assert_strategy_active(arg0, arg9);
        assert_all_rewards_collected<T0>(arg1, arg2, arg5, arg11);
        update_protocol_yield<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg11, arg12);
        let v0 = 0x2::coin::value<T0>(&arg10);
        let v1 = 0x2::object::id<0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::PositionCap>(arg8);
        let v2 = 0x2::object::id<Service<T0>>(arg1);
        0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::record_service_investment(&arg1.service_cap, arg0, v1, 0x1::type_name::with_defining_ids<T0>());
        if (!0x2::object_table::contains<0x2::object::ID, UserAllocationDataInner<T0>>(&arg1.user_data.position_cap_data, v1)) {
            let v3 = UserAllocationDataInner<T0>{
                id                             : 0x2::object::new(arg12),
                strategy_allocations           : 0x2::vec_map::empty<0x2::object::ID, u64>(),
                last_accrued_rewards_per_share : 0x2::vec_map::empty<0x1::type_name::TypeName, u128>(),
                pending_rewards                : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                total_shares                   : 0,
            };
            0x2::object_table::add<0x2::object::ID, UserAllocationDataInner<T0>>(&mut arg1.user_data.position_cap_data, v1, v3);
        };
        if (!0x2::object_table::contains<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg1.strategy_data.strategies, arg9)) {
            let v4 = StrategyAllocationDataInner<T0>{
                id                          : 0x2::object::new(arg12),
                strategy_id                 : arg9,
                last_accrued_fees_per_share : 0x2::vec_map::empty<0x1::type_name::TypeName, u128>(),
                pending_fees                : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                total_shares                : 0,
            };
            0x2::object_table::add<0x2::object::ID, StrategyAllocationDataInner<T0>>(&mut arg1.strategy_data.strategies, arg9, v4);
        };
        update_user_global_rewards<T0>(arg1, v1);
        update_strategy_fees<T0>(arg1, arg9);
        let v5 = get_exchange_rate<T0>(arg1);
        let v6 = (((v0 as u128) * 1000000000000 / v5) as u64);
        assert!(v6 > 0, 4006);
        let v7 = 0x2::object_table::borrow_mut<0x2::object::ID, UserAllocationDataInner<T0>>(&mut arg1.user_data.position_cap_data, v1);
        if (!0x2::vec_map::contains<0x2::object::ID, u64>(&v7.strategy_allocations, &arg9)) {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut v7.strategy_allocations, arg9, 0);
        };
        let v8 = 0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut v7.strategy_allocations, &arg9);
        *v8 = *v8 + v6;
        v7.total_shares = v7.total_shares + v6;
        let v9 = 0x2::object_table::borrow_mut<0x2::object::ID, StrategyAllocationDataInner<T0>>(&mut arg1.strategy_data.strategies, arg9);
        v9.total_shares = v9.total_shares + v6;
        arg1.total_shares = arg1.total_shares + v6;
        0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::update_subscriber_investment(&arg1.service_cap, arg0, v1, arg9, (((*v8 as u128) * v5 / 1000000000000) as u64));
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg11, arg2, arg3, arg1.asset_id, arg10, arg4, arg5, &arg1.protocol_position_cap);
        arg1.total_supplied = actual_supplied<T0>(arg1, arg2, arg3, arg11);
        let v10 = Deposited{
            service_id             : v2,
            position_cap_id        : v1,
            user_allocation_id     : 0x2::object::id<UserAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, UserAllocationDataInner<T0>>(&arg1.user_data.position_cap_data, v1)),
            strategy_id            : arg9,
            strategy_allocation_id : 0x2::object::id<StrategyAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg1.strategy_data.strategies, arg9)),
            amount                 : v0,
            shares_minted          : v6,
            total_supplied         : arg1.total_supplied,
            total_shares           : arg1.total_shares,
            timestamp_ms           : 0x2::clock::timestamp_ms(arg11),
            depositor              : 0x2::tx_context::sender(arg12),
        };
        0x2::event::emit<Deposited>(v10);
    }

    public fun deposit_for_rebalance<T0>(arg0: &mut 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::Config, arg1: &mut Service<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: u64, arg9: &mut 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::RebalancePotato<T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        assert_storage<T0>(arg1, arg2);
        assert!(!arg1.is_paused, 4005);
        let v0 = 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::position_cap_id<T0>(arg9);
        let v1 = 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::strategy_id<T0>(arg9);
        0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::assert_strategy_active(arg0, v1);
        assert_all_rewards_collected<T0>(arg1, arg2, arg5, arg10);
        update_protocol_yield<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        let v2 = 0x2::object::id<Service<T0>>(arg1);
        if (!0x2::object_table::contains<0x2::object::ID, UserAllocationDataInner<T0>>(&arg1.user_data.position_cap_data, v0)) {
            let v3 = UserAllocationDataInner<T0>{
                id                             : 0x2::object::new(arg11),
                strategy_allocations           : 0x2::vec_map::empty<0x2::object::ID, u64>(),
                last_accrued_rewards_per_share : 0x2::vec_map::empty<0x1::type_name::TypeName, u128>(),
                pending_rewards                : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                total_shares                   : 0,
            };
            0x2::object_table::add<0x2::object::ID, UserAllocationDataInner<T0>>(&mut arg1.user_data.position_cap_data, v0, v3);
        };
        if (!0x2::object_table::contains<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg1.strategy_data.strategies, v1)) {
            let v4 = StrategyAllocationDataInner<T0>{
                id                          : 0x2::object::new(arg11),
                strategy_id                 : v1,
                last_accrued_fees_per_share : 0x2::vec_map::empty<0x1::type_name::TypeName, u128>(),
                pending_fees                : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                total_shares                : 0,
            };
            0x2::object_table::add<0x2::object::ID, StrategyAllocationDataInner<T0>>(&mut arg1.strategy_data.strategies, v1, v4);
        };
        update_user_global_rewards<T0>(arg1, v0);
        update_strategy_fees<T0>(arg1, v1);
        let v5 = get_exchange_rate<T0>(arg1);
        let v6 = (((arg8 as u128) * 1000000000000 / v5) as u64);
        let v7 = 0x2::object_table::borrow_mut<0x2::object::ID, UserAllocationDataInner<T0>>(&mut arg1.user_data.position_cap_data, v0);
        if (!0x2::vec_map::contains<0x2::object::ID, u64>(&v7.strategy_allocations, &v1)) {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut v7.strategy_allocations, v1, 0);
        };
        let v8 = 0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut v7.strategy_allocations, &v1);
        *v8 = *v8 + v6;
        v7.total_shares = v7.total_shares + v6;
        let v9 = 0x2::object_table::borrow_mut<0x2::object::ID, StrategyAllocationDataInner<T0>>(&mut arg1.strategy_data.strategies, v1);
        v9.total_shares = v9.total_shares + v6;
        arg1.total_shares = arg1.total_shares + v6;
        0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::update_subscriber_investment(&arg1.service_cap, arg0, v0, v1, (((*v8 as u128) * v5 / 1000000000000) as u64));
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg10, arg2, arg3, arg1.asset_id, 0x2::coin::from_balance<T0>(0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::take_from_potato<T0>(arg9, &arg1.service_cap, arg8), arg11), arg4, arg5, &arg1.protocol_position_cap);
        arg1.total_supplied = actual_supplied<T0>(arg1, arg2, arg3, arg10);
        let v10 = RebalanceDeposit{
            service_id             : v2,
            position_cap_id        : v0,
            user_allocation_id     : 0x2::object::id<UserAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, UserAllocationDataInner<T0>>(&arg1.user_data.position_cap_data, v0)),
            strategy_id            : v1,
            strategy_allocation_id : 0x2::object::id<StrategyAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg1.strategy_data.strategies, v1)),
            amount                 : arg8,
            shares_minted          : v6,
            total_supplied         : arg1.total_supplied,
            total_shares           : arg1.total_shares,
            timestamp_ms           : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<RebalanceDeposit>(v10);
    }

    fun emit_service_updated<T0>(arg0: &Service<T0>, arg1: &0x2::clock::Clock) {
        let v0 = ServiceUpdated<T0>{
            service_id                   : 0x2::object::id<Service<T0>>(arg0),
            total_supplied               : arg0.total_supplied,
            total_shares                 : arg0.total_shares,
            accrued_rewards_per_share    : arg0.user_data.accrued_rewards_per_share,
            external_rewards_distributed : arg0.external_rewards_distributed,
            timestamp_ms                 : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ServiceUpdated<T0>>(v0);
    }

    fun fee_from_bps(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun get_actual_supplied<T0>(arg0: &Service<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &0x2::clock::Clock) : u64 {
        actual_supplied<T0>(arg0, arg1, arg2, arg3)
    }

    fun get_exchange_rate<T0>(arg0: &Service<T0>) : u128 {
        if (arg0.total_shares == 0) {
            return 1000000000000
        };
        (arg0.total_supplied as u128) * 1000000000000 / (arg0.total_shares as u128)
    }

    fun index_delta(arg0: u64, arg1: u64) : u128 {
        if (arg1 == 0) {
            return 0
        };
        (arg0 as u128) * 1000000000000 / (arg1 as u128)
    }

    public fun pause_service<T0>(arg0: &0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::AdminCap, arg1: &mut Service<T0>, arg2: &0x2::clock::Clock) {
        assert_version<T0>(arg1);
        arg1.is_paused = true;
        let v0 = ServicePaused{
            service_id   : 0x2::object::id<Service<T0>>(arg1),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ServicePaused>(v0);
    }

    public fun set_fee_bps<T0>(arg0: &0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::AdminCap, arg1: &mut Service<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_version<T0>(arg1);
        assert!(arg2 <= 10000, 4009);
        assert!(arg3 <= 10000, 4009);
        arg1.platform_fee_bps = arg2;
        arg1.strategy_fee_bps = arg3;
        let v0 = FeeBpsUpdated{
            service_id       : 0x2::object::id<Service<T0>>(arg1),
            old_platform_bps : arg1.platform_fee_bps,
            new_platform_bps : arg2,
            old_strategy_bps : arg1.strategy_fee_bps,
            new_strategy_bps : arg3,
            timestamp_ms     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<FeeBpsUpdated>(v0);
    }

    public fun set_min_reward_duration<T0>(arg0: &0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::AdminCap, arg1: &mut Service<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version<T0>(arg1);
        arg1.min_reward_duration_ms = arg2;
        let v0 = MinRewardDurationUpdated{
            service_id   : 0x2::object::id<Service<T0>>(arg1),
            old_ms       : arg1.min_reward_duration_ms,
            new_ms       : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MinRewardDurationUpdated>(v0);
    }

    public fun unpause_service<T0>(arg0: &0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::AdminCap, arg1: &mut Service<T0>, arg2: &0x2::clock::Clock) {
        assert_version<T0>(arg1);
        arg1.is_paused = false;
        let v0 = ServiceUnpaused{
            service_id   : 0x2::object::id<Service<T0>>(arg1),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ServiceUnpaused>(v0);
    }

    public fun update_admin_rewards<T0, T1>(arg0: &mut Service<T0>, arg1: &0x2::clock::Clock) {
        assert_version<T0>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, AdminRewardInfo>(&arg0.admin_reward_pools, &v0)) {
            let v1 = 0x2::clock::timestamp_ms(arg1);
            let v2 = 0x2::vec_map::get<0x1::type_name::TypeName, AdminRewardInfo>(&arg0.admin_reward_pools, &v0);
            let v3 = 0x1::u64::max(v2.start_time, v2.last_updated);
            let v4 = 0x1::u64::min(v2.end_time, v1);
            let v5 = if (v4 > v3) {
                ((((v4 - v3) as u128) * v2.reward_per_ms / 1000000000000) as u64)
            } else {
                0
            };
            if (v4 > v3) {
                if (v5 > 0 && arg0.total_shares > 0) {
                    if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0)) {
                        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0, 0x2::balance::zero<T1>());
                    };
                    0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0), 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut 0x2::vec_map::get_mut<0x1::type_name::TypeName, AdminRewardInfo>(&mut arg0.admin_reward_pools, &v0).id, v0), v5));
                    if (!0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg0.user_data.accrued_rewards_per_share, &v0)) {
                        0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut arg0.user_data.accrued_rewards_per_share, v0, 0);
                    };
                    let v6 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u128>(&mut arg0.user_data.accrued_rewards_per_share, &v0);
                    *v6 = *v6 + index_delta(v5, arg0.total_shares);
                    let v7 = AdminRewardsReleased{
                        service_id   : 0x2::object::id<Service<T0>>(arg0),
                        reward_type  : v0,
                        amount       : v5,
                        timestamp_ms : v1,
                    };
                    0x2::event::emit<AdminRewardsReleased>(v7);
                };
                0x2::vec_map::get_mut<0x1::type_name::TypeName, AdminRewardInfo>(&mut arg0.admin_reward_pools, &v0).last_updated = v4;
            };
            if (v1 >= v2.end_time) {
                let (_, v9) = 0x2::vec_map::remove<0x1::type_name::TypeName, AdminRewardInfo>(&mut arg0.admin_reward_pools, &v0);
                let AdminRewardInfo {
                    id            : v10,
                    last_updated  : _,
                    start_time    : _,
                    end_time      : _,
                    reward_per_ms : _,
                } = v9;
                let v15 = v10;
                let v16 = 0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v15, v0);
                if (0x2::balance::value<T1>(&v16) > 0) {
                    if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0)) {
                        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0, 0x2::balance::zero<T1>());
                    };
                    0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0), v16);
                } else {
                    0x2::balance::destroy_zero<T1>(v16);
                };
                0x2::object::delete(v15);
            };
        };
        emit_service_updated<T0>(arg0, arg1);
    }

    fun update_all_rewards<T0, T1>(arg0: &mut Service<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        update_protocol_yield<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        update_admin_rewards<T0, T1>(arg0, arg7);
    }

    public fun update_external_incentives<T0, T1>(arg0: &mut Service<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T1>, arg4: vector<0x1::ascii::String>, arg5: vector<address>, arg6: &0x2::clock::Clock) {
        assert_version<T0>(arg0);
        assert_storage<T0>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T1>(arg6, arg2, arg1, arg3, arg4, arg5, &arg0.protocol_position_cap);
        let v2 = 0x2::balance::value<T1>(&v1);
        if (v2 > 0) {
            let v3 = fee_from_bps(v2, arg0.platform_fee_bps);
            let v4 = v2 - v3;
            if (v3 > 0) {
                let v5 = fee_from_bps(v3, arg0.strategy_fee_bps);
                if (arg0.total_shares > 0 && v5 > 0) {
                    if (!0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg0.strategy_data.accrued_fees_per_share, &v0)) {
                        0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut arg0.strategy_data.accrued_fees_per_share, v0, 0);
                    };
                    let v6 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u128>(&mut arg0.strategy_data.accrued_fees_per_share, &v0);
                    *v6 = *v6 + index_delta(v5, arg0.total_shares);
                };
                if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_collected, v0)) {
                    0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.fee_collected, v0, 0x2::balance::zero<T1>());
                };
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.fee_collected, v0), 0x2::balance::split<T1>(&mut v1, v3 - v5));
            };
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0)) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0, 0x2::balance::zero<T1>());
            };
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0), v1);
            if (arg0.total_shares > 0) {
                if (!0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg0.user_data.accrued_rewards_per_share, &v0)) {
                    0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut arg0.user_data.accrued_rewards_per_share, v0, 0);
                };
                let v7 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u128>(&mut arg0.user_data.accrued_rewards_per_share, &v0);
                *v7 = *v7 + index_delta(v4, arg0.total_shares);
                if (!0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg0.external_rewards_distributed, &v0)) {
                    0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut arg0.external_rewards_distributed, v0, 0);
                };
                let v8 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u128>(&mut arg0.external_rewards_distributed, &v0);
                *v8 = *v8 + (v4 as u128);
            };
            let v9 = ExternalIncentivesClaimed{
                service_id   : 0x2::object::id<Service<T0>>(arg0),
                reward_type  : v0,
                gross        : v2,
                fee          : v3,
                net          : v4,
                timestamp_ms : 0x2::clock::timestamp_ms(arg6),
            };
            0x2::event::emit<ExternalIncentivesClaimed>(v9);
        } else {
            0x2::balance::destroy_zero<T1>(v1);
        };
        emit_service_updated<T0>(arg0, arg6);
    }

    fun update_protocol_yield<T0>(arg0: &mut Service<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = actual_supplied<T0>(arg0, arg1, arg2, arg7);
        if (v1 > arg0.total_supplied) {
            let v2 = v1 - arg0.total_supplied;
            let v3 = fee_from_bps(v2, arg0.platform_fee_bps);
            let v4 = v3;
            if (v3 > 0) {
                let v5 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg7, arg5, arg1, arg2, arg0.asset_id, v3, arg3, arg4, &arg0.protocol_position_cap, arg6, arg8);
                let v6 = 0x2::balance::value<T0>(&v5);
                v4 = v6;
                let v7 = fee_from_bps(v6, arg0.strategy_fee_bps);
                if (arg0.total_shares > 0 && v7 > 0) {
                    if (!0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg0.strategy_data.accrued_fees_per_share, &v0)) {
                        0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut arg0.strategy_data.accrued_fees_per_share, v0, 0);
                    };
                    let v8 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u128>(&mut arg0.strategy_data.accrued_fees_per_share, &v0);
                    *v8 = *v8 + index_delta(v7, arg0.total_shares);
                };
                if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_collected, v0)) {
                    0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_collected, v0, 0x2::balance::zero<T0>());
                };
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_collected, v0), 0x2::balance::split<T0>(&mut v5, v6 - v7));
                if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0)) {
                    0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards, v0, 0x2::balance::zero<T0>());
                };
                0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards, v0), v5);
            };
            arg0.total_supplied = actual_supplied<T0>(arg0, arg1, arg2, arg7);
            let v9 = ProtocolYieldAccrued{
                service_id   : 0x2::object::id<Service<T0>>(arg0),
                coin_type    : v0,
                gross        : v2,
                fee          : v4,
                net          : v2 - v4,
                timestamp_ms : 0x2::clock::timestamp_ms(arg7),
            };
            0x2::event::emit<ProtocolYieldAccrued>(v9);
        } else if (v1 < arg0.total_supplied) {
            arg0.total_supplied = v1;
            let v10 = ProtocolLossRealized{
                service_id   : 0x2::object::id<Service<T0>>(arg0),
                coin_type    : v0,
                loss         : arg0.total_supplied - v1,
                timestamp_ms : 0x2::clock::timestamp_ms(arg7),
            };
            0x2::event::emit<ProtocolLossRealized>(v10);
        };
        emit_service_updated<T0>(arg0, arg7);
    }

    fun update_strategy_fees<T0>(arg0: &mut Service<T0>, arg1: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::length<0x1::type_name::TypeName, u128>(&arg0.strategy_data.accrued_fees_per_share)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u128>(&arg0.strategy_data.accrued_fees_per_share, v0);
            let v3 = *v1;
            let v4 = *v2;
            let v3 = v3;
            if (!0x2::object_table::contains<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg0.strategy_data.strategies, arg1)) {
                return
            };
            let v5 = 0x2::object_table::borrow_mut<0x2::object::ID, StrategyAllocationDataInner<T0>>(&mut arg0.strategy_data.strategies, arg1);
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&v5.last_accrued_fees_per_share, &v3)) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut v5.last_accrued_fees_per_share, v3, 0);
            };
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v5.pending_fees, &v3)) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v5.pending_fees, v3, 0);
            };
            let v6 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u128>(&mut v5.last_accrued_fees_per_share, &v3);
            let v7 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v5.pending_fees, &v3);
            *v7 = *v7 + (((v4 - *v6) * (v5.total_shares as u128) / 1000000000000) as u64);
            *v6 = v4;
            v0 = v0 + 1;
        };
    }

    fun update_user_global_rewards<T0>(arg0: &mut Service<T0>, arg1: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::length<0x1::type_name::TypeName, u128>(&arg0.user_data.accrued_rewards_per_share)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u128>(&arg0.user_data.accrued_rewards_per_share, v0);
            let v3 = *v1;
            let v4 = *v2;
            let v3 = v3;
            let v5 = 0x2::object_table::borrow_mut<0x2::object::ID, UserAllocationDataInner<T0>>(&mut arg0.user_data.position_cap_data, arg1);
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&v5.last_accrued_rewards_per_share, &v3)) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut v5.last_accrued_rewards_per_share, v3, 0);
            };
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v5.pending_rewards, &v3)) {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v5.pending_rewards, v3, 0);
            };
            let v6 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u128>(&mut v5.last_accrued_rewards_per_share, &v3);
            let v7 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v5.pending_rewards, &v3);
            *v7 = *v7 + (((v4 - *v6) * (v5.total_shares as u128) / 1000000000000) as u64);
            *v6 = v4;
            v0 = v0 + 1;
        };
    }

    public fun update_version<T0>(arg0: &0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::AdminCap, arg1: &mut Service<T0>) {
        assert_version<T0>(arg1);
        arg1.version = 1;
    }

    public fun withdraw<T0>(arg0: &mut 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::Config, arg1: &mut Service<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::PositionCap, arg9: 0x2::object::ID, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg1);
        assert_storage<T0>(arg1, arg2);
        assert_all_rewards_collected<T0>(arg1, arg2, arg5, arg11);
        update_protocol_yield<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg11, arg12);
        let v0 = 0x2::object::id<0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::PositionCap>(arg8);
        let v1 = 0x2::object::id<Service<T0>>(arg1);
        update_user_global_rewards<T0>(arg1, v0);
        update_strategy_fees<T0>(arg1, arg9);
        let v2 = get_exchange_rate<T0>(arg1);
        let v3 = (((arg10 as u128) * v2 / 1000000000000) as u64);
        assert!(v3 > 0, 4010);
        let v4 = 0x2::object_table::borrow_mut<0x2::object::ID, UserAllocationDataInner<T0>>(&mut arg1.user_data.position_cap_data, v0);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&v4.strategy_allocations, &arg9), 4000);
        let v5 = 0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut v4.strategy_allocations, &arg9);
        assert!(*v5 >= arg10, 4000);
        *v5 = *v5 - arg10;
        v4.total_shares = v4.total_shares - arg10;
        let v6 = 0x2::object_table::borrow_mut<0x2::object::ID, StrategyAllocationDataInner<T0>>(&mut arg1.strategy_data.strategies, arg9);
        v6.total_shares = v6.total_shares - arg10;
        arg1.total_shares = arg1.total_shares - arg10;
        0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::update_subscriber_investment(&arg1.service_cap, arg0, v0, arg9, (((*v5 as u128) * v2 / 1000000000000) as u64));
        let v7 = 0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg11, arg6, arg2, arg3, arg1.asset_id, v3, arg4, arg5, &arg1.protocol_position_cap, arg7, arg12), arg12);
        arg1.total_supplied = actual_supplied<T0>(arg1, arg2, arg3, arg11);
        let v8 = Withdrawn{
            service_id             : v1,
            position_cap_id        : v0,
            user_allocation_id     : 0x2::object::id<UserAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, UserAllocationDataInner<T0>>(&arg1.user_data.position_cap_data, v0)),
            strategy_id            : arg9,
            strategy_allocation_id : 0x2::object::id<StrategyAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg1.strategy_data.strategies, arg9)),
            shares_burned          : arg10,
            amount                 : 0x2::coin::value<T0>(&v7),
            total_supplied         : arg1.total_supplied,
            total_shares           : arg1.total_shares,
            timestamp_ms           : 0x2::clock::timestamp_ms(arg11),
            withdrawer             : 0x2::tx_context::sender(arg12),
        };
        0x2::event::emit<Withdrawn>(v8);
        v7
    }

    public fun withdraw_for_rebalance<T0>(arg0: &mut 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::Config, arg1: &mut Service<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: u64, arg9: &mut 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::RebalancePotato<T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        assert_storage<T0>(arg1, arg2);
        let v0 = 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::position_cap_id<T0>(arg9);
        let v1 = 0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::strategy_id<T0>(arg9);
        assert_all_rewards_collected<T0>(arg1, arg2, arg5, arg10);
        update_protocol_yield<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        let v2 = 0x2::object::id<Service<T0>>(arg1);
        update_user_global_rewards<T0>(arg1, v0);
        update_strategy_fees<T0>(arg1, v1);
        let v3 = get_exchange_rate<T0>(arg1);
        let v4 = 0x2::object_table::borrow_mut<0x2::object::ID, UserAllocationDataInner<T0>>(&mut arg1.user_data.position_cap_data, v0);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&v4.strategy_allocations, &v1), 4000);
        let v5 = 0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut v4.strategy_allocations, &v1);
        assert!(*v5 >= arg8, 4000);
        *v5 = *v5 - arg8;
        v4.total_shares = v4.total_shares - arg8;
        let v6 = 0x2::object_table::borrow_mut<0x2::object::ID, StrategyAllocationDataInner<T0>>(&mut arg1.strategy_data.strategies, v1);
        v6.total_shares = v6.total_shares - arg8;
        arg1.total_shares = arg1.total_shares - arg8;
        0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::update_subscriber_investment(&arg1.service_cap, arg0, v0, v1, (((*v5 as u128) * v3 / 1000000000000) as u64));
        let v7 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg10, arg6, arg2, arg3, arg1.asset_id, (((arg8 as u128) * v3 / 1000000000000) as u64), arg4, arg5, &arg1.protocol_position_cap, arg7, arg11);
        arg1.total_supplied = actual_supplied<T0>(arg1, arg2, arg3, arg10);
        let v8 = RebalanceWithdrawal{
            service_id             : v2,
            position_cap_id        : v0,
            user_allocation_id     : 0x2::object::id<UserAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, UserAllocationDataInner<T0>>(&arg1.user_data.position_cap_data, v0)),
            strategy_id            : v1,
            strategy_allocation_id : 0x2::object::id<StrategyAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg1.strategy_data.strategies, v1)),
            shares_burned          : arg8,
            amount                 : 0x2::balance::value<T0>(&v7),
            total_supplied         : arg1.total_supplied,
            total_shares           : arg1.total_shares,
            timestamp_ms           : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<RebalanceWithdrawal>(v8);
        0x4e7a88928046bec2d8eedee13a187dd4e4825b446ef6aef9aa74502f1195ca10::diversify_core::add_to_potato<T0>(arg9, &arg1.service_cap, v7);
    }

    // decompiled from Move bytecode v7
}

