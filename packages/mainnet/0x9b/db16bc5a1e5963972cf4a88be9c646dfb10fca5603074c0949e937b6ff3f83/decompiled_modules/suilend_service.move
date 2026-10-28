module 0x9bdb16bc5a1e5963972cf4a88be9c646dfb10fca5603074c0949e937b6ff3f83::suilend_service {
    struct ServiceCreated has copy, drop {
        service_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        loss_min_balance: u64,
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

    struct RebalanceRefreshed has copy, drop {
        service_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        user_allocation_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        strategy_allocation_id: 0x2::object::ID,
        value: u64,
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
        external_rewards_per_share: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
        reserve: u64,
        unpaid_fee: u64,
        peak_rate: u128,
        in_emergency: bool,
        is_paused: bool,
        timestamp_ms: u64,
    }

    struct ProtocolYieldAccrued has copy, drop {
        service_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        gross: u64,
        fee: u64,
        net: u64,
        fee_unpaid: u64,
        timestamp_ms: u64,
    }

    struct ProtocolLossRealized has copy, drop {
        service_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        loss: u64,
        timestamp_ms: u64,
    }

    struct ServiceAutoPaused has copy, drop {
        service_id: 0x2::object::ID,
        rate: u128,
        peak_rate: u128,
        drawdown_bps: u64,
        threshold_bps: u64,
        timestamp_ms: u64,
    }

    struct EmergencyEntered has copy, drop {
        service_id: 0x2::object::ID,
        by_admin: bool,
        rate: u128,
        peak_rate: u128,
        drawdown_bps: u64,
        timestamp_ms: u64,
    }

    struct EmergencyPullFailed has copy, drop {
        service_id: 0x2::object::ID,
        by_admin: bool,
        rate: u128,
        peak_rate: u128,
        drawdown_bps: u64,
        timestamp_ms: u64,
    }

    struct ReserveFilled has copy, drop {
        service_id: 0x2::object::ID,
        amount: u64,
        reserve: u64,
        held: u64,
        timestamp_ms: u64,
    }

    struct ServiceResumed has copy, drop {
        service_id: 0x2::object::ID,
        amount_redeposited: u64,
        rate: u128,
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

    struct DepositCapUpdated has copy, drop {
        service_id: 0x2::object::ID,
        old_cap: u64,
        new_cap: u64,
        timestamp_ms: u64,
    }

    struct LossSettingsUpdated has copy, drop {
        service_id: 0x2::object::ID,
        old_pause_bps: u64,
        new_pause_bps: u64,
        old_exit_bps: u64,
        new_exit_bps: u64,
        old_min_balance: u64,
        new_min_balance: u64,
        timestamp_ms: u64,
    }

    struct Service<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        service_cap: 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::ServiceCap,
        protocol_position_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>,
        reserve_array_index: u64,
        user_data: UserAllocationData<T0>,
        strategy_data: StrategyAllocationData<T0>,
        rewards: 0x2::bag::Bag,
        admin_reward_pools: 0x2::vec_map::VecMap<0x1::type_name::TypeName, AdminRewardInfo>,
        external_rewards_per_share: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
        fee_collected: 0x2::bag::Bag,
        total_shares: u64,
        total_supplied: u64,
        platform_fee_bps: u64,
        strategy_fee_bps: u64,
        min_reward_duration_ms: u64,
        is_paused: bool,
        peak_rate: u128,
        reserve: 0x2::balance::Balance<T0>,
        in_emergency: bool,
        unpaid_fee: u64,
        deposit_cap: u64,
        loss_pause_bps: u64,
        loss_exit_bps: u64,
        loss_min_balance: u64,
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

    fun actual_supplied<T0>(arg0: &Service<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock) : u64 {
        protocol_supplied<T0>(arg0, arg1, arg2) + 0x2::balance::value<T0>(&arg0.reserve)
    }

    public fun admin_add_reward<T0, T1>(arg0: &mut Service<T0>, arg1: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::AdminCap, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
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

    fun assert_all_rewards_collected<T0>(arg0: &Service<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: bool, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = if (arg2) {
            reward_manager_index<T0>(arg0, arg1)
        } else {
            0x1::option::none<u64>()
        };
        let v2 = v1;
        if (0x1::option::is_some<u64>(&v2)) {
            let v3 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserRewardManager>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::user_reward_managers<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&arg0.protocol_position_cap))), 0x1::option::destroy_some<u64>(v2));
            let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::rewards(v3);
            let v5 = 0;
            while (v5 < 0x1::vector::length<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>>(v4)) {
                if (0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>(0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>>(v4, v5))) {
                    assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::earned_rewards(0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>(0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>>(v4, v5)))) == 0, 4004);
                };
                v5 = v5 + 1;
            };
            let v6 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::last_update_time_ms(v3);
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::shares(v3) > 0 && v6 != v0) {
                let v7 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::pool_rewards(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::deposits_pool_reward_manager<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1), arg0.reserve_array_index)));
                let v8 = 0;
                while (v8 < 0x1::vector::length<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>>(v7)) {
                    if (0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>(0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>>(v7, v8))) {
                        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::end_time_ms(0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>(0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>>(v7, v8))) <= v6, 4004);
                    };
                    v8 = v8 + 1;
                };
            };
        };
        let v9 = &arg0.admin_reward_pools;
        let v10 = 0;
        while (v10 < 0x2::vec_map::length<0x1::type_name::TypeName, AdminRewardInfo>(v9)) {
            let (_, v12) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, AdminRewardInfo>(v9, v10);
            assert!(v12.last_updated == 0x1::u64::max(v12.start_time, 0x1::u64::min(v0, v12.end_time)), 4003);
            v10 = v10 + 1;
        };
    }

    fun assert_version<T0>(arg0: &Service<T0>) {
        assert!(arg0.version <= 1, 4002);
    }

    public fun check_service_health<T0>(arg0: &mut Service<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg3 > 0, 4010);
        let v0 = arg0.in_emergency;
        update_protocol_yield<T0>(arg0, arg1, arg2, arg4, arg5);
        if (v0) {
            exit_pull<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
            emit_service_updated<T0>(arg0, arg4);
        };
    }

    fun claimable_reward_slots<T0, T1>(arg0: &Service<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock) : vector<u64> {
        let v0 = vector[];
        let v1 = reward_manager_index<T0>(arg0, arg1);
        if (0x1::option::is_none<u64>(&v1)) {
            return v0
        };
        let v2 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserRewardManager>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::user_reward_managers<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&arg0.protocol_position_cap))), 0x1::option::destroy_some<u64>(v1));
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::rewards(v2);
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::pool_rewards(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::deposits_pool_reward_manager<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1), arg0.reserve_array_index)));
        let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::last_update_time_ms(v2);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>>(v4)) {
            if (0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>(0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>>(v4, v6))) {
                let v7 = 0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>(0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>>(v4, v6));
                let v8 = v6 < 0x1::vector::length<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>>(v3) && 0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>(0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>>(v3, v6));
                let v9 = v5 != 0x2::clock::timestamp_ms(arg2) && v5 < 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::end_time_ms(v7);
                if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::coin_type(v7) == 0x1::type_name::with_defining_ids<T1>() && (v8 || v9)) {
                    0x1::vector::push_back<u64>(&mut v0, v6);
                };
            };
            v6 = v6 + 1;
        };
        v0
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::AdminCap, arg1: &mut Service<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
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

    public fun collect_strategy_fees<T0, T1>(arg0: &mut 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::Config, arg1: &mut Service<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::PositionCap, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version<T0>(arg1);
        0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::assert_strategy_creator(arg0, arg5, arg4);
        let v0 = 0x2::object::id<Service<T0>>(arg1);
        if (!0x2::object_table::contains<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg1.strategy_data.strategies, arg5)) {
            return 0x2::coin::zero<T1>(arg7)
        };
        update_all_rewards<T0, T1>(arg1, arg2, arg3, arg6, arg7);
        update_strategy_fees<T0>(arg1, arg5);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, StrategyAllocationDataInner<T0>>(&mut arg1.strategy_data.strategies, arg5);
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v1.pending_fees, &v2)) {
            return 0x2::coin::zero<T1>(arg7)
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
        let v7 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v5, v6), arg7);
        unlist_strategy_if_settled<T0>(arg1, arg0, arg5, arg6);
        let v8 = StrategyFeesCollected{
            service_id             : v0,
            strategy_id            : arg5,
            strategy_allocation_id : 0x2::object::id<StrategyAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg1.strategy_data.strategies, arg5)),
            reward_type            : v2,
            amount                 : v6,
            timestamp_ms           : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<StrategyFeesCollected>(v8);
        v7
    }

    public fun collect_user_rewards<T0, T1>(arg0: &mut Service<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::PositionCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version<T0>(arg0);
        let v0 = 0x2::object::id<0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::PositionCap>(arg3);
        let v1 = 0x2::object::id<Service<T0>>(arg0);
        if (!0x2::object_table::contains<0x2::object::ID, UserAllocationDataInner<T0>>(&arg0.user_data.position_cap_data, v0)) {
            return 0x2::coin::zero<T1>(arg5)
        };
        update_all_rewards<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        update_user_global_rewards<T0>(arg0, v0);
        let v2 = 0x2::object_table::borrow_mut<0x2::object::ID, UserAllocationDataInner<T0>>(&mut arg0.user_data.position_cap_data, v0);
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v2.pending_rewards, &v3)) {
            return 0x2::coin::zero<T1>(arg5)
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
        let v8 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v6, v7), arg5);
        let v9 = UserRewardsCollected{
            service_id         : v1,
            position_cap_id    : v0,
            user_allocation_id : 0x2::object::id<UserAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, UserAllocationDataInner<T0>>(&arg0.user_data.position_cap_data, v0)),
            reward_type        : v3,
            amount             : v7,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg4),
            claimer            : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<UserRewardsCollected>(v9);
        v8
    }

    public fun create_service<T0>(arg0: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::AdminCap, arg1: &mut 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::Config, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 10000, 4009);
        assert!(arg4 <= 10000, 4009);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2);
        assert!(v0 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2)), 4012);
        let v1 = 0x2::object::new(arg8);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = UserAllocationData<T0>{
            position_cap_data         : 0x2::object_table::new<0x2::object::ID, UserAllocationDataInner<T0>>(arg8),
            accrued_rewards_per_share : 0x2::vec_map::empty<0x1::type_name::TypeName, u128>(),
        };
        let v4 = StrategyAllocationData<T0>{
            strategies             : 0x2::object_table::new<0x2::object::ID, StrategyAllocationDataInner<T0>>(arg8),
            accrued_fees_per_share : 0x2::vec_map::empty<0x1::type_name::TypeName, u128>(),
        };
        let v5 = Service<T0>{
            id                         : v1,
            version                    : 1,
            service_cap                : 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::create_service_cap<T0>(arg0, arg1, v2, arg7, arg8),
            protocol_position_cap      : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2, arg8),
            reserve_array_index        : v0,
            user_data                  : v3,
            strategy_data              : v4,
            rewards                    : 0x2::bag::new(arg8),
            admin_reward_pools         : 0x2::vec_map::empty<0x1::type_name::TypeName, AdminRewardInfo>(),
            external_rewards_per_share : 0x2::vec_map::empty<0x1::type_name::TypeName, u128>(),
            fee_collected              : 0x2::bag::new(arg8),
            total_shares               : 0,
            total_supplied             : 0,
            platform_fee_bps           : arg3,
            strategy_fee_bps           : arg4,
            min_reward_duration_ms     : arg5,
            is_paused                  : false,
            peak_rate                  : 1000000000000,
            reserve                    : 0x2::balance::zero<T0>(),
            in_emergency               : false,
            unpaid_fee                 : 0,
            deposit_cap                : 18446744073709551615,
            loss_pause_bps             : 50,
            loss_exit_bps              : 200,
            loss_min_balance           : arg6,
        };
        let v6 = ServiceCreated{
            service_id       : v2,
            coin_type        : 0x1::type_name::with_defining_ids<T0>(),
            loss_min_balance : arg6,
            timestamp_ms     : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<ServiceCreated>(v6);
        0x2::transfer::share_object<Service<T0>>(v5);
    }

    fun ctoken_ratio<T0>(arg0: &Service<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::simulated_ctoken_ratio<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1), arg0.reserve_array_index), arg2)
    }

    fun ctokens_for_amount<T0>(arg0: &Service<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg2), ctoken_ratio<T0>(arg0, arg1, arg3)))
    }

    public fun deposit<T0>(arg0: &mut 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::Config, arg1: &mut Service<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::PositionCap, arg5: 0x2::object::ID, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::assert_strategy_active(arg0, arg5);
        assert_all_rewards_collected<T0>(arg1, arg2, true, arg7);
        update_protocol_yield<T0>(arg1, arg2, arg3, arg7, arg8);
        let v0 = 0x2::coin::value<T0>(&arg6);
        assert!(!arg1.in_emergency, 4015);
        assert!(!arg1.is_paused, 4005);
        assert!((arg1.total_supplied as u128) + (v0 as u128) <= (arg1.deposit_cap as u128), 4017);
        let v1 = 0x2::object::id<0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::PositionCap>(arg4);
        let v2 = 0x2::object::id<Service<T0>>(arg1);
        0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::record_service_investment(&arg1.service_cap, arg0, v1, 0x1::type_name::with_defining_ids<T0>());
        0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::add_active_service(&arg1.service_cap, arg0, arg5, arg7);
        if (!0x2::object_table::contains<0x2::object::ID, UserAllocationDataInner<T0>>(&arg1.user_data.position_cap_data, v1)) {
            let v3 = UserAllocationDataInner<T0>{
                id                             : 0x2::object::new(arg8),
                strategy_allocations           : 0x2::vec_map::empty<0x2::object::ID, u64>(),
                last_accrued_rewards_per_share : 0x2::vec_map::empty<0x1::type_name::TypeName, u128>(),
                pending_rewards                : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                total_shares                   : 0,
            };
            0x2::object_table::add<0x2::object::ID, UserAllocationDataInner<T0>>(&mut arg1.user_data.position_cap_data, v1, v3);
        };
        if (!0x2::object_table::contains<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg1.strategy_data.strategies, arg5)) {
            let v4 = StrategyAllocationDataInner<T0>{
                id                          : 0x2::object::new(arg8),
                strategy_id                 : arg5,
                last_accrued_fees_per_share : 0x2::vec_map::empty<0x1::type_name::TypeName, u128>(),
                pending_fees                : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                total_shares                : 0,
            };
            0x2::object_table::add<0x2::object::ID, StrategyAllocationDataInner<T0>>(&mut arg1.strategy_data.strategies, arg5, v4);
        };
        update_user_global_rewards<T0>(arg1, v1);
        update_strategy_fees<T0>(arg1, arg5);
        let v5 = get_exchange_rate<T0>(arg1);
        let v6 = (((v0 as u128) * 1000000000000 / v5) as u64);
        assert!(v6 > 0, 4006);
        let v7 = 0x2::object_table::borrow_mut<0x2::object::ID, UserAllocationDataInner<T0>>(&mut arg1.user_data.position_cap_data, v1);
        if (!0x2::vec_map::contains<0x2::object::ID, u64>(&v7.strategy_allocations, &arg5)) {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut v7.strategy_allocations, arg5, 0);
        };
        let v8 = 0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut v7.strategy_allocations, &arg5);
        *v8 = *v8 + v6;
        v7.total_shares = v7.total_shares + v6;
        let v9 = 0x2::object_table::borrow_mut<0x2::object::ID, StrategyAllocationDataInner<T0>>(&mut arg1.strategy_data.strategies, arg5);
        v9.total_shares = v9.total_shares + v6;
        arg1.total_shares = arg1.total_shares + v6;
        0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::update_subscriber_investment(&arg1.service_cap, arg0, v1, arg5, (((*v8 as u128) * v5 / 1000000000000) as u64));
        supply<T0>(arg1, arg2, arg6, arg7, arg8);
        let v10 = Deposited{
            service_id             : v2,
            position_cap_id        : v1,
            user_allocation_id     : 0x2::object::id<UserAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, UserAllocationDataInner<T0>>(&arg1.user_data.position_cap_data, v1)),
            strategy_id            : arg5,
            strategy_allocation_id : 0x2::object::id<StrategyAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg1.strategy_data.strategies, arg5)),
            amount                 : v0,
            shares_minted          : v6,
            total_supplied         : arg1.total_supplied,
            total_shares           : arg1.total_shares,
            timestamp_ms           : 0x2::clock::timestamp_ms(arg7),
            depositor              : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<Deposited>(v10);
    }

    public fun deposit_for_bot_rebalance<T0>(arg0: &mut 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::Config, arg1: &mut Service<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: 0x1::option::Option<u64>, arg5: &mut 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::RebalancePotato, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        let v0 = 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::position_cap_id(arg5);
        let v1 = 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::strategy_id(arg5);
        let v2 = if (0x1::option::is_some<u64>(&arg4)) {
            0x1::option::destroy_some<u64>(arg4)
        } else {
            0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::coin_balance<T0>(arg5)
        };
        0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::assert_strategy_active(arg0, v1);
        assert_all_rewards_collected<T0>(arg1, arg2, true, arg6);
        update_protocol_yield<T0>(arg1, arg2, arg3, arg6, arg7);
        assert!(!arg1.in_emergency, 4015);
        assert!(!arg1.is_paused, 4005);
        assert!((arg1.total_supplied as u128) + (v2 as u128) <= (arg1.deposit_cap as u128), 4017);
        let v3 = 0x2::object::id<Service<T0>>(arg1);
        0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::record_service_investment(&arg1.service_cap, arg0, v0, 0x1::type_name::with_defining_ids<T0>());
        0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::add_active_service(&arg1.service_cap, arg0, v1, arg6);
        if (!0x2::object_table::contains<0x2::object::ID, UserAllocationDataInner<T0>>(&arg1.user_data.position_cap_data, v0)) {
            let v4 = UserAllocationDataInner<T0>{
                id                             : 0x2::object::new(arg7),
                strategy_allocations           : 0x2::vec_map::empty<0x2::object::ID, u64>(),
                last_accrued_rewards_per_share : 0x2::vec_map::empty<0x1::type_name::TypeName, u128>(),
                pending_rewards                : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                total_shares                   : 0,
            };
            0x2::object_table::add<0x2::object::ID, UserAllocationDataInner<T0>>(&mut arg1.user_data.position_cap_data, v0, v4);
        };
        if (!0x2::object_table::contains<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg1.strategy_data.strategies, v1)) {
            let v5 = StrategyAllocationDataInner<T0>{
                id                          : 0x2::object::new(arg7),
                strategy_id                 : v1,
                last_accrued_fees_per_share : 0x2::vec_map::empty<0x1::type_name::TypeName, u128>(),
                pending_fees                : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
                total_shares                : 0,
            };
            0x2::object_table::add<0x2::object::ID, StrategyAllocationDataInner<T0>>(&mut arg1.strategy_data.strategies, v1, v5);
        };
        update_user_global_rewards<T0>(arg1, v0);
        update_strategy_fees<T0>(arg1, v1);
        let v6 = get_exchange_rate<T0>(arg1);
        let v7 = (((v2 as u128) * 1000000000000 / v6) as u64);
        assert!(v7 > 0, 4006);
        let v8 = 0x2::object_table::borrow_mut<0x2::object::ID, UserAllocationDataInner<T0>>(&mut arg1.user_data.position_cap_data, v0);
        if (!0x2::vec_map::contains<0x2::object::ID, u64>(&v8.strategy_allocations, &v1)) {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut v8.strategy_allocations, v1, 0);
        };
        let v9 = 0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut v8.strategy_allocations, &v1);
        *v9 = *v9 + v7;
        v8.total_shares = v8.total_shares + v7;
        let v10 = 0x2::object_table::borrow_mut<0x2::object::ID, StrategyAllocationDataInner<T0>>(&mut arg1.strategy_data.strategies, v1);
        v10.total_shares = v10.total_shares + v7;
        arg1.total_shares = arg1.total_shares + v7;
        0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::update_subscriber_investment(&arg1.service_cap, arg0, v0, v1, (((*v9 as u128) * v6 / 1000000000000) as u64));
        let v11 = 0x2::coin::from_balance<T0>(0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::take_from_potato<T0>(arg5, &arg1.service_cap, 0x1::option::some<u64>(v2)), arg7);
        supply<T0>(arg1, arg2, v11, arg6, arg7);
        let v12 = RebalanceDeposit{
            service_id             : v3,
            position_cap_id        : v0,
            user_allocation_id     : 0x2::object::id<UserAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, UserAllocationDataInner<T0>>(&arg1.user_data.position_cap_data, v0)),
            strategy_id            : v1,
            strategy_allocation_id : 0x2::object::id<StrategyAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg1.strategy_data.strategies, v1)),
            amount                 : v2,
            shares_minted          : v7,
            total_supplied         : arg1.total_supplied,
            total_shares           : arg1.total_shares,
            timestamp_ms           : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<RebalanceDeposit>(v12);
    }

    fun deposited_ctokens<T0>(arg0: &Service<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>) : u64 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&arg0.protocol_position_cap)));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v0)) {
            let v2 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v0, v1);
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_reserve_array_index(v2) == arg0.reserve_array_index) {
                return 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_deposited_ctoken_amount(v2)
            };
            v1 = v1 + 1;
        };
        0
    }

    fun drawdown_bps<T0>(arg0: &Service<T0>, arg1: u128) : u64 {
        if (arg1 >= arg0.peak_rate) {
            return 0
        };
        ((((arg0.peak_rate - arg1) as u256) * (10000 as u256) / (arg0.peak_rate as u256)) as u64)
    }

    public fun emergency_withdraw<T0>(arg0: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::AdminCap, arg1: &mut Service<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        assert!(arg4 > 0, 4010);
        let v0 = arg1.in_emergency;
        update_protocol_yield<T0>(arg1, arg2, arg3, arg5, arg6);
        if (v0) {
            exit_pull<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
            emit_service_updated<T0>(arg1, arg5);
        } else if (!arg1.in_emergency) {
            try_enter_emergency<T0>(arg1, arg2, arg3, true, arg4, arg5, arg6);
            emit_service_updated<T0>(arg1, arg5);
        };
    }

    fun emit_service_updated<T0>(arg0: &Service<T0>, arg1: &0x2::clock::Clock) {
        let v0 = ServiceUpdated<T0>{
            service_id                 : 0x2::object::id<Service<T0>>(arg0),
            total_supplied             : arg0.total_supplied,
            total_shares               : arg0.total_shares,
            accrued_rewards_per_share  : arg0.user_data.accrued_rewards_per_share,
            external_rewards_per_share : arg0.external_rewards_per_share,
            reserve                    : 0x2::balance::value<T0>(&arg0.reserve),
            unpaid_fee                 : arg0.unpaid_fee,
            peak_rate                  : arg0.peak_rate,
            in_emergency               : arg0.in_emergency,
            is_paused                  : arg0.is_paused,
            timestamp_ms               : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ServiceUpdated<T0>>(v0);
    }

    fun exit_pull<T0>(arg0: &mut Service<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = deposited_ctokens<T0>(arg0, arg1);
        if (v0 == 0) {
            return 0
        };
        let v1 = if (arg3 == 18446744073709551615) {
            arg3
        } else {
            0x1::u64::min(0x1::u64::min(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::saturating_floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg3), ctoken_ratio<T0>(arg0, arg1, arg4))), v0), safe_free_cash(free_cash<T0>(arg0, arg1, arg4)))
        };
        if (v1 == 0) {
            return 0
        };
        let v2 = arg0.reserve_array_index;
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, v2, &arg0.protocol_position_cap, arg4, v1, arg5);
        let v4 = 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(&v3);
        if (v4 == 0) {
            0x2::coin::destroy_zero<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(v3);
            return 0
        };
        let v5 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1), v2);
        let v6 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_supply<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v5) - v4;
        let v7 = if (v6 >= 100) {
            0
        } else {
            0x1::u64::min(100 - v6, v4)
        };
        let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v4 - v7), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v5)));
        let v9 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::available_amount<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v5);
        let v10 = if (v8 > 0) {
            if (v9 >= 100) {
                v9 - 100 >= v8
            } else {
                false
            }
        } else {
            false
        };
        if (!v10) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, v2, &arg0.protocol_position_cap, arg4, v3, arg5);
            return 0
        };
        if (v7 > 0) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, v2, &arg0.protocol_position_cap, arg4, 0x2::coin::split<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(&mut v3, v7, arg5), arg5);
        };
        let v11 = redeem_ctokens<T0>(arg0, arg1, v3, arg2, arg4, arg5);
        let v12 = 0x2::balance::value<T0>(&v11);
        0x2::balance::join<T0>(&mut arg0.reserve, v11);
        reconcile_total_supplied<T0>(arg0, arg1, arg4);
        let v13 = ReserveFilled{
            service_id   : 0x2::object::id<Service<T0>>(arg0),
            amount       : v12,
            reserve      : 0x2::balance::value<T0>(&arg0.reserve),
            held         : protocol_supplied<T0>(arg0, arg1, arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ReserveFilled>(v13);
        v12
    }

    fun fee_from_bps(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    fun free_cash<T0>(arg0: &Service<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::available_amount<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1), arg0.reserve_array_index));
        if (v0 <= 100) {
            return 0
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v0 - 100), ctoken_ratio<T0>(arg0, arg1, arg2)))
    }

    public fun get_actual_supplied<T0>(arg0: &Service<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock) : u64 {
        actual_supplied<T0>(arg0, arg1, arg2)
    }

    fun get_exchange_rate<T0>(arg0: &Service<T0>) : u128 {
        if (arg0.total_shares == 0) {
            return 1000000000000
        };
        (arg0.total_supplied as u128) * 1000000000000 / (arg0.total_shares as u128)
    }

    public fun get_external_rewards_per_share<T0, T1>(arg0: &Service<T0>) : u128 {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg0.external_rewards_per_share, &v0)) {
            return 0
        };
        *0x2::vec_map::get<0x1::type_name::TypeName, u128>(&arg0.external_rewards_per_share, &v0)
    }

    fun index_delta(arg0: u64, arg1: u64) : u128 {
        if (arg1 == 0) {
            return 0
        };
        (arg0 as u128) * 1000000000000 / (arg1 as u128)
    }

    fun is_sui<T0>() : bool {
        0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()
    }

    public fun pause_service<T0>(arg0: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::AdminCap, arg1: &mut Service<T0>, arg2: &0x2::clock::Clock) {
        assert_version<T0>(arg1);
        arg1.is_paused = true;
        let v0 = ServicePaused{
            service_id   : 0x2::object::id<Service<T0>>(arg1),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ServicePaused>(v0);
    }

    fun protocol_supplied<T0>(arg0: &Service<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(deposited_ctokens<T0>(arg0, arg1)), ctoken_ratio<T0>(arg0, arg1, arg2)))
    }

    fun recast_balance<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<T1>(), 4011);
        let v0 = 0x2::bag::new(arg1);
        0x2::bag::add<u8, 0x2::balance::Balance<T0>>(&mut v0, 0, arg0);
        0x2::bag::destroy_empty(v0);
        0x2::bag::remove<u8, 0x2::balance::Balance<T1>>(&mut v0, 0)
    }

    fun reconcile_total_supplied<T0>(arg0: &mut Service<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock) {
        let v0 = actual_supplied<T0>(arg0, arg1, arg2);
        arg0.total_supplied = v0 - 0x1::u64::min(v0, arg0.unpaid_fee);
    }

    fun redeem<T0>(arg0: &Service<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: u64, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, arg0.reserve_array_index, &arg0.protocol_position_cap, arg4, arg2, arg5);
        redeem_ctokens<T0>(arg0, arg1, v0, arg3, arg4, arg5)
    }

    fun redeem_ctokens<T0>(arg0: &Service<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = arg0.reserve_array_index;
        if (is_sui<T0>()) {
            let v2 = recast_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(0x2::coin::into_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(arg2), arg5);
            let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg1, v0, arg4, 0x2::coin::from_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(v2, arg5), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>>(), arg5);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1, v0, &v3, arg3, arg5);
            let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, 0x2::sui::SUI>(arg1, v0, v3, arg5));
            recast_balance<0x2::sui::SUI, T0>(v4, arg5)
        } else {
            0x2::coin::into_balance<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, v0, arg4, arg2, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(), arg5))
        }
    }

    public fun refresh_for_bot_rebalance<T0>(arg0: &mut 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::Config, arg1: &mut Service<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::RebalancePotato, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        let v0 = 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::position_cap_id(arg4);
        let v1 = 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::strategy_id(arg4);
        assert_all_rewards_collected<T0>(arg1, arg2, !arg1.in_emergency, arg5);
        update_protocol_yield<T0>(arg1, arg2, arg3, arg5, arg6);
        assert!(0x2::object_table::contains<0x2::object::ID, UserAllocationDataInner<T0>>(&arg1.user_data.position_cap_data, v0), 4000);
        update_user_global_rewards<T0>(arg1, v0);
        update_strategy_fees<T0>(arg1, v1);
        let v2 = 0x2::object_table::borrow<0x2::object::ID, UserAllocationDataInner<T0>>(&arg1.user_data.position_cap_data, v0);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&v2.strategy_allocations, &v1), 4000);
        let v3 = (((*0x2::vec_map::get<0x2::object::ID, u64>(&v2.strategy_allocations, &v1) as u128) * get_exchange_rate<T0>(arg1) / 1000000000000) as u64);
        0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::update_subscriber_investment(&arg1.service_cap, arg0, v0, v1, v3);
        let v4 = RebalanceRefreshed{
            service_id             : 0x2::object::id<Service<T0>>(arg1),
            position_cap_id        : v0,
            user_allocation_id     : 0x2::object::id<UserAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, UserAllocationDataInner<T0>>(&arg1.user_data.position_cap_data, v0)),
            strategy_id            : v1,
            strategy_allocation_id : 0x2::object::id<StrategyAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg1.strategy_data.strategies, v1)),
            value                  : v3,
            total_supplied         : arg1.total_supplied,
            total_shares           : arg1.total_shares,
            timestamp_ms           : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<RebalanceRefreshed>(v4);
        0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::mark_refreshed(arg4, &arg1.service_cap);
    }

    public fun resume_service<T0>(arg0: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::AdminCap, arg1: &mut Service<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        assert!(arg1.in_emergency, 4019);
        update_protocol_yield<T0>(arg1, arg2, arg3, arg4, arg5);
        let v0 = 0x2::balance::value<T0>(&arg1.reserve);
        let v1 = 0;
        if (v0 > 0) {
            let v2 = arg1.reserve_array_index;
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::compound_interest<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2, v2, arg4);
            let v3 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2), v2);
            let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_supply<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v3);
            let v5 = if (v4 == 0) {
                v0
            } else {
                0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v0), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v4)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::total_supply<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v3)))
            };
            if (v5 > 0) {
                let v6 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.reserve), arg5);
                supply<T0>(arg1, arg2, v6, arg4, arg5);
                v1 = v0;
            };
        };
        arg1.in_emergency = false;
        arg1.is_paused = false;
        let v7 = get_exchange_rate<T0>(arg1);
        arg1.peak_rate = v7;
        let v8 = ServiceResumed{
            service_id         : 0x2::object::id<Service<T0>>(arg1),
            amount_redeposited : v1,
            rate               : v7,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ServiceResumed>(v8);
        emit_service_updated<T0>(arg1, arg4);
    }

    fun reward_manager_index<T0>(arg0: &Service<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>) : 0x1::option::Option<u64> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::user_reward_managers<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(&arg0.protocol_position_cap)));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserRewardManager>(v0)) {
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::pool_reward_manager_id(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserRewardManager>(v0, v1)) == 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolRewardManager>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::deposits_pool_reward_manager<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1), arg0.reserve_array_index)))) {
                return 0x1::option::some<u64>(v1)
            };
            v1 = v1 + 1;
        };
        0x1::option::none<u64>()
    }

    fun safe_free_cash(arg0: u64) : u64 {
        let v0 = fee_from_bps(arg0, 10) + 1;
        if (arg0 > v0) {
            arg0 - v0
        } else {
            0
        }
    }

    public fun set_deposit_cap<T0>(arg0: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::AdminCap, arg1: &mut Service<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version<T0>(arg1);
        arg1.deposit_cap = arg2;
        let v0 = DepositCapUpdated{
            service_id   : 0x2::object::id<Service<T0>>(arg1),
            old_cap      : arg1.deposit_cap,
            new_cap      : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DepositCapUpdated>(v0);
    }

    public fun set_fee_bps<T0>(arg0: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::AdminCap, arg1: &mut Service<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
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

    public fun set_loss_settings<T0>(arg0: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::AdminCap, arg1: &mut Service<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert_version<T0>(arg1);
        assert!(arg2 > 0 && arg2 < arg3, 4018);
        assert!(arg2 <= 200 && arg3 <= 1000, 4018);
        arg1.loss_pause_bps = arg2;
        arg1.loss_exit_bps = arg3;
        arg1.loss_min_balance = arg4;
        let v0 = LossSettingsUpdated{
            service_id      : 0x2::object::id<Service<T0>>(arg1),
            old_pause_bps   : arg1.loss_pause_bps,
            new_pause_bps   : arg2,
            old_exit_bps    : arg1.loss_exit_bps,
            new_exit_bps    : arg3,
            old_min_balance : arg1.loss_min_balance,
            new_min_balance : arg4,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<LossSettingsUpdated>(v0);
    }

    public fun set_min_reward_duration<T0>(arg0: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::AdminCap, arg1: &mut Service<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
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

    fun supply<T0>(arg0: &mut Service<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.reserve_array_index;
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, v0, &arg0.protocol_position_cap, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, v0, arg3, arg2, arg4), arg4);
        reconcile_total_supplied<T0>(arg0, arg1, arg3);
    }

    fun try_enter_emergency<T0>(arg0: &mut Service<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = get_exchange_rate<T0>(arg0);
        let v1 = drawdown_bps<T0>(arg0, v0);
        let v2 = 0x2::object::id<Service<T0>>(arg0);
        let v3 = exit_pull<T0>(arg0, arg1, arg2, arg4, arg5, arg6);
        if (v3 > 0) {
            arg0.in_emergency = true;
            let v4 = EmergencyEntered{
                service_id   : v2,
                by_admin     : arg3,
                rate         : v0,
                peak_rate    : arg0.peak_rate,
                drawdown_bps : v1,
                timestamp_ms : 0x2::clock::timestamp_ms(arg5),
            };
            0x2::event::emit<EmergencyEntered>(v4);
        } else {
            arg0.is_paused = true;
            let v5 = EmergencyPullFailed{
                service_id   : v2,
                by_admin     : arg3,
                rate         : v0,
                peak_rate    : arg0.peak_rate,
                drawdown_bps : v1,
                timestamp_ms : 0x2::clock::timestamp_ms(arg5),
            };
            0x2::event::emit<EmergencyPullFailed>(v5);
        };
    }

    fun unlist_strategy_if_settled<T0>(arg0: &Service<T0>, arg1: &mut 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::Config, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::object_table::borrow<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg0.strategy_data.strategies, arg2);
        if (v0.total_shares > 0) {
            return
        };
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<0x1::type_name::TypeName, u64>(&v0.pending_fees)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&v0.pending_fees, v1);
            if (*v3 > 0) {
                return
            };
            v1 = v1 + 1;
        };
        0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::remove_active_service(&arg0.service_cap, arg1, arg2, arg3);
    }

    public fun unpause_service<T0>(arg0: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::AdminCap, arg1: &mut Service<T0>, arg2: &0x2::clock::Clock) {
        assert_version<T0>(arg1);
        assert!(!arg1.in_emergency, 4015);
        arg1.is_paused = false;
        arg1.peak_rate = get_exchange_rate<T0>(arg1);
        let v0 = ServiceUnpaused{
            service_id   : 0x2::object::id<Service<T0>>(arg1),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ServiceUnpaused>(v0);
        emit_service_updated<T0>(arg1, arg2);
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

    fun update_all_rewards<T0, T1>(arg0: &mut Service<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        update_protocol_yield<T0>(arg0, arg1, arg2, arg3, arg4);
        update_admin_rewards<T0, T1>(arg0, arg3);
        update_external_incentives<T0, T1>(arg0, arg1, arg3, arg4);
    }

    public fun update_external_incentives<T0, T1>(arg0: &mut Service<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x2::balance::zero<T1>();
        let v2 = claimable_reward_slots<T0, T1>(arg0, arg1, arg2);
        0x1::vector::reverse<u64>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v2)) {
            0x2::balance::join<T1>(&mut v1, 0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg1, &arg0.protocol_position_cap, arg2, arg0.reserve_array_index, 0x1::vector::pop_back<u64>(&mut v2), true, arg3)));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u64>(v2);
        let v4 = 0x2::balance::value<T1>(&v1);
        if (v4 > 0) {
            let v5 = fee_from_bps(v4, arg0.platform_fee_bps);
            let v6 = v4 - v5;
            if (v5 > 0) {
                let v7 = fee_from_bps(v5, arg0.strategy_fee_bps);
                if (arg0.total_shares > 0 && v7 > 0) {
                    if (!0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg0.strategy_data.accrued_fees_per_share, &v0)) {
                        0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut arg0.strategy_data.accrued_fees_per_share, v0, 0);
                    };
                    let v8 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u128>(&mut arg0.strategy_data.accrued_fees_per_share, &v0);
                    *v8 = *v8 + index_delta(v7, arg0.total_shares);
                };
                if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_collected, v0)) {
                    0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.fee_collected, v0, 0x2::balance::zero<T1>());
                };
                0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.fee_collected, v0), 0x2::balance::split<T1>(&mut v1, v5 - v7));
            };
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0)) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0, 0x2::balance::zero<T1>());
            };
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0), v1);
            if (arg0.total_shares > 0) {
                if (!0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg0.user_data.accrued_rewards_per_share, &v0)) {
                    0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut arg0.user_data.accrued_rewards_per_share, v0, 0);
                };
                let v9 = index_delta(v6, arg0.total_shares);
                let v10 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u128>(&mut arg0.user_data.accrued_rewards_per_share, &v0);
                *v10 = *v10 + v9;
                if (!0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg0.external_rewards_per_share, &v0)) {
                    0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut arg0.external_rewards_per_share, v0, 0);
                };
                let v11 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u128>(&mut arg0.external_rewards_per_share, &v0);
                *v11 = *v11 + v9;
            };
            let v12 = ExternalIncentivesClaimed{
                service_id   : 0x2::object::id<Service<T0>>(arg0),
                reward_type  : v0,
                gross        : v4,
                fee          : v5,
                net          : v6,
                timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<ExternalIncentivesClaimed>(v12);
        } else {
            0x2::balance::destroy_zero<T1>(v1);
        };
        emit_service_updated<T0>(arg0, arg2);
    }

    fun update_protocol_yield<T0>(arg0: &mut Service<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = actual_supplied<T0>(arg0, arg1, arg3);
        let v2 = arg0.total_supplied + arg0.unpaid_fee;
        let v3 = if (v1 > v2) {
            v1 - v2
        } else {
            0
        };
        if (v1 < v2) {
            let v4 = v2 - v1;
            let v5 = 0x1::u64::min(v4, arg0.unpaid_fee);
            arg0.unpaid_fee = arg0.unpaid_fee - v5;
            let v6 = v4 - v5;
            if (v6 > 0) {
                let v7 = ProtocolLossRealized{
                    service_id   : 0x2::object::id<Service<T0>>(arg0),
                    coin_type    : v0,
                    loss         : v6,
                    timestamp_ms : 0x2::clock::timestamp_ms(arg3),
                };
                0x2::event::emit<ProtocolLossRealized>(v7);
            };
        };
        let v8 = fee_from_bps(v3, arg0.platform_fee_bps);
        let v9 = arg0.unpaid_fee + v8;
        let v10 = if (arg0.in_emergency || v9 == 0) {
            0
        } else {
            0x1::u64::min(ctokens_for_amount<T0>(arg0, arg1, v9, arg3), safe_free_cash(free_cash<T0>(arg0, arg1, arg3)))
        };
        let v11 = 0;
        if (v10 > 0) {
            let v12 = redeem<T0>(arg0, arg1, v10, arg2, arg3, arg4);
            let v13 = 0x2::balance::value<T0>(&v12);
            v11 = v13;
            let v14 = fee_from_bps(v13, arg0.strategy_fee_bps);
            if (arg0.total_shares > 0 && v14 > 0) {
                if (!0x2::vec_map::contains<0x1::type_name::TypeName, u128>(&arg0.strategy_data.accrued_fees_per_share, &v0)) {
                    0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut arg0.strategy_data.accrued_fees_per_share, v0, 0);
                };
                let v15 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u128>(&mut arg0.strategy_data.accrued_fees_per_share, &v0);
                *v15 = *v15 + index_delta(v14, arg0.total_shares);
            };
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_collected, v0)) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_collected, v0, 0x2::balance::zero<T0>());
            };
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_collected, v0), 0x2::balance::split<T0>(&mut v12, v13 - v14));
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0)) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards, v0, 0x2::balance::zero<T0>());
            };
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards, v0), v12);
        };
        arg0.unpaid_fee = v9 - 0x1::u64::min(v11, v9);
        reconcile_total_supplied<T0>(arg0, arg1, arg3);
        let v16 = get_exchange_rate<T0>(arg0);
        if (v2 < arg0.loss_min_balance || v16 > arg0.peak_rate) {
            arg0.peak_rate = v16;
        } else if (v16 < arg0.peak_rate && !arg0.in_emergency) {
            let v17 = drawdown_bps<T0>(arg0, v16);
            if (v17 >= arg0.loss_exit_bps) {
                try_enter_emergency<T0>(arg0, arg1, arg2, false, 18446744073709551615, arg3, arg4);
            } else if (v17 >= arg0.loss_pause_bps && !arg0.is_paused) {
                arg0.is_paused = true;
                let v18 = ServiceAutoPaused{
                    service_id    : 0x2::object::id<Service<T0>>(arg0),
                    rate          : v16,
                    peak_rate     : arg0.peak_rate,
                    drawdown_bps  : v17,
                    threshold_bps : arg0.loss_pause_bps,
                    timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
                };
                0x2::event::emit<ServiceAutoPaused>(v18);
            };
        };
        if (v3 > 0 || v11 > 0) {
            let v19 = ProtocolYieldAccrued{
                service_id   : 0x2::object::id<Service<T0>>(arg0),
                coin_type    : v0,
                gross        : v3,
                fee          : v11,
                net          : v3 - v8,
                fee_unpaid   : arg0.unpaid_fee,
                timestamp_ms : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<ProtocolYieldAccrued>(v19);
        };
        emit_service_updated<T0>(arg0, arg3);
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

    public fun update_version<T0>(arg0: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::AdminCap, arg1: &mut Service<T0>) {
        assert_version<T0>(arg1);
        arg1.version = 1;
    }

    public fun withdraw<T0>(arg0: &mut 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::Config, arg1: &mut Service<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::PositionCap, arg5: 0x2::object::ID, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg1);
        assert_all_rewards_collected<T0>(arg1, arg2, !arg1.in_emergency, arg7);
        update_protocol_yield<T0>(arg1, arg2, arg3, arg7, arg8);
        let v0 = 0x2::object::id<0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::PositionCap>(arg4);
        let v1 = 0x2::object::id<Service<T0>>(arg1);
        assert!(0x2::object_table::contains<0x2::object::ID, UserAllocationDataInner<T0>>(&arg1.user_data.position_cap_data, v0), 4000);
        update_user_global_rewards<T0>(arg1, v0);
        update_strategy_fees<T0>(arg1, arg5);
        let v2 = get_exchange_rate<T0>(arg1);
        let v3 = (((arg6 as u128) * v2 / 1000000000000) as u64);
        let v4 = if (arg1.in_emergency) {
            assert!(v3 > 0, 4010);
            assert!(v3 <= 0x2::balance::value<T0>(&arg1.reserve), 4016);
            0
        } else {
            let v5 = ctokens_for_amount<T0>(arg1, arg2, v3, arg7);
            assert!(v5 > 0, 4010);
            v5
        };
        let v6 = 0x2::object_table::borrow_mut<0x2::object::ID, UserAllocationDataInner<T0>>(&mut arg1.user_data.position_cap_data, v0);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&v6.strategy_allocations, &arg5), 4000);
        let v7 = 0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut v6.strategy_allocations, &arg5);
        assert!(*v7 >= arg6, 4000);
        *v7 = *v7 - arg6;
        v6.total_shares = v6.total_shares - arg6;
        let v8 = 0x2::object_table::borrow_mut<0x2::object::ID, StrategyAllocationDataInner<T0>>(&mut arg1.strategy_data.strategies, arg5);
        v8.total_shares = v8.total_shares - arg6;
        arg1.total_shares = arg1.total_shares - arg6;
        if (arg1.total_shares == 0) {
            arg1.peak_rate = 1000000000000;
        };
        0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::update_subscriber_investment(&arg1.service_cap, arg0, v0, arg5, (((*v7 as u128) * v2 / 1000000000000) as u64));
        unlist_strategy_if_settled<T0>(arg1, arg0, arg5, arg7);
        let v9 = if (arg1.in_emergency) {
            0x2::balance::split<T0>(&mut arg1.reserve, v3)
        } else {
            redeem<T0>(arg1, arg2, v4, arg3, arg7, arg8)
        };
        let v10 = 0x2::coin::from_balance<T0>(v9, arg8);
        reconcile_total_supplied<T0>(arg1, arg2, arg7);
        let v11 = Withdrawn{
            service_id             : v1,
            position_cap_id        : v0,
            user_allocation_id     : 0x2::object::id<UserAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, UserAllocationDataInner<T0>>(&arg1.user_data.position_cap_data, v0)),
            strategy_id            : arg5,
            strategy_allocation_id : 0x2::object::id<StrategyAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg1.strategy_data.strategies, arg5)),
            shares_burned          : arg6,
            amount                 : 0x2::coin::value<T0>(&v10),
            total_supplied         : arg1.total_supplied,
            total_shares           : arg1.total_shares,
            timestamp_ms           : 0x2::clock::timestamp_ms(arg7),
            withdrawer             : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<Withdrawn>(v11);
        emit_service_updated<T0>(arg1, arg7);
        v10
    }

    public fun withdraw_for_bot_rebalance<T0>(arg0: &mut 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::Config, arg1: &mut Service<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: &mut 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::RebalancePotato, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        let v0 = 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::position_cap_id(arg5);
        let v1 = 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::strategy_id(arg5);
        assert_all_rewards_collected<T0>(arg1, arg2, !arg1.in_emergency, arg6);
        update_protocol_yield<T0>(arg1, arg2, arg3, arg6, arg7);
        let v2 = 0x2::object::id<Service<T0>>(arg1);
        assert!(0x2::object_table::contains<0x2::object::ID, UserAllocationDataInner<T0>>(&arg1.user_data.position_cap_data, v0), 4000);
        update_user_global_rewards<T0>(arg1, v0);
        update_strategy_fees<T0>(arg1, v1);
        let v3 = get_exchange_rate<T0>(arg1);
        let v4 = (((arg4 as u128) * v3 / 1000000000000) as u64);
        let v5 = if (arg1.in_emergency) {
            assert!(v4 > 0, 4010);
            assert!(v4 <= 0x2::balance::value<T0>(&arg1.reserve), 4016);
            0
        } else {
            let v6 = ctokens_for_amount<T0>(arg1, arg2, v4, arg6);
            assert!(v6 > 0, 4010);
            v6
        };
        let v7 = 0x2::object_table::borrow_mut<0x2::object::ID, UserAllocationDataInner<T0>>(&mut arg1.user_data.position_cap_data, v0);
        assert!(0x2::vec_map::contains<0x2::object::ID, u64>(&v7.strategy_allocations, &v1), 4000);
        let v8 = 0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut v7.strategy_allocations, &v1);
        assert!(*v8 >= arg4, 4000);
        *v8 = *v8 - arg4;
        v7.total_shares = v7.total_shares - arg4;
        let v9 = 0x2::object_table::borrow_mut<0x2::object::ID, StrategyAllocationDataInner<T0>>(&mut arg1.strategy_data.strategies, v1);
        v9.total_shares = v9.total_shares - arg4;
        arg1.total_shares = arg1.total_shares - arg4;
        if (arg1.total_shares == 0) {
            arg1.peak_rate = 1000000000000;
        };
        0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::update_subscriber_investment(&arg1.service_cap, arg0, v0, v1, (((*v8 as u128) * v3 / 1000000000000) as u64));
        unlist_strategy_if_settled<T0>(arg1, arg0, v1, arg6);
        let v10 = if (arg1.in_emergency) {
            0x2::balance::split<T0>(&mut arg1.reserve, v4)
        } else {
            redeem<T0>(arg1, arg2, v5, arg3, arg6, arg7)
        };
        let v11 = v10;
        reconcile_total_supplied<T0>(arg1, arg2, arg6);
        let v12 = RebalanceWithdrawal{
            service_id             : v2,
            position_cap_id        : v0,
            user_allocation_id     : 0x2::object::id<UserAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, UserAllocationDataInner<T0>>(&arg1.user_data.position_cap_data, v0)),
            strategy_id            : v1,
            strategy_allocation_id : 0x2::object::id<StrategyAllocationDataInner<T0>>(0x2::object_table::borrow<0x2::object::ID, StrategyAllocationDataInner<T0>>(&arg1.strategy_data.strategies, v1)),
            shares_burned          : arg4,
            amount                 : 0x2::balance::value<T0>(&v11),
            total_supplied         : arg1.total_supplied,
            total_shares           : arg1.total_shares,
            timestamp_ms           : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<RebalanceWithdrawal>(v12);
        emit_service_updated<T0>(arg1, arg6);
        0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::add_to_potato<T0>(arg5, &arg1.service_cap, v11);
    }

    // decompiled from Move bytecode v7
}

