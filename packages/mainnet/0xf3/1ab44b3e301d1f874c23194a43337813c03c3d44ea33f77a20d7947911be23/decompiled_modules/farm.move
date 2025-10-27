module 0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::farm {
    struct FARM has drop {
        dummy_field: bool,
    }

    struct RewardVault has key {
        id: 0x2::object::UID,
        victory_balance: 0x2::balance::Balance<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::victory_token::VICTORY_TOKEN>,
    }

    struct Farm has key {
        id: 0x2::object::UID,
        admin: address,
        pools: 0x2::table::Table<0x1::type_name::TypeName, Pool>,
        pool_list: vector<0x1::type_name::TypeName>,
        burn_address: address,
        locker_address: address,
        team_1_address: address,
        team_2_address: address,
        dev_address: address,
        total_victory_distributed: u256,
        last_update_timestamp: u64,
        paused: bool,
        allowed_lp_types: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        total_allocation_points: u256,
        total_lp_allocation_points: u256,
        total_single_allocation_points: u256,
        position_to_vault: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        user_positions: 0x2::table::Table<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>,
        total_lp_victory_distributed: u256,
        total_single_victory_distributed: u256,
        emission_start_timestamp: u64,
        emission_end_timestamp: u64,
    }

    struct Pool has store {
        pool_type: 0x1::type_name::TypeName,
        total_staked: u256,
        allocation_points: u256,
        acc_reward_per_share: u256,
        last_reward_time: u64,
        deposit_fee: u256,
        withdrawal_fee: u256,
        active: bool,
        stakers: 0x2::table::Table<address, Staker>,
        is_native_pair: bool,
        is_lp_token: bool,
        accumulated_deposit_fees: u256,
        accumulated_withdrawal_fees: u256,
    }

    struct Staker has drop, store {
        amount: u256,
        reward_debt: u256,
        rewards_claimed: u256,
        last_stake_timestamp: u64,
        last_claim_timestamp: u64,
    }

    struct StakedTokenVault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        owner: address,
        pool_type: 0x1::type_name::TypeName,
        amount: u256,
        initial_stake_timestamp: u64,
    }

    struct StakingPosition<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        pool_type: 0x1::type_name::TypeName,
        amount: u256,
        initial_stake_timestamp: u64,
        vault_id: 0x2::object::ID,
    }

    struct PositionSummary has copy, drop {
        id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        amount: u256,
    }

    struct PoolCreated has copy, drop {
        pool_type: 0x1::type_name::TypeName,
        allocation_points: u256,
        deposit_fee: u256,
        withdrawal_fee: u256,
        is_native_pair: bool,
        is_lp_token: bool,
    }

    struct LPTypeAllowed has copy, drop {
        lp_type: 0x1::type_name::TypeName,
    }

    struct Staked has copy, drop {
        staker: address,
        pool_type: 0x1::type_name::TypeName,
        amount: u256,
        timestamp: u64,
    }

    struct Unstaked has copy, drop {
        staker: address,
        pool_type: 0x1::type_name::TypeName,
        amount: u256,
        timestamp: u64,
    }

    struct RewardClaimed has copy, drop {
        staker: address,
        pool_type: 0x1::type_name::TypeName,
        amount: u256,
        timestamp: u64,
    }

    struct FeesCollected has copy, drop {
        pool_type: 0x1::type_name::TypeName,
        amount: u256,
        fee_type: 0x1::string::String,
        timestamp: u64,
    }

    struct VaultDeposit has copy, drop {
        amount: u256,
        total_balance: u256,
        timestamp: u64,
    }

    struct AdminVaultSweep has copy, drop {
        amount: u256,
        recipient: address,
        remaining_vault_balance: u256,
        timestamp: u64,
    }

    struct EmissionWarning has copy, drop {
        message: 0x1::string::String,
        pool_type: 0x1::option::Option<0x1::type_name::TypeName>,
        timestamp: u64,
    }

    struct FarmVictoryDistributionTracking has copy, drop {
        lp_victory_distributed: u256,
        single_victory_distributed: u256,
        total_victory_distributed: u256,
        timestamp: u64,
    }

    struct PoolConfigUpdated has copy, drop {
        pool_type: 0x1::type_name::TypeName,
        old_allocation_points: u256,
        new_allocation_points: u256,
        old_deposit_fee: u256,
        new_deposit_fee: u256,
        old_withdrawal_fee: u256,
        new_withdrawal_fee: u256,
        old_active: bool,
        new_active: bool,
        timestamp: u64,
    }

    struct AdminAddressesUpdated has copy, drop {
        old_burn_address: address,
        new_burn_address: address,
        old_locker_address: address,
        new_locker_address: address,
        old_team_1_address: address,
        new_team_1_address: address,
        old_team_2_address: address,
        new_team_2_address: address,
        old_dev_address: address,
        new_dev_address: address,
        timestamp: u64,
    }

    struct FarmPauseStateChanged has copy, drop {
        old_paused: bool,
        new_paused: bool,
        admin: address,
        timestamp: u64,
    }

    struct EmissionsPausedSafely has copy, drop {
        pools_updated_count: u64,
        admin: address,
        timestamp: u64,
    }

    struct RewardVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        admin: address,
        timestamp: u64,
    }

    struct PoolBatchUpdateCompleted has copy, drop {
        batch_start_index: u64,
        batch_end_index: u64,
        pools_updated_in_batch: u64,
        total_pools_in_farm: u64,
        has_more_batches: bool,
        next_batch_start_index: u64,
        timestamp: u64,
    }

    struct PoolUpdated has copy, drop {
        pool_type: 0x1::type_name::TypeName,
        timestamp: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct UserTokenStake has copy, drop {
        token_type: 0x1::type_name::TypeName,
        total_amount: u256,
        position_count: u64,
        pending_rewards: u256,
    }

    public entry fun add_to_position_lp<T0, T1>(arg0: &mut Farm, arg1: &mut RewardVault, arg2: &mut StakingPosition<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>, arg3: &mut StakedTokenVault<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>, arg4: vector<0x2::coin::Coin<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>>, arg5: u256, arg6: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        assert!(arg5 >= 1000000, 6);
        let v0 = 0x1::type_name::get<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0), 5);
        let v1 = 0x2::tx_context::sender(arg8);
        assert!(arg2.owner == v1, 10);
        assert!(arg2.vault_id == 0x2::object::uid_to_inner(&arg3.id), 14);
        assert!(arg3.owner == v1, 10);
        validate_new_stake_allowed(arg6, arg7);
        let v2 = 0x2::clock::timestamp_ms(arg7) / 1000;
        arg0.last_update_timestamp = v2;
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0);
        assert!(v3.active, 7);
        update_pool_accumulator_masterchef(v3, arg0.total_lp_allocation_points, arg0.total_single_allocation_points, arg6, arg7, v2);
        assert!(0x2::table::contains<address, Staker>(&v3.stakers, v1), 10);
        let v4 = 0x2::table::borrow<address, Staker>(&v3.stakers, v1);
        let v5 = if (v4.amount > 0) {
            calculate_pending_rewards_masterchef(v4.amount, v4.reward_debt, v3.acc_reward_per_share)
        } else {
            0
        };
        let v6 = arg5 * v3.deposit_fee / 10000;
        let v7 = arg5 - v6;
        let v8 = 0x1::vector::pop_back<0x2::coin::Coin<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>>(&mut arg4);
        while (!0x1::vector::is_empty<0x2::coin::Coin<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>>(&arg4)) {
            0x2::coin::join<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(&mut v8, 0x1::vector::pop_back<0x2::coin::Coin<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>>(&mut arg4));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>>(arg4);
        assert!((0x2::coin::value<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(&v8) as u256) >= arg5, 8);
        if (v6 > 0) {
            let v9 = 0x2::coin::split<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(&mut v8, (v6 as u64), arg8);
            let v10 = &mut v9;
            distribute_farm_fees<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(arg0.burn_address, arg0.locker_address, arg0.team_1_address, arg0.team_2_address, arg0.dev_address, v10, v6, v0, v2, arg8);
            0x2::coin::destroy_zero<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(v9);
            v3.accumulated_deposit_fees = v3.accumulated_deposit_fees + v6;
            let v11 = FeesCollected{
                pool_type : v3.pool_type,
                amount    : v6,
                fee_type  : 0x1::string::utf8(b"deposit"),
                timestamp : v2,
            };
            0x2::event::emit<FeesCollected>(v11);
        };
        0x2::balance::join<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(&mut arg3.balance, 0x2::coin::into_balance<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(0x2::coin::split<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(&mut v8, (v7 as u64), arg8)));
        if (0x2::coin::value<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>>(v8, v1);
        } else {
            0x2::coin::destroy_zero<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(v8);
        };
        arg2.amount = arg2.amount + v7;
        arg3.amount = arg3.amount + v7;
        let v12 = 0x2::table::borrow_mut<address, Staker>(&mut v3.stakers, v1);
        v12.amount = v12.amount + v7;
        v12.last_stake_timestamp = v2;
        v3.total_staked = v3.total_staked + v7;
        if (v5 > 0) {
            v12.reward_debt = safe_mul_div_u256(v12.amount, v3.acc_reward_per_share, 1000000000000000000);
            arg0.total_victory_distributed = arg0.total_victory_distributed + v5;
            distribute_from_vault(arg1, arg0, v5, v1, true, arg6, arg7, arg8);
            let v13 = 0x2::table::borrow_mut<address, Staker>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0).stakers, v1);
            v13.rewards_claimed = v13.rewards_claimed + v5;
            v13.last_claim_timestamp = v2;
            let v14 = RewardClaimed{
                staker    : v1,
                pool_type : v0,
                amount    : v5,
                timestamp : v2,
            };
            0x2::event::emit<RewardClaimed>(v14);
        } else {
            v12.reward_debt = safe_mul_div_u256(v12.amount, v3.acc_reward_per_share, 1000000000000000000);
        };
        let v15 = Staked{
            staker    : v1,
            pool_type : v0,
            amount    : v7,
            timestamp : v2,
        };
        0x2::event::emit<Staked>(v15);
    }

    public entry fun add_to_position_single<T0>(arg0: &mut Farm, arg1: &mut RewardVault, arg2: &mut StakingPosition<T0>, arg3: &mut StakedTokenVault<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        let v0 = (0x2::coin::value<T0>(&arg4) as u256);
        assert!(v0 >= 1000000, 6);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v1), 5);
        let v2 = 0x2::tx_context::sender(arg7);
        assert!(arg2.owner == v2, 10);
        assert!(arg2.vault_id == 0x2::object::uid_to_inner(&arg3.id), 14);
        assert!(arg3.owner == v2, 10);
        validate_new_stake_allowed(arg5, arg6);
        let (_, v4) = get_allocations_safe(arg5, arg6);
        assert!(v4 > 0, 19);
        let v5 = 0x2::clock::timestamp_ms(arg6) / 1000;
        arg0.last_update_timestamp = v5;
        let v6 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v1);
        assert!(v6.active, 7);
        let (_, v8) = get_allocations_safe(arg5, arg6);
        if (v8 == 0) {
            let (v9, _, _) = validate_emission_state(arg5, arg6);
            if (v9) {
                let v12 = EmissionWarning{
                    message   : 0x1::string::utf8(b"Single asset rewards ended - consider LP staking"),
                    pool_type : 0x1::option::some<0x1::type_name::TypeName>(v1),
                    timestamp : v5,
                };
                0x2::event::emit<EmissionWarning>(v12);
            };
        };
        update_pool_accumulator_masterchef(v6, arg0.total_lp_allocation_points, arg0.total_single_allocation_points, arg5, arg6, v5);
        assert!(0x2::table::contains<address, Staker>(&v6.stakers, v2), 10);
        let v13 = 0x2::table::borrow<address, Staker>(&v6.stakers, v2);
        let v14 = if (v13.amount > 0) {
            let (v15, v16, v17) = validate_emission_state(arg5, arg6);
            let v18 = if (v15) {
                if (v16) {
                    !v17
                } else {
                    false
                }
            } else {
                false
            };
            if (v18) {
                calculate_pending_rewards_masterchef(v13.amount, v13.reward_debt, v6.acc_reward_per_share)
            } else {
                0
            }
        } else {
            0
        };
        let v19 = v0 * v6.deposit_fee / 10000;
        let v20 = v0 - v19;
        if (v19 > 0) {
            let v21 = 0x2::coin::split<T0>(&mut arg4, (v19 as u64), arg7);
            let v22 = &mut v21;
            distribute_farm_fees<T0>(arg0.burn_address, arg0.locker_address, arg0.team_1_address, arg0.team_2_address, arg0.dev_address, v22, v19, v1, v5, arg7);
            0x2::coin::destroy_zero<T0>(v21);
            v6.accumulated_deposit_fees = v6.accumulated_deposit_fees + v19;
            let v23 = FeesCollected{
                pool_type : v6.pool_type,
                amount    : v19,
                fee_type  : 0x1::string::utf8(b"deposit"),
                timestamp : v5,
            };
            0x2::event::emit<FeesCollected>(v23);
        };
        0x2::balance::join<T0>(&mut arg3.balance, 0x2::coin::into_balance<T0>(arg4));
        arg2.amount = arg2.amount + v20;
        arg3.amount = arg3.amount + v20;
        let v24 = 0x2::table::borrow_mut<address, Staker>(&mut v6.stakers, v2);
        v24.amount = v24.amount + v20;
        v24.last_stake_timestamp = v5;
        v6.total_staked = v6.total_staked + v20;
        if (v14 > 0) {
            v24.reward_debt = safe_mul_div_u256(v24.amount, v6.acc_reward_per_share, 1000000000000000000);
            arg0.total_victory_distributed = arg0.total_victory_distributed + v14;
            distribute_from_vault(arg1, arg0, v14, v2, false, arg5, arg6, arg7);
            let v25 = 0x2::table::borrow_mut<address, Staker>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v1).stakers, v2);
            v25.rewards_claimed = v25.rewards_claimed + v14;
            v25.last_claim_timestamp = v5;
            let v26 = RewardClaimed{
                staker    : v2,
                pool_type : v1,
                amount    : v14,
                timestamp : v5,
            };
            0x2::event::emit<RewardClaimed>(v26);
        } else {
            v24.reward_debt = safe_mul_div_u256(v24.amount, v6.acc_reward_per_share, 1000000000000000000);
        };
        let v27 = Staked{
            staker    : v2,
            pool_type : v1,
            amount    : v20,
            timestamp : v5,
        };
        0x2::event::emit<Staked>(v27);
    }

    public entry fun admin_sweep_vault_tokens(arg0: &mut RewardVault, arg1: u64, arg2: address, arg3: &AdminCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::victory_token::VICTORY_TOKEN>(&arg0.victory_balance) >= arg1, 15);
        assert!(arg1 > 0, 13);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::victory_token::VICTORY_TOKEN>>(0x2::coin::from_balance<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::victory_token::VICTORY_TOKEN>(0x2::balance::split<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::victory_token::VICTORY_TOKEN>(&mut arg0.victory_balance, arg1), arg5), arg2);
        let v0 = AdminVaultSweep{
            amount                  : (arg1 as u256),
            recipient               : arg2,
            remaining_vault_balance : (0x2::balance::value<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::victory_token::VICTORY_TOKEN>(&arg0.victory_balance) as u256),
            timestamp               : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<AdminVaultSweep>(v0);
    }

    public entry fun allow_lp_type<T0, T1>(arg0: &mut Farm, arg1: &AdminCap) {
        let v0 = 0x1::type_name::get<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>();
        if (!0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.allowed_lp_types, v0)) {
            0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.allowed_lp_types, v0, true);
            let v1 = LPTypeAllowed{lp_type: v0};
            0x2::event::emit<LPTypeAllowed>(v1);
        };
    }

    fun calculate_emission_week_from_timestamp_farm(arg0: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg1: u64) : u64 {
        0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::get_canonical_week_for_timestamp(arg0, arg1)
    }

    fun calculate_farm_rewards_multi_week(arg0: bool, arg1: u256, arg2: u256, arg3: u256, arg4: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg5: u64, arg6: u64) : u256 {
        if (arg5 >= arg6) {
            return 0
        };
        let (v0, v1) = 0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::get_config_info(arg4);
        if (v0 == 0 || v1) {
            return 0
        };
        let v2 = get_emission_end_timestamp(arg4);
        let v3 = if (arg6 > v2) {
            v2
        } else {
            arg6
        };
        if (arg5 >= v2) {
            return 0
        };
        let v4 = calculate_emission_week_from_timestamp_farm(arg4, arg5);
        let v5 = calculate_emission_week_from_timestamp_farm(arg4, v3);
        let v6 = get_emission_end_week();
        let v7 = if (v4 == 0) {
            true
        } else if (v5 == 0) {
            true
        } else if (v4 > v6) {
            true
        } else {
            v5 > v6
        };
        if (v7) {
            return 0
        };
        let v8 = 0;
        while (v4 <= v5 && v4 <= v6) {
            let v9 = v0 + (v4 - 1) * 604800;
            let v10 = v9 + 604800;
            let v11 = if (arg5 > v9) {
                arg5
            } else {
                v9
            };
            let v12 = if (v3 < v10) {
                v3
            } else {
                v10
            };
            if (v11 < v12) {
                v8 = v8 + calculate_week_farm_rewards(arg0, arg1, arg2, arg3, arg4, v4, v12 - v11);
            };
            v4 = v4 + 1;
        };
        v8
    }

    fun calculate_pending_rewards_masterchef(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = safe_mul_div_u256(arg0, arg2, 1000000000000000000);
        if (v0 <= arg1) {
            return 0
        };
        v0 - arg1
    }

    fun calculate_week_farm_rewards(arg0: bool, arg1: u256, arg2: u256, arg3: u256, arg4: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg5: u64, arg6: u64) : u256 {
        let (v0, v1, _, _, _) = 0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::preview_week_allocations(arg5);
        let (v5, v6) = if (arg0) {
            (v0, arg2)
        } else {
            (v1, arg3)
        };
        if (v5 == 0 || v6 == 0) {
            return 0
        };
        safe_mul_div_u256(v5, arg1, v6) * (arg6 as u256)
    }

    public fun can_claim_rewards(arg0: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) : (bool, 0x1::string::String) {
        let (v0, _, v2) = validate_emission_state(arg0, arg1);
        if (!v0) {
            return (false, 0x1::string::utf8(b"Emissions not initialized"))
        };
        if (v2) {
            return (false, 0x1::string::utf8(b"Emissions paused"))
        };
        (true, 0x1::string::utf8(b"Claims allowed"))
    }

    public fun can_stake_new_positions(arg0: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) : (bool, 0x1::string::String) {
        let (v0, v1, v2) = validate_emission_state(arg0, arg1);
        if (!v0) {
            return (false, 0x1::string::utf8(b"Emissions not initialized"))
        };
        if (!v1) {
            return (false, 0x1::string::utf8(b"Emissions ended"))
        };
        if (v2) {
            return (false, 0x1::string::utf8(b"Emissions paused"))
        };
        (true, 0x1::string::utf8(b"Staking allowed"))
    }

    public fun can_stake_single_assets(arg0: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) : bool {
        let (_, v1) = get_allocations_safe(arg0, arg1);
        v1 > 0
    }

    public fun can_unstake_now<T0>(arg0: &Farm, arg1: address, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0)) {
            return true
        };
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, Pool>(&arg0.pools, v0);
        if (!0x2::table::contains<address, Staker>(&v1.stakers, arg1)) {
            return true
        };
        0x2::clock::timestamp_ms(arg2) / 1000 >= 0x2::table::borrow<address, Staker>(&v1.stakers, arg1).last_stake_timestamp + 3600
    }

    public entry fun claim_rewards_lp<T0, T1>(arg0: &mut Farm, arg1: &mut RewardVault, arg2: &StakingPosition<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>, arg3: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        validate_claim_allowed(arg3, arg4);
        let v0 = 0x1::type_name::get<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0), 5);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(arg2.owner == v1, 10);
        let v2 = 0x2::clock::timestamp_ms(arg4) / 1000;
        arg0.last_update_timestamp = v2;
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.position_to_vault, 0x2::object::uid_to_inner(&arg2.id)), 5);
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0);
        assert!(v3.active, 7);
        let (_, _, _) = validate_emission_state(arg3, arg4);
        let v7 = get_emission_end_timestamp(arg3);
        let v8 = if (v2 > v7) {
            v7
        } else {
            v2
        };
        update_pool_accumulator_masterchef(v3, arg0.total_lp_allocation_points, arg0.total_single_allocation_points, arg3, arg4, v8);
        assert!(0x2::table::contains<address, Staker>(&v3.stakers, v1), 10);
        let v9 = 0x2::table::borrow<address, Staker>(&v3.stakers, v1);
        assert!(v2 >= v9.last_claim_timestamp + 10, 21);
        assert!(v9.amount > 0, 8);
        let v10 = calculate_pending_rewards_masterchef(v9.amount, v9.reward_debt, v3.acc_reward_per_share);
        assert!(v10 > 0, 9);
        let v11 = 0x2::table::borrow_mut<address, Staker>(&mut v3.stakers, v1);
        v11.reward_debt = safe_mul_div_u256(v11.amount, v3.acc_reward_per_share, 1000000000000000000);
        arg0.total_victory_distributed = arg0.total_victory_distributed + v10;
        distribute_from_vault(arg1, arg0, v10, v1, true, arg3, arg4, arg5);
        let v12 = 0x2::table::borrow_mut<address, Staker>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0).stakers, v1);
        v12.rewards_claimed = v12.rewards_claimed + v10;
        v12.last_claim_timestamp = v2;
        let v13 = RewardClaimed{
            staker    : v1,
            pool_type : v0,
            amount    : v10,
            timestamp : v2,
        };
        0x2::event::emit<RewardClaimed>(v13);
    }

    public entry fun claim_rewards_single<T0>(arg0: &mut Farm, arg1: &mut RewardVault, arg2: &StakingPosition<T0>, arg3: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        validate_claim_allowed(arg3, arg4);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0), 5);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(arg2.owner == v1, 10);
        let v2 = 0x2::clock::timestamp_ms(arg4) / 1000;
        arg0.last_update_timestamp = v2;
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.position_to_vault, 0x2::object::uid_to_inner(&arg2.id)), 5);
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0);
        assert!(v3.active, 7);
        let (_, _, _) = validate_emission_state(arg3, arg4);
        let v7 = get_emission_end_timestamp(arg3);
        let v8 = if (v2 > v7) {
            v7
        } else {
            v2
        };
        update_pool_accumulator_masterchef(v3, arg0.total_lp_allocation_points, arg0.total_single_allocation_points, arg3, arg4, v8);
        assert!(0x2::table::contains<address, Staker>(&v3.stakers, v1), 10);
        let v9 = 0x2::table::borrow<address, Staker>(&v3.stakers, v1);
        assert!(v2 >= v9.last_claim_timestamp + 10, 21);
        assert!(v9.amount > 0, 8);
        let v10 = calculate_pending_rewards_masterchef(v9.amount, v9.reward_debt, v3.acc_reward_per_share);
        assert!(v10 > 0, 9);
        let v11 = 0x2::table::borrow_mut<address, Staker>(&mut v3.stakers, v1);
        v11.reward_debt = safe_mul_div_u256(v11.amount, v3.acc_reward_per_share, 1000000000000000000);
        arg0.total_victory_distributed = arg0.total_victory_distributed + v10;
        distribute_from_vault(arg1, arg0, v10, v1, false, arg3, arg4, arg5);
        let v12 = 0x2::table::borrow_mut<address, Staker>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0).stakers, v1);
        v12.rewards_claimed = v12.rewards_claimed + v10;
        v12.last_claim_timestamp = v2;
        let v13 = RewardClaimed{
            staker    : v1,
            pool_type : v0,
            amount    : v10,
            timestamp : v2,
        };
        0x2::event::emit<RewardClaimed>(v13);
    }

    public entry fun create_lp_pool<T0, T1>(arg0: &mut Farm, arg1: u256, arg2: u256, arg3: u256, arg4: bool, arg5: &AdminCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::factory::sort_tokens<T0, T1>();
        if (0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::factory::is_token0<T0>(&v0)) {
            create_lp_pool_sorted<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        } else {
            create_lp_pool_sorted<T1, T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        };
    }

    fun create_lp_pool_sorted<T0, T1>(arg0: &mut Farm, arg1: u256, arg2: u256, arg3: u256, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0), 4);
        assert!(arg2 <= 1000, 3);
        assert!(arg3 <= 1000, 3);
        let v1 = Pool{
            pool_type                   : v0,
            total_staked                : 0,
            allocation_points           : arg1,
            acc_reward_per_share        : 0,
            last_reward_time            : 0x2::clock::timestamp_ms(arg5) / 1000,
            deposit_fee                 : arg2,
            withdrawal_fee              : arg3,
            active                      : true,
            stakers                     : 0x2::table::new<address, Staker>(arg6),
            is_native_pair              : arg4,
            is_lp_token                 : true,
            accumulated_deposit_fees    : 0,
            accumulated_withdrawal_fees : 0,
        };
        arg0.total_allocation_points = arg0.total_allocation_points + arg1;
        arg0.total_lp_allocation_points = arg0.total_lp_allocation_points + arg1;
        0x2::table::add<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0, v1);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.pool_list, v0);
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.allowed_lp_types, v0, true);
        let v2 = PoolCreated{
            pool_type         : v0,
            allocation_points : arg1,
            deposit_fee       : arg2,
            withdrawal_fee    : arg3,
            is_native_pair    : arg4,
            is_lp_token       : true,
        };
        0x2::event::emit<PoolCreated>(v2);
        let v3 = LPTypeAllowed{lp_type: v0};
        0x2::event::emit<LPTypeAllowed>(v3);
    }

    public entry fun create_reward_vault(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardVault{
            id              : 0x2::object::new(arg2),
            victory_balance : 0x2::balance::zero<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::victory_token::VICTORY_TOKEN>(),
        };
        0x2::transfer::share_object<RewardVault>(v0);
        let v1 = RewardVaultCreated{
            vault_id  : 0x2::object::uid_to_inner(&v0.id),
            admin     : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<RewardVaultCreated>(v1);
    }

    public entry fun create_single_asset_pool<T0>(arg0: &mut Farm, arg1: u256, arg2: u256, arg3: u256, arg4: bool, arg5: &AdminCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0), 4);
        assert!(arg2 <= 1000 && arg3 <= 1000, 3);
        let v1 = Pool{
            pool_type                   : v0,
            total_staked                : 0,
            allocation_points           : arg1,
            acc_reward_per_share        : 0,
            last_reward_time            : 0x2::clock::timestamp_ms(arg6) / 1000,
            deposit_fee                 : arg2,
            withdrawal_fee              : arg3,
            active                      : true,
            stakers                     : 0x2::table::new<address, Staker>(arg7),
            is_native_pair              : arg4,
            is_lp_token                 : false,
            accumulated_deposit_fees    : 0,
            accumulated_withdrawal_fees : 0,
        };
        arg0.total_allocation_points = arg0.total_allocation_points + arg1;
        arg0.total_single_allocation_points = arg0.total_single_allocation_points + arg1;
        0x2::table::add<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0, v1);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.pool_list, v0);
        let v2 = PoolCreated{
            pool_type         : v0,
            allocation_points : arg1,
            deposit_fee       : arg2,
            withdrawal_fee    : arg3,
            is_native_pair    : arg4,
            is_lp_token       : false,
        };
        0x2::event::emit<PoolCreated>(v2);
    }

    public entry fun deposit_victory_tokens(arg0: &mut RewardVault, arg1: 0x2::coin::Coin<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::victory_token::VICTORY_TOKEN>, arg2: &AdminCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::victory_token::VICTORY_TOKEN>(&arg1);
        assert!(v0 > 0, 6);
        0x2::balance::join<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::victory_token::VICTORY_TOKEN>(&mut arg0.victory_balance, 0x2::coin::into_balance<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::victory_token::VICTORY_TOKEN>(arg1));
        let v1 = VaultDeposit{
            amount        : (v0 as u256),
            total_balance : (0x2::balance::value<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::victory_token::VICTORY_TOKEN>(&arg0.victory_balance) as u256),
            timestamp     : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<VaultDeposit>(v1);
    }

    fun distribute_farm_fees<T0>(arg0: address, arg1: address, arg2: address, arg3: address, arg4: address, arg5: &mut 0x2::coin::Coin<T0>, arg6: u256, arg7: 0x1::type_name::TypeName, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = (0x2::coin::value<T0>(arg5) as u256);
        let v1 = v0 * 4000 / 10000;
        let v2 = v0 * 4000 / 10000;
        let v3 = v0 * 1000 / 10000;
        let v4 = v0 * 800 / 10000;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg5, (v1 as u64), arg9), arg0);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg5, (v2 as u64), arg9), arg1);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg5, (v3 as u64), arg9), arg2);
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg5, (v4 as u64), arg9), arg3);
        };
        let v5 = 0x2::coin::value<T0>(arg5);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg5, v5, arg9), arg4);
        };
    }

    fun distribute_from_vault(arg0: &mut RewardVault, arg1: &mut Farm, arg2: u256, arg3: address, arg4: bool, arg5: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = validate_emission_state(arg5, arg6);
        if (!v0 || v2) {
            return
        };
        if (!v1) {
            let v3 = EmissionWarning{
                message   : 0x1::string::utf8(b"Distributing earned Victory rewards after emission end"),
                pool_type : 0x1::option::none<0x1::type_name::TypeName>(),
                timestamp : 0x2::clock::timestamp_ms(arg6) / 1000,
            };
            0x2::event::emit<EmissionWarning>(v3);
        };
        let v4 = if (arg2 > 18446744073709551615) {
            18446744073709551615
        } else {
            (arg2 as u64)
        };
        assert!(0x2::balance::value<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::victory_token::VICTORY_TOKEN>(&arg0.victory_balance) >= v4, 15);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::victory_token::VICTORY_TOKEN>>(0x2::coin::from_balance<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::victory_token::VICTORY_TOKEN>(0x2::balance::split<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::victory_token::VICTORY_TOKEN>(&mut arg0.victory_balance, v4), arg7), arg3);
        track_victory_distribution(arg1, arg2, arg4, arg6);
    }

    fun ensure_no_existing_position_for_pool(arg0: &Farm, arg1: address, arg2: 0x1::type_name::TypeName) {
        if (0x2::table::contains<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&arg0.user_positions, arg1)) {
            let v0 = 0x2::table::borrow<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&arg0.user_positions, arg1);
            if (0x2::table::contains<0x1::type_name::TypeName, vector<0x2::object::ID>>(v0, arg2)) {
                assert!(0x1::vector::is_empty<0x2::object::ID>(0x2::table::borrow<0x1::type_name::TypeName, vector<0x2::object::ID>>(v0, arg2)), 1);
            };
        };
    }

    public fun get_all_user_positions(arg0: &Farm, arg1: address) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        if (!0x2::table::contains<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&arg0.user_positions, arg1)) {
            return v0
        };
        let v1 = 0x2::table::borrow<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&arg0.user_positions, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.pool_list)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.pool_list, v2);
            if (0x2::table::contains<0x1::type_name::TypeName, vector<0x2::object::ID>>(v1, v3)) {
                let v4 = 0x2::table::borrow<0x1::type_name::TypeName, vector<0x2::object::ID>>(v1, v3);
                let v5 = 0;
                while (v5 < 0x1::vector::length<0x2::object::ID>(v4)) {
                    0x1::vector::push_back<0x2::object::ID>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(v4, v5));
                    v5 = v5 + 1;
                };
            };
            v2 = v2 + 1;
        };
        v0
    }

    fun get_allocations_safe(arg0: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) : (u256, u256) {
        let (v0, v1, v2) = validate_emission_state(arg0, arg1);
        let v3 = if (!v0) {
            true
        } else if (!v1) {
            true
        } else {
            v2
        };
        if (v3) {
            return (0, 0)
        };
        0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::get_farm_allocations(arg0, arg1)
    }

    public fun get_current_allocations(arg0: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) : (u256, u256, bool, u64) {
        let (v0, v1) = get_allocations_safe(arg0, arg1);
        let (v2, v3, v4) = validate_emission_state(arg0, arg1);
        let v5 = if (v2) {
            if (v3) {
                !v4
            } else {
                false
            }
        } else {
            false
        };
        let (v6, _, _, _, _) = 0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::get_emission_status(arg0, arg1);
        (v0, v1, v5, v6)
    }

    public fun get_current_allocations_with_cap(arg0: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) : (u256, u256, bool, u64) {
        let (v0, v1, v2) = validate_emission_state(arg0, arg1);
        let v3 = if (!v0) {
            true
        } else if (!v1) {
            true
        } else {
            v2
        };
        if (v3) {
            return (0, 0, false, get_current_emission_week(arg0, arg1))
        };
        let (v4, v5) = 0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::get_farm_allocations(arg0, arg1);
        (v4, v5, true, get_current_emission_week(arg0, arg1))
    }

    fun get_current_emission_week(arg0: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) : u64 {
        0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::get_current_emission_week(arg0, arg1)
    }

    fun get_emission_end_timestamp(arg0: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig) : u64 {
        let (v0, _) = 0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::get_config_info(arg0);
        v0 + get_emission_end_week() * 604800
    }

    fun get_emission_end_week() : u64 {
        let (_, _, _, v3) = 0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::get_emission_phase_parameters();
        v3
    }

    public fun get_emission_status_for_farm(arg0: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) : (bool, bool, bool, u64, u8) {
        let (v0, v1, v2) = validate_emission_state(arg0, arg1);
        let (v3, v4, _, _, _) = 0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::get_emission_status(arg0, arg1);
        (v0, v1, v2, v3, v4)
    }

    public fun get_farm_emission_info(arg0: &Farm, arg1: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg2: &0x2::clock::Clock) : (bool, bool, bool, u64, u64, u64, u64) {
        let (v0, v1, v2) = validate_emission_state(arg1, arg2);
        (v0, v1, v2, get_current_emission_week(arg1, arg2), arg0.emission_start_timestamp, arg0.emission_end_timestamp, 0x2::clock::timestamp_ms(arg2) / 1000)
    }

    public fun get_farm_info(arg0: &Farm) : (bool, u256, u256) {
        (arg0.paused, arg0.total_lp_allocation_points, arg0.total_single_allocation_points)
    }

    public fun get_farm_info_detailed(arg0: &Farm) : (bool, u256, u256, u256) {
        (arg0.paused, arg0.total_lp_allocation_points, arg0.total_single_allocation_points, arg0.total_victory_distributed)
    }

    public fun get_farm_victory_distribution_stats(arg0: &Farm) : (u256, u256, u256) {
        (arg0.total_lp_victory_distributed, arg0.total_single_victory_distributed, arg0.total_lp_victory_distributed + arg0.total_single_victory_distributed)
    }

    public fun get_min_unstake_time<T0>(arg0: &Farm, arg1: address) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, Pool>(&arg0.pools, v0);
        if (!0x2::table::contains<address, Staker>(&v1.stakers, arg1)) {
            return 0
        };
        0x2::table::borrow<address, Staker>(&v1.stakers, arg1).last_stake_timestamp + 3600
    }

    public fun get_pending_rewards<T0>(arg0: &Farm, arg1: address, arg2: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u256 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0)) {
            return 0
        };
        let (v1, _, v3) = validate_emission_state(arg2, arg3);
        if (!v1 || v3) {
            return 0
        };
        let v4 = 0x2::table::borrow<0x1::type_name::TypeName, Pool>(&arg0.pools, v0);
        if (!0x2::table::contains<address, Staker>(&v4.stakers, arg1)) {
            return 0
        };
        let v5 = 0x2::table::borrow<address, Staker>(&v4.stakers, arg1);
        if (v5.amount == 0 || v4.total_staked == 0) {
            return 0
        };
        let v6 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v7 = get_emission_end_timestamp(arg2);
        let v8 = if (v6 > v7) {
            v7
        } else {
            v6
        };
        let v9 = calculate_farm_rewards_multi_week(v4.is_lp_token, v4.allocation_points, arg0.total_lp_allocation_points, arg0.total_single_allocation_points, arg2, v4.last_reward_time, v8);
        let v10 = if (v9 > 0) {
            safe_mul_div_u256(v9, 1000000000000000000, v4.total_staked)
        } else {
            0
        };
        calculate_pending_rewards_masterchef(v5.amount, v5.reward_debt, v4.acc_reward_per_share + v10)
    }

    public fun get_pool_accumulator_info<T0>(arg0: &Farm) : (u256, u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0)) {
            return (0, 0)
        };
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, Pool>(&arg0.pools, v0);
        (v1.acc_reward_per_share, v1.last_reward_time)
    }

    public fun get_pool_info<T0>(arg0: &Farm) : (u256, u256, u256, bool, bool, bool) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0)) {
            return (0, 0, 0, false, false, false)
        };
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, Pool>(&arg0.pools, v0);
        (v1.total_staked, v1.deposit_fee, v1.withdrawal_fee, v1.active, v1.is_native_pair, v1.is_lp_token)
    }

    public fun get_pool_internal_state<T0>(arg0: &Farm) : (u256, u256, u64, bool) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0)) {
            return (0, 0, 0, false)
        };
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, Pool>(&arg0.pools, v0);
        (v1.total_staked, v1.acc_reward_per_share, v1.last_reward_time, v1.active)
    }

    public fun get_pool_list(arg0: &Farm) : &vector<0x1::type_name::TypeName> {
        &arg0.pool_list
    }

    public fun get_pool_reward_status<T0>(arg0: &Farm, arg1: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg2: &0x2::clock::Clock) : (bool, u256, 0x1::string::String) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0)) {
            return (false, 0, 0x1::string::utf8(b"Pool not found"))
        };
        let (v1, v2) = get_allocations_safe(arg1, arg2);
        if (0x2::table::borrow<0x1::type_name::TypeName, Pool>(&arg0.pools, v0).is_lp_token) {
            let v6 = if (v1 > 0) {
                0x1::string::utf8(b"Active")
            } else {
                0x1::string::utf8(b"Ended")
            };
            (v1 > 0, v1, v6)
        } else {
            let v7 = if (v2 > 0) {
                0x1::string::utf8(b"Active")
            } else {
                0x1::string::utf8(b"Single rewards ended")
            };
            (v2 > 0, v2, v7)
        }
    }

    public fun get_staker_info<T0>(arg0: &Farm, arg1: address) : (u256, u256, u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0)) {
            return (0, 0, 0, 0)
        };
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, Pool>(&arg0.pools, v0);
        if (!0x2::table::contains<address, Staker>(&v1.stakers, arg1)) {
            return (0, 0, 0, 0)
        };
        let v2 = 0x2::table::borrow<address, Staker>(&v1.stakers, arg1);
        (v2.amount, v2.rewards_claimed, v2.last_stake_timestamp, v2.last_claim_timestamp)
    }

    public fun get_token_type<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::get<T0>()
    }

    public fun get_total_victory_distributed(arg0: &Farm) : u256 {
        arg0.total_victory_distributed
    }

    public fun get_user_position_summaries(arg0: &Farm, arg1: address) : vector<PositionSummary> {
        let v0 = 0x1::vector::empty<PositionSummary>();
        if (!0x2::table::contains<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&arg0.user_positions, arg1)) {
            return v0
        };
        let v1 = 0x2::table::borrow<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&arg0.user_positions, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.pool_list)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.pool_list, v2);
            if (0x2::table::contains<0x1::type_name::TypeName, vector<0x2::object::ID>>(v1, v3)) {
                let v4 = 0x2::table::borrow<0x1::type_name::TypeName, vector<0x2::object::ID>>(v1, v3);
                let v5 = 0;
                while (v5 < 0x1::vector::length<0x2::object::ID>(v4)) {
                    let v6 = *0x1::vector::borrow<0x2::object::ID>(v4, v5);
                    if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.position_to_vault, v6)) {
                        let v7 = 0x2::table::borrow<0x1::type_name::TypeName, Pool>(&arg0.pools, v3);
                        if (0x2::table::contains<address, Staker>(&v7.stakers, arg1)) {
                            let v8 = PositionSummary{
                                id         : v6,
                                token_type : v3,
                                amount     : 0x2::table::borrow<address, Staker>(&v7.stakers, arg1).amount,
                            };
                            0x1::vector::push_back<PositionSummary>(&mut v0, v8);
                        };
                    };
                    v5 = v5 + 1;
                };
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_user_token_positions(arg0: &Farm, arg1: address, arg2: 0x1::type_name::TypeName) : vector<0x2::object::ID> {
        if (!0x2::table::contains<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&arg0.user_positions, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        let v0 = 0x2::table::borrow<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&arg0.user_positions, arg1);
        if (!0x2::table::contains<0x1::type_name::TypeName, vector<0x2::object::ID>>(v0, arg2)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        *0x2::table::borrow<0x1::type_name::TypeName, vector<0x2::object::ID>>(v0, arg2)
    }

    public fun get_user_token_stakes(arg0: &Farm, arg1: address, arg2: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : vector<UserTokenStake> {
        let v0 = 0x1::vector::empty<UserTokenStake>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.pool_list)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.pool_list, v1);
            if (0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v2)) {
                let v3 = 0x2::table::borrow<0x1::type_name::TypeName, Pool>(&arg0.pools, v2);
                if (0x2::table::contains<address, Staker>(&v3.stakers, arg1)) {
                    let v4 = 0x2::table::borrow<address, Staker>(&v3.stakers, arg1);
                    let v5 = 0;
                    if (0x2::table::contains<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&arg0.user_positions, arg1)) {
                        let v6 = 0x2::table::borrow<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&arg0.user_positions, arg1);
                        if (0x2::table::contains<0x1::type_name::TypeName, vector<0x2::object::ID>>(v6, v2)) {
                            v5 = 0x1::vector::length<0x2::object::ID>(0x2::table::borrow<0x1::type_name::TypeName, vector<0x2::object::ID>>(v6, v2));
                        };
                    };
                    let v7 = 0;
                    if (v4.amount > 0) {
                        let (v8, v9, v10) = validate_emission_state(arg2, arg3);
                        let v11 = if (v8) {
                            if (v9) {
                                !v10
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        if (v11) {
                            let v12 = 0x2::clock::timestamp_ms(arg3) / 1000;
                            let v13 = v3.last_reward_time;
                            if (v12 > v13 && v3.total_staked > 0) {
                                let v14 = calculate_farm_rewards_multi_week(v3.is_lp_token, v3.allocation_points, arg0.total_lp_allocation_points, arg0.total_single_allocation_points, arg2, v13, v12);
                                if (v14 > 0) {
                                    v7 = calculate_pending_rewards_masterchef(v4.amount, v4.reward_debt, v3.acc_reward_per_share + safe_mul_div_u256(v14, 1000000000000000000, v3.total_staked));
                                };
                            };
                        };
                    };
                    let v15 = UserTokenStake{
                        token_type      : v2,
                        total_amount    : v4.amount,
                        position_count  : v5,
                        pending_rewards : v7,
                    };
                    0x1::vector::push_back<UserTokenStake>(&mut v0, v15);
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_vault_balance(arg0: &RewardVault) : u256 {
        (0x2::balance::value<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::victory_token::VICTORY_TOKEN>(&arg0.victory_balance) as u256)
    }

    public fun get_vault_id_for_position(arg0: &Farm, arg1: 0x2::object::ID) : 0x2::object::ID {
        *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.position_to_vault, arg1)
    }

    fun init(arg0: FARM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Farm{
            id                               : 0x2::object::new(arg1),
            admin                            : v0,
            pools                            : 0x2::table::new<0x1::type_name::TypeName, Pool>(arg1),
            pool_list                        : 0x1::vector::empty<0x1::type_name::TypeName>(),
            burn_address                     : @0x573ca6f6d54c7dd4ee0aabde736cdec680011829a023995d3fd42e29a032e408,
            locker_address                   : @0x5d061bec906f70c9f2b386e54361a62e2cc63b596d7ec2eb020e2a2d47232f05,
            team_1_address                   : @0xb81aa00ad7f9e863628fe95c2c2f78490cdc8b1e25cd20eea47d9029e6195406,
            team_2_address                   : @0x75f38c1d3059b6c14e4d22abba2961cccadd0d2505bc942fd364a4bcdbbc9ba5,
            dev_address                      : @0xd84a545cf56ea9dcdcabe6a729bbf9da8b81d37fc00dbc7d177abd726ab765af,
            total_victory_distributed        : 0,
            last_update_timestamp            : 0,
            paused                           : false,
            allowed_lp_types                 : 0x2::table::new<0x1::type_name::TypeName, bool>(arg1),
            total_allocation_points          : 0,
            total_lp_allocation_points       : 0,
            total_single_allocation_points   : 0,
            position_to_vault                : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
            user_positions                   : 0x2::table::new<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(arg1),
            total_lp_victory_distributed     : 0,
            total_single_victory_distributed : 0,
            emission_start_timestamp         : 0,
            emission_end_timestamp           : 0,
        };
        0x2::transfer::share_object<Farm>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public entry fun initialize_farm_tracking(arg0: &mut Farm, arg1: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg2: &AdminCap, arg3: &0x2::clock::Clock) {
        let (v0, _) = 0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::get_config_info(arg1);
        arg0.emission_start_timestamp = v0;
        arg0.emission_end_timestamp = get_emission_end_timestamp(arg1);
        arg0.total_lp_victory_distributed = 0;
        arg0.total_single_victory_distributed = 0;
        let v2 = FarmVictoryDistributionTracking{
            lp_victory_distributed     : 0,
            single_victory_distributed : 0,
            total_victory_distributed  : 0,
            timestamp                  : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<FarmVictoryDistributionTracking>(v2);
    }

    public fun is_lp_type_allowed<T0, T1>(arg0: &Farm) : bool {
        0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.allowed_lp_types, 0x1::type_name::get<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>())
    }

    public entry fun mass_update_pools_batch(arg0: &mut Farm, arg1: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (bool, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = 0x1::vector::length<0x1::type_name::TypeName>(&arg0.pool_list);
        let v2 = if (arg4 == 0) {
            5
        } else {
            arg4
        };
        let v3 = if (arg3 + v2 > v1) {
            v1
        } else {
            arg3 + v2
        };
        assert!(arg3 < v1, 5);
        let v4 = 0;
        while (arg3 < v3) {
            let v5 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.pool_list, arg3));
            if (v5.total_staked > 0 && v5.active) {
                update_pool_accumulator_masterchef(v5, arg0.total_lp_allocation_points, arg0.total_single_allocation_points, arg1, arg2, v0);
                v4 = v4 + 1;
            };
            arg3 = arg3 + 1;
        };
        let v6 = v3 < v1;
        let v7 = if (v6) {
            v3
        } else {
            0
        };
        let v8 = PoolBatchUpdateCompleted{
            batch_start_index      : arg3,
            batch_end_index        : v3,
            pools_updated_in_batch : v4,
            total_pools_in_farm    : v1,
            has_more_batches       : v6,
            next_batch_start_index : v7,
            timestamp              : v0,
        };
        0x2::event::emit<PoolBatchUpdateCompleted>(v8);
        (v6, v7)
    }

    public entry fun pause_emissions_safely(arg0: &mut Farm, arg1: &mut 0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg2: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::AdminCap, arg3: &AdminCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::set_pause_state(arg2, arg1, true, arg4, arg5);
        let v0 = EmissionsPausedSafely{
            pools_updated_count : 0,
            admin               : 0x2::tx_context::sender(arg5),
            timestamp           : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<EmissionsPausedSafely>(v0);
    }

    fun safe_mul_div_u256(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg2 == 0) {
            return 0
        };
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        arg0 * arg1 / arg2
    }

    public entry fun set_addresses(arg0: &mut Farm, arg1: address, arg2: address, arg3: address, arg4: address, arg5: address, arg6: &AdminCap, arg7: &0x2::clock::Clock) {
        let v0 = if (arg1 != @0x0) {
            if (arg2 != @0x0) {
                if (arg3 != @0x0) {
                    if (arg4 != @0x0) {
                        arg5 != @0x0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        arg0.burn_address = arg1;
        arg0.locker_address = arg2;
        arg0.team_1_address = arg3;
        arg0.team_2_address = arg4;
        arg0.dev_address = arg5;
        let v1 = AdminAddressesUpdated{
            old_burn_address   : arg0.burn_address,
            new_burn_address   : arg1,
            old_locker_address : arg0.locker_address,
            new_locker_address : arg2,
            old_team_1_address : arg0.team_1_address,
            new_team_1_address : arg3,
            old_team_2_address : arg0.team_2_address,
            new_team_2_address : arg4,
            old_dev_address    : arg0.dev_address,
            new_dev_address    : arg5,
            timestamp          : 0x2::clock::timestamp_ms(arg7) / 1000,
        };
        0x2::event::emit<AdminAddressesUpdated>(v1);
    }

    public entry fun set_pause_state(arg0: &mut Farm, arg1: bool, arg2: &AdminCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.paused = arg1;
        let v0 = FarmPauseStateChanged{
            old_paused : arg0.paused,
            new_paused : arg1,
            admin      : 0x2::tx_context::sender(arg4),
            timestamp  : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<FarmPauseStateChanged>(v0);
    }

    public entry fun stake_lp<T0, T1>(arg0: &mut Farm, arg1: &mut RewardVault, arg2: vector<0x2::coin::Coin<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>>, arg3: u256, arg4: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        assert!(arg3 >= 1000000, 6);
        let v0 = 0x1::type_name::get<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0), 5);
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.allowed_lp_types, v0), 12);
        validate_new_stake_allowed(arg4, arg5);
        let v1 = 0x2::clock::timestamp_ms(arg5) / 1000;
        arg0.last_update_timestamp = v1;
        let v2 = 0x2::tx_context::sender(arg6);
        ensure_no_existing_position_for_pool(arg0, v2, v0);
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0);
        assert!(v3.active, 7);
        let (_, _, _) = validate_emission_state(arg4, arg5);
        update_pool_accumulator_masterchef(v3, arg0.total_lp_allocation_points, arg0.total_single_allocation_points, arg4, arg5, v1);
        let v7 = if (0x2::table::contains<address, Staker>(&v3.stakers, v2)) {
            let v8 = 0x2::table::borrow<address, Staker>(&v3.stakers, v2);
            calculate_pending_rewards_masterchef(v8.amount, v8.reward_debt, v3.acc_reward_per_share)
        } else {
            0
        };
        let v9 = arg3 * v3.deposit_fee / 10000;
        let v10 = arg3 - v9;
        let v11 = 0x1::vector::pop_back<0x2::coin::Coin<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>>(&mut arg2);
        while (!0x1::vector::is_empty<0x2::coin::Coin<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>>(&arg2)) {
            0x2::coin::join<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(&mut v11, 0x1::vector::pop_back<0x2::coin::Coin<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>>(&mut arg2));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>>(arg2);
        assert!((0x2::coin::value<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(&v11) as u256) >= arg3, 8);
        if (!0x2::table::contains<address, Staker>(&v3.stakers, v2)) {
            let v12 = Staker{
                amount               : 0,
                reward_debt          : 0,
                rewards_claimed      : 0,
                last_stake_timestamp : v1,
                last_claim_timestamp : v1,
            };
            0x2::table::add<address, Staker>(&mut v3.stakers, v2, v12);
        };
        if (v9 > 0) {
            let v13 = 0x2::coin::split<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(&mut v11, (v9 as u64), arg6);
            let v14 = &mut v13;
            distribute_farm_fees<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(arg0.burn_address, arg0.locker_address, arg0.team_1_address, arg0.team_2_address, arg0.dev_address, v14, v9, v0, v1, arg6);
            0x2::coin::destroy_zero<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(v13);
            v3.accumulated_deposit_fees = v3.accumulated_deposit_fees + v9;
            let v15 = FeesCollected{
                pool_type : v3.pool_type,
                amount    : v9,
                fee_type  : 0x1::string::utf8(b"deposit"),
                timestamp : v1,
            };
            0x2::event::emit<FeesCollected>(v15);
        };
        let v16 = StakedTokenVault<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>{
            id                      : 0x2::object::new(arg6),
            balance                 : 0x2::coin::into_balance<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(0x2::coin::split<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(&mut v11, (v10 as u64), arg6)),
            owner                   : v2,
            pool_type               : v0,
            amount                  : v10,
            initial_stake_timestamp : v1,
        };
        if (0x2::coin::value<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(&v11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>>(v11, v2);
        } else {
            0x2::coin::destroy_zero<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(v11);
        };
        let v17 = StakingPosition<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>{
            id                      : 0x2::object::new(arg6),
            owner                   : v2,
            pool_type               : v0,
            amount                  : v10,
            initial_stake_timestamp : v1,
            vault_id                : 0x2::object::uid_to_inner(&v16.id),
        };
        let v18 = 0x2::object::uid_to_inner(&v17.id);
        if (!0x2::table::contains<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&mut arg0.user_positions, v2)) {
            0x2::table::add<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&mut arg0.user_positions, v2, 0x2::table::new<0x1::type_name::TypeName, vector<0x2::object::ID>>(arg6));
        };
        let v19 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&mut arg0.user_positions, v2);
        if (!0x2::table::contains<0x1::type_name::TypeName, vector<0x2::object::ID>>(v19, v0)) {
            0x2::table::add<0x1::type_name::TypeName, vector<0x2::object::ID>>(v19, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x1::type_name::TypeName, vector<0x2::object::ID>>(v19, v0), v18);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.position_to_vault, v18, 0x2::object::uid_to_inner(&v16.id));
        0x2::transfer::share_object<StakedTokenVault<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>>(v16);
        0x2::transfer::transfer<StakingPosition<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>>(v17, v2);
        let v20 = 0x2::table::borrow_mut<address, Staker>(&mut v3.stakers, v2);
        v20.amount = v20.amount + v10;
        v20.last_stake_timestamp = v1;
        v3.total_staked = v3.total_staked + v10;
        if (v7 > 0) {
            v20.reward_debt = safe_mul_div_u256(v20.amount, v3.acc_reward_per_share, 1000000000000000000);
            arg0.total_victory_distributed = arg0.total_victory_distributed + v7;
            distribute_from_vault(arg1, arg0, v7, v2, true, arg4, arg5, arg6);
            let v21 = 0x2::table::borrow_mut<address, Staker>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0).stakers, v2);
            v21.rewards_claimed = v21.rewards_claimed + v7;
            v21.last_claim_timestamp = v1;
            let v22 = RewardClaimed{
                staker    : v2,
                pool_type : v0,
                amount    : v7,
                timestamp : v1,
            };
            0x2::event::emit<RewardClaimed>(v22);
        } else {
            v20.reward_debt = safe_mul_div_u256(v20.amount, v3.acc_reward_per_share, 1000000000000000000);
        };
        let v23 = Staked{
            staker    : v2,
            pool_type : v0,
            amount    : v10,
            timestamp : v1,
        };
        0x2::event::emit<Staked>(v23);
    }

    public entry fun stake_single<T0>(arg0: &mut Farm, arg1: &mut RewardVault, arg2: 0x2::coin::Coin<T0>, arg3: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        let v0 = (0x2::coin::value<T0>(&arg2) as u256);
        assert!(v0 >= 1000000, 6);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v1), 5);
        validate_new_stake_allowed(arg3, arg4);
        let (_, v3) = get_allocations_safe(arg3, arg4);
        assert!(v3 > 0, 19);
        let v4 = 0x2::clock::timestamp_ms(arg4) / 1000;
        arg0.last_update_timestamp = v4;
        let v5 = 0x2::tx_context::sender(arg5);
        ensure_no_existing_position_for_pool(arg0, v5, v1);
        let v6 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v1);
        assert!(v6.active, 7);
        let (v7, v8, v9) = validate_emission_state(arg3, arg4);
        let (_, v11) = get_allocations_safe(arg3, arg4);
        if (v11 == 0 && v7) {
            let v12 = EmissionWarning{
                message   : 0x1::string::utf8(b"Single asset rewards ended - consider LP staking"),
                pool_type : 0x1::option::some<0x1::type_name::TypeName>(v1),
                timestamp : v4,
            };
            0x2::event::emit<EmissionWarning>(v12);
        };
        update_pool_accumulator_masterchef(v6, arg0.total_lp_allocation_points, arg0.total_single_allocation_points, arg3, arg4, v4);
        let v13 = v0 * v6.deposit_fee / 10000;
        let v14 = v0 - v13;
        if (!0x2::table::contains<address, Staker>(&v6.stakers, v5)) {
            let v15 = Staker{
                amount               : 0,
                reward_debt          : 0,
                rewards_claimed      : 0,
                last_stake_timestamp : v4,
                last_claim_timestamp : v4,
            };
            0x2::table::add<address, Staker>(&mut v6.stakers, v5, v15);
        };
        let v16 = if (0x2::table::contains<address, Staker>(&v6.stakers, v5)) {
            let v17 = 0x2::table::borrow<address, Staker>(&v6.stakers, v5);
            let v18 = if (v17.amount > 0) {
                if (v7) {
                    if (v8) {
                        !v9
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v18) {
                calculate_pending_rewards_masterchef(v17.amount, v17.reward_debt, v6.acc_reward_per_share)
            } else {
                0
            }
        } else {
            0
        };
        if (v13 > 0) {
            let v19 = 0x2::coin::split<T0>(&mut arg2, (v13 as u64), arg5);
            let v20 = &mut v19;
            distribute_farm_fees<T0>(arg0.burn_address, arg0.locker_address, arg0.team_1_address, arg0.team_2_address, arg0.dev_address, v20, v13, v1, v4, arg5);
            0x2::coin::destroy_zero<T0>(v19);
            v6.accumulated_deposit_fees = v6.accumulated_deposit_fees + v13;
            let v21 = FeesCollected{
                pool_type : v6.pool_type,
                amount    : v13,
                fee_type  : 0x1::string::utf8(b"deposit"),
                timestamp : v4,
            };
            0x2::event::emit<FeesCollected>(v21);
        };
        let v22 = StakedTokenVault<T0>{
            id                      : 0x2::object::new(arg5),
            balance                 : 0x2::coin::into_balance<T0>(arg2),
            owner                   : v5,
            pool_type               : v1,
            amount                  : v14,
            initial_stake_timestamp : v4,
        };
        let v23 = StakingPosition<T0>{
            id                      : 0x2::object::new(arg5),
            owner                   : v5,
            pool_type               : v1,
            amount                  : v14,
            initial_stake_timestamp : v4,
            vault_id                : 0x2::object::uid_to_inner(&v22.id),
        };
        let v24 = 0x2::object::uid_to_inner(&v23.id);
        if (!0x2::table::contains<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&mut arg0.user_positions, v5)) {
            0x2::table::add<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&mut arg0.user_positions, v5, 0x2::table::new<0x1::type_name::TypeName, vector<0x2::object::ID>>(arg5));
        };
        let v25 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&mut arg0.user_positions, v5);
        if (!0x2::table::contains<0x1::type_name::TypeName, vector<0x2::object::ID>>(v25, v1)) {
            0x2::table::add<0x1::type_name::TypeName, vector<0x2::object::ID>>(v25, v1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x1::type_name::TypeName, vector<0x2::object::ID>>(v25, v1), v24);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.position_to_vault, v24, 0x2::object::uid_to_inner(&v22.id));
        0x2::transfer::share_object<StakedTokenVault<T0>>(v22);
        0x2::transfer::transfer<StakingPosition<T0>>(v23, v5);
        let v26 = 0x2::table::borrow_mut<address, Staker>(&mut v6.stakers, v5);
        v26.amount = v26.amount + v14;
        v26.last_stake_timestamp = v4;
        if (v16 > 0) {
            v6.total_staked = v6.total_staked + v14;
            v26.reward_debt = safe_mul_div_u256(v26.amount, v6.acc_reward_per_share, 1000000000000000000);
            arg0.total_victory_distributed = arg0.total_victory_distributed + v16;
            distribute_from_vault(arg1, arg0, v16, v5, false, arg3, arg4, arg5);
            let v27 = 0x2::table::borrow_mut<address, Staker>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v1).stakers, v5);
            v27.rewards_claimed = v27.rewards_claimed + v16;
            v27.last_claim_timestamp = v4;
            let v28 = RewardClaimed{
                staker    : v5,
                pool_type : v1,
                amount    : v16,
                timestamp : v4,
            };
            0x2::event::emit<RewardClaimed>(v28);
        } else {
            v6.total_staked = v6.total_staked + v14;
            v26.reward_debt = safe_mul_div_u256(v26.amount, v6.acc_reward_per_share, 1000000000000000000);
        };
        let v29 = Staked{
            staker    : v5,
            pool_type : v1,
            amount    : v14,
            timestamp : v4,
        };
        0x2::event::emit<Staked>(v29);
    }

    fun track_victory_distribution(arg0: &mut Farm, arg1: u256, arg2: bool, arg3: &0x2::clock::Clock) {
        if (arg2) {
            arg0.total_lp_victory_distributed = arg0.total_lp_victory_distributed + arg1;
        } else {
            arg0.total_single_victory_distributed = arg0.total_single_victory_distributed + arg1;
        };
        let v0 = FarmVictoryDistributionTracking{
            lp_victory_distributed     : arg0.total_lp_victory_distributed,
            single_victory_distributed : arg0.total_single_victory_distributed,
            total_victory_distributed  : arg0.total_lp_victory_distributed + arg0.total_single_victory_distributed,
            timestamp                  : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<FarmVictoryDistributionTracking>(v0);
    }

    public entry fun unstake_lp<T0, T1>(arg0: &mut Farm, arg1: &mut RewardVault, arg2: StakingPosition<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>, arg3: &mut StakedTokenVault<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>, arg4: u256, arg5: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        validate_unstake_allowed(arg5, arg6);
        let v0 = 0x1::type_name::get<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0), 5);
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(arg2.owner == v1, 10);
        let v2 = 0x2::object::uid_to_inner(&arg2.id);
        assert!(arg2.vault_id == 0x2::object::uid_to_inner(&arg3.id), 14);
        assert!(arg3.owner == v1, 10);
        assert!(arg2.amount == arg3.amount, 11);
        assert!(arg4 > 0 && arg4 <= arg2.amount, 6);
        assert!(0x2::balance::value<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(&arg3.balance) >= (arg4 as u64), 8);
        let v3 = 0x2::clock::timestamp_ms(arg6) / 1000;
        arg0.last_update_timestamp = v3;
        let v4 = arg0.burn_address;
        let v5 = arg0.locker_address;
        let v6 = arg0.team_1_address;
        let v7 = arg0.team_2_address;
        let v8 = arg0.dev_address;
        let v9 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0);
        assert!(v9.active, 7);
        let (v10, _, v12) = validate_emission_state(arg5, arg6);
        let v13 = get_emission_end_timestamp(arg5);
        let v14 = if (v3 > v13) {
            v13
        } else {
            v3
        };
        update_pool_accumulator_masterchef(v9, arg0.total_lp_allocation_points, arg0.total_single_allocation_points, arg5, arg6, v14);
        let v15 = 0;
        if (0x2::table::contains<address, Staker>(&v9.stakers, v1)) {
            let v16 = 0x2::table::borrow<address, Staker>(&v9.stakers, v1);
            assert!(v3 >= v16.last_stake_timestamp + 3600, 20);
            let v17 = if (v16.amount > 0) {
                if (v10) {
                    !v12
                } else {
                    false
                }
            } else {
                false
            };
            if (v17) {
                v15 = calculate_pending_rewards_masterchef(v16.amount, v16.reward_debt, v9.acc_reward_per_share);
            } else if (v16.amount > 0) {
                let v18 = if (!v10) {
                    0x1::string::utf8(b"Unstaking allowed but no rewards - emissions not started")
                } else {
                    0x1::string::utf8(b"Unstaking allowed but no rewards - emissions ended or paused")
                };
                let v19 = EmissionWarning{
                    message   : v18,
                    pool_type : 0x1::option::some<0x1::type_name::TypeName>(v0),
                    timestamp : v3,
                };
                0x2::event::emit<EmissionWarning>(v19);
            };
        };
        let v20 = arg4 * v9.withdrawal_fee / 10000;
        let v21 = (v20 as u64);
        let v22 = ((arg4 - v20) as u64);
        if (0x2::table::contains<address, Staker>(&v9.stakers, v1)) {
            let v23 = 0x2::table::borrow_mut<address, Staker>(&mut v9.stakers, v1);
            v23.amount = v23.amount - arg4;
            v23.reward_debt = safe_mul_div_u256(v23.amount, v9.acc_reward_per_share, 1000000000000000000);
        };
        v9.total_staked = v9.total_staked - arg4;
        if (v15 > 0) {
            arg0.total_victory_distributed = arg0.total_victory_distributed + v15;
            distribute_from_vault(arg1, arg0, v15, v1, true, arg5, arg6, arg7);
            let v24 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0);
            if (0x2::table::contains<address, Staker>(&v24.stakers, v1)) {
                let v25 = 0x2::table::borrow_mut<address, Staker>(&mut v24.stakers, v1);
                v25.rewards_claimed = v25.rewards_claimed + v15;
                v25.last_claim_timestamp = v3;
            };
            let v26 = RewardClaimed{
                staker    : v1,
                pool_type : v0,
                amount    : v15,
                timestamp : v3,
            };
            0x2::event::emit<RewardClaimed>(v26);
        };
        if (v22 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>>(0x2::coin::from_balance<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(0x2::balance::split<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(&mut arg3.balance, v22), arg7), v1);
        };
        if (v21 > 0) {
            let v27 = 0x2::coin::from_balance<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(0x2::balance::split<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(&mut arg3.balance, v21), arg7);
            let v28 = &mut v27;
            distribute_farm_fees<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(v4, v5, v6, v7, v8, v28, v20, v0, v3, arg7);
            0x2::coin::destroy_zero<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(v27);
            let v29 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0);
            v29.accumulated_withdrawal_fees = v29.accumulated_withdrawal_fees + v20;
            let v30 = FeesCollected{
                pool_type : v0,
                amount    : v20,
                fee_type  : 0x1::string::utf8(b"withdrawal"),
                timestamp : v3,
            };
            0x2::event::emit<FeesCollected>(v30);
        };
        arg3.amount = arg3.amount - arg4;
        if (arg4 == arg2.amount) {
            if (0x2::table::contains<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&arg0.user_positions, v1)) {
                let v31 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&mut arg0.user_positions, v1);
                if (0x2::table::contains<0x1::type_name::TypeName, vector<0x2::object::ID>>(v31, v0)) {
                    let v32 = 0x2::table::borrow_mut<0x1::type_name::TypeName, vector<0x2::object::ID>>(v31, v0);
                    let v33 = 0;
                    let v34 = false;
                    while (v33 < 0x1::vector::length<0x2::object::ID>(v32) && !v34) {
                        if (*0x1::vector::borrow<0x2::object::ID>(v32, v33) == v2) {
                            0x1::vector::swap_remove<0x2::object::ID>(v32, v33);
                            v34 = true;
                            continue
                        };
                        v33 = v33 + 1;
                    };
                };
            };
            if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.position_to_vault, v2)) {
                0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.position_to_vault, v2);
            };
            let StakingPosition {
                id                      : v35,
                owner                   : _,
                pool_type               : _,
                amount                  : _,
                initial_stake_timestamp : _,
                vault_id                : _,
            } = arg2;
            0x2::object::delete(v35);
            if (0x2::balance::value<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>(&arg3.balance) == 0) {
                arg3.owner = @0x0;
            };
        } else {
            arg2.amount = arg2.amount - arg4;
            0x2::transfer::transfer<StakingPosition<0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair::LPCoin<T0, T1>>>(arg2, v1);
        };
        let v41 = Unstaked{
            staker    : v1,
            pool_type : v0,
            amount    : arg4,
            timestamp : v3,
        };
        0x2::event::emit<Unstaked>(v41);
    }

    public entry fun unstake_single<T0>(arg0: &mut Farm, arg1: &mut RewardVault, arg2: StakingPosition<T0>, arg3: &mut StakedTokenVault<T0>, arg4: u256, arg5: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        validate_unstake_allowed(arg5, arg6);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0), 5);
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(arg2.owner == v1, 10);
        let v2 = 0x2::object::uid_to_inner(&arg2.id);
        assert!(arg2.vault_id == 0x2::object::uid_to_inner(&arg3.id), 14);
        assert!(arg3.owner == v1, 10);
        assert!(arg2.amount == arg3.amount, 11);
        assert!(arg4 > 0 && arg4 <= arg2.amount, 6);
        assert!(0x2::balance::value<T0>(&arg3.balance) >= (arg4 as u64), 8);
        let v3 = 0x2::clock::timestamp_ms(arg6) / 1000;
        arg0.last_update_timestamp = v3;
        let v4 = arg0.burn_address;
        let v5 = arg0.locker_address;
        let v6 = arg0.team_1_address;
        let v7 = arg0.team_2_address;
        let v8 = arg0.dev_address;
        let v9 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0);
        assert!(v9.active, 7);
        let (v10, _, v12) = validate_emission_state(arg5, arg6);
        let v13 = get_emission_end_timestamp(arg5);
        let v14 = if (v3 > v13) {
            v13
        } else {
            v3
        };
        update_pool_accumulator_masterchef(v9, arg0.total_lp_allocation_points, arg0.total_single_allocation_points, arg5, arg6, v14);
        let v15 = 0;
        if (0x2::table::contains<address, Staker>(&v9.stakers, v1)) {
            let v16 = 0x2::table::borrow<address, Staker>(&v9.stakers, v1);
            assert!(v3 >= v16.last_stake_timestamp + 3600, 20);
            let v17 = if (v16.amount > 0) {
                if (v10) {
                    !v12
                } else {
                    false
                }
            } else {
                false
            };
            if (v17) {
                v15 = calculate_pending_rewards_masterchef(v16.amount, v16.reward_debt, v9.acc_reward_per_share);
            } else if (v16.amount > 0) {
                let v18 = if (!v10) {
                    0x1::string::utf8(b"Unstaking allowed but no rewards - emissions not started")
                } else {
                    0x1::string::utf8(b"Unstaking allowed but no rewards - emissions ended or paused")
                };
                let v19 = EmissionWarning{
                    message   : v18,
                    pool_type : 0x1::option::some<0x1::type_name::TypeName>(v0),
                    timestamp : v3,
                };
                0x2::event::emit<EmissionWarning>(v19);
            };
        };
        let v20 = arg4 * v9.withdrawal_fee / 10000;
        let v21 = (v20 as u64);
        let v22 = ((arg4 - v20) as u64);
        if (0x2::table::contains<address, Staker>(&v9.stakers, v1)) {
            let v23 = 0x2::table::borrow_mut<address, Staker>(&mut v9.stakers, v1);
            v23.amount = v23.amount - arg4;
            v23.reward_debt = safe_mul_div_u256(v23.amount, v9.acc_reward_per_share, 1000000000000000000);
        };
        v9.total_staked = v9.total_staked - arg4;
        if (v15 > 0) {
            arg0.total_victory_distributed = arg0.total_victory_distributed + v15;
            distribute_from_vault(arg1, arg0, v15, v1, false, arg5, arg6, arg7);
            let v24 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0);
            if (0x2::table::contains<address, Staker>(&v24.stakers, v1)) {
                let v25 = 0x2::table::borrow_mut<address, Staker>(&mut v24.stakers, v1);
                v25.rewards_claimed = v25.rewards_claimed + v15;
                v25.last_claim_timestamp = v3;
            };
            let v26 = RewardClaimed{
                staker    : v1,
                pool_type : v0,
                amount    : v15,
                timestamp : v3,
            };
            0x2::event::emit<RewardClaimed>(v26);
        };
        if (v22 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3.balance, v22), arg7), v1);
        };
        if (v21 > 0) {
            let v27 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3.balance, v21), arg7);
            let v28 = &mut v27;
            distribute_farm_fees<T0>(v4, v5, v6, v7, v8, v28, v20, v0, v3, arg7);
            0x2::coin::destroy_zero<T0>(v27);
            let v29 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0);
            v29.accumulated_withdrawal_fees = v29.accumulated_withdrawal_fees + v20;
            let v30 = FeesCollected{
                pool_type : v0,
                amount    : v20,
                fee_type  : 0x1::string::utf8(b"withdrawal"),
                timestamp : v3,
            };
            0x2::event::emit<FeesCollected>(v30);
        };
        arg3.amount = arg3.amount - arg4;
        if (arg4 == arg2.amount) {
            if (0x2::table::contains<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&arg0.user_positions, v1)) {
                let v31 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x1::type_name::TypeName, vector<0x2::object::ID>>>(&mut arg0.user_positions, v1);
                if (0x2::table::contains<0x1::type_name::TypeName, vector<0x2::object::ID>>(v31, v0)) {
                    let v32 = 0x2::table::borrow_mut<0x1::type_name::TypeName, vector<0x2::object::ID>>(v31, v0);
                    let v33 = 0;
                    let v34 = false;
                    while (v33 < 0x1::vector::length<0x2::object::ID>(v32) && !v34) {
                        if (*0x1::vector::borrow<0x2::object::ID>(v32, v33) == v2) {
                            0x1::vector::swap_remove<0x2::object::ID>(v32, v33);
                            v34 = true;
                            continue
                        };
                        v33 = v33 + 1;
                    };
                };
            };
            if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.position_to_vault, v2)) {
                0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.position_to_vault, v2);
            };
            let StakingPosition {
                id                      : v35,
                owner                   : _,
                pool_type               : _,
                amount                  : _,
                initial_stake_timestamp : _,
                vault_id                : _,
            } = arg2;
            0x2::object::delete(v35);
            if (0x2::balance::value<T0>(&arg3.balance) == 0) {
                arg3.owner = @0x0;
            };
        } else {
            arg2.amount = arg2.amount - arg4;
            0x2::transfer::transfer<StakingPosition<T0>>(arg2, v1);
        };
        let v41 = Unstaked{
            staker    : v1,
            pool_type : v0,
            amount    : arg4,
            timestamp : v3,
        };
        0x2::event::emit<Unstaked>(v41);
    }

    fun update_pool_accumulator_masterchef(arg0: &mut Pool, arg1: u256, arg2: u256, arg3: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg4: &0x2::clock::Clock, arg5: u64) {
        let v0 = get_emission_end_timestamp(arg3);
        let v1 = if (arg5 > v0) {
            v0
        } else {
            arg5
        };
        if (arg0.total_staked == 0) {
            arg0.last_reward_time = v1;
            return
        };
        if (v1 <= arg0.last_reward_time) {
            return
        };
        let v2 = arg0.last_reward_time;
        if (v1 <= v2) {
            arg0.last_reward_time = v1;
            return
        };
        let v3 = calculate_farm_rewards_multi_week(arg0.is_lp_token, arg0.allocation_points, arg1, arg2, arg3, v2, v1);
        if (v3 > 0) {
            arg0.acc_reward_per_share = arg0.acc_reward_per_share + safe_mul_div_u256(v3, 1000000000000000000, arg0.total_staked);
        };
        arg0.last_reward_time = v1;
    }

    public entry fun update_pool_config<T0>(arg0: &mut Farm, arg1: u256, arg2: u256, arg3: u256, arg4: bool, arg5: &AdminCap, arg6: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0), 5);
        assert!(arg2 <= 1000 && arg3 <= 1000, 3);
        let v1 = 0x2::clock::timestamp_ms(arg7) / 1000;
        arg0.last_update_timestamp = v1;
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0);
        let v3 = v2.deposit_fee;
        let v4 = v2.withdrawal_fee;
        let v5 = v2.active;
        update_pool_accumulator_masterchef(v2, arg0.total_lp_allocation_points, arg0.total_single_allocation_points, arg6, arg7, v1);
        let v6 = v2.allocation_points;
        arg0.total_allocation_points = arg0.total_allocation_points - v6 + arg1;
        if (v2.is_lp_token) {
            arg0.total_lp_allocation_points = arg0.total_lp_allocation_points - v6 + arg1;
        } else {
            arg0.total_single_allocation_points = arg0.total_single_allocation_points - v6 + arg1;
        };
        v2.allocation_points = arg1;
        v2.deposit_fee = arg2;
        v2.withdrawal_fee = arg3;
        v2.active = arg4;
        let v7 = PoolConfigUpdated{
            pool_type             : v0,
            old_allocation_points : v6,
            new_allocation_points : arg1,
            old_deposit_fee       : v3,
            new_deposit_fee       : arg2,
            old_withdrawal_fee    : v4,
            new_withdrawal_fee    : arg3,
            old_active            : v5,
            new_active            : arg4,
            timestamp             : v1,
        };
        0x2::event::emit<PoolConfigUpdated>(v7);
    }

    public entry fun update_single_pool<T0>(arg0: &mut Farm, arg1: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Pool>(&arg0.pools, v0), 5);
        let v1 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Pool>(&mut arg0.pools, v0);
        if (v2.active) {
            update_pool_accumulator_masterchef(v2, arg0.total_lp_allocation_points, arg0.total_single_allocation_points, arg1, arg2, v1);
            let v3 = PoolUpdated{
                pool_type : v0,
                timestamp : v1,
            };
            0x2::event::emit<PoolUpdated>(v3);
        };
    }

    fun validate_claim_allowed(arg0: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) {
        let (v0, _, v2) = validate_emission_state(arg0, arg1);
        assert!(v0, 16);
        assert!(!v2, 17);
    }

    fun validate_emission_state(arg0: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) : (bool, bool, bool) {
        let (v0, v1) = 0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::get_config_info(arg0);
        (v0 > 0, 0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::is_emissions_active(arg0, arg1), v1)
    }

    fun validate_new_stake_allowed(arg0: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) {
        let (v0, v1, v2) = validate_emission_state(arg0, arg1);
        assert!(v0, 16);
        assert!(v1, 18);
        assert!(!v2, 17);
    }

    fun validate_unstake_allowed(arg0: &0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::global_emission_controller::GlobalEmissionConfig, arg1: &0x2::clock::Clock) {
        let (v0, _, v2) = validate_emission_state(arg0, arg1);
        assert!(v0, 16);
        assert!(!v2, 17);
    }

    // decompiled from Move bytecode v6
}

