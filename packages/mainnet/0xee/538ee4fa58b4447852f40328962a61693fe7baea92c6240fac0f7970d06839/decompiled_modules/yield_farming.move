module 0xee538ee4fa58b4447852f40328962a61693fe7baea92c6240fac0f7970d06839::yield_farming {
    struct GasYieldPool has key {
        id: 0x2::object::UID,
        pool_name: 0x1::string::String,
        staked_gas_credits: u64,
        total_participants: u64,
        reward_rate: u64,
        farming_duration: u64,
        pool_start_time: u64,
        pool_end_time: u64,
        participants: 0x2::table::Table<address, StakeInfo>,
        reward_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        emergency_withdrawal_enabled: bool,
        pool_admin: address,
        total_rewards_distributed: u64,
        compounding_enabled: bool,
    }

    struct StakeInfo has drop, store {
        staked_amount: u64,
        stake_timestamp: u64,
        last_reward_calculation: u64,
        pending_rewards: u64,
        volume_bonus_tier: u8,
        lock_end_time: u64,
        auto_compound: bool,
        total_rewards_earned: u64,
    }

    struct YieldFarmingRegistry has key {
        id: 0x2::object::UID,
        active_pools: 0x2::table::Table<u64, 0x2::object::ID>,
        pool_counter: u64,
        total_staked_across_pools: u64,
        total_rewards_distributed: u64,
        governance_fee_rate: u64,
        admin: address,
    }

    struct LiquidityMiningReward has store, key {
        id: 0x2::object::UID,
        pool_id: u64,
        recipient: address,
        reward_amount: u64,
        earned_timestamp: u64,
        reward_type: u8,
        claimed: bool,
    }

    struct CompoundStrategy has key {
        id: 0x2::object::UID,
        strategy_name: 0x1::string::String,
        pools: vector<u64>,
        pool_weights: vector<u64>,
        rebalance_frequency: u64,
        last_rebalance: u64,
        total_managed_amount: u64,
        performance_fee: u64,
        strategy_manager: address,
    }

    struct CrossChainYield has key {
        id: 0x2::object::UID,
        target_chain: 0x1::string::String,
        protocol_name: 0x1::string::String,
        estimated_apy: u64,
        risk_level: u8,
        required_bridge_fee: u64,
        minimum_deposit: u64,
        active: bool,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        pool_name: 0x1::string::String,
        reward_rate: u64,
        farming_duration: u64,
        admin: address,
    }

    struct GasStaked has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        lock_end_time: u64,
        expected_rewards: u64,
    }

    struct RewardsClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        reward_amount: u64,
        auto_compounded: bool,
        timestamp: u64,
    }

    struct EmergencyWithdrawal has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        penalty_applied: u64,
        timestamp: u64,
    }

    struct StrategyCreated has copy, drop {
        strategy_id: 0x2::object::ID,
        strategy_name: 0x1::string::String,
        pools_count: u64,
        manager: address,
        performance_fee: u64,
    }

    struct CrossChainBridged has copy, drop {
        user: address,
        amount: u64,
        target_chain: vector<u8>,
        bridge_fee: u64,
        estimated_yield: u64,
    }

    struct RewardMinted has copy, drop {
        recipient: address,
        pool_id: u64,
        reward_amount: u64,
        reward_type: u8,
        timestamp: u64,
    }

    public entry fun bridge_to_cross_chain(arg0: &CrossChainYield, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 3);
        assert!(arg1 >= arg0.minimum_deposit, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.required_bridge_fee, 5);
        0x2::clock::timestamp_ms(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x0);
        let v0 = CrossChainBridged{
            user            : 0x2::tx_context::sender(arg4),
            amount          : arg1,
            target_chain    : *0x1::string::bytes(&arg0.target_chain),
            bridge_fee      : arg0.required_bridge_fee,
            estimated_yield : arg1 * arg0.estimated_apy / 10000,
        };
        0x2::event::emit<CrossChainBridged>(v0);
    }

    fun calculate_accumulated_rewards(arg0: &StakeInfo, arg1: &GasYieldPool, arg2: u64) : u64 {
        let v0 = arg0.staked_amount * arg1.reward_rate * (arg2 - arg0.last_reward_calculation) / 315360000000000;
        let v1 = if (arg0.volume_bonus_tier == 3) {
            500
        } else if (arg0.volume_bonus_tier == 2) {
            250
        } else if (arg0.volume_bonus_tier == 1) {
            100
        } else {
            0
        };
        v0 + v0 * v1 / 10000 + arg0.pending_rewards
    }

    public fun calculate_current_apy(arg0: &GasYieldPool, arg1: u8) : u64 {
        let v0 = if (arg1 == 3) {
            500
        } else if (arg1 == 2) {
            250
        } else if (arg1 == 1) {
            100
        } else {
            0
        };
        arg0.reward_rate + v0
    }

    fun calculate_expected_rewards(arg0: u64, arg1: u64, arg2: u64, arg3: u8) : u64 {
        let v0 = arg0 * arg1 * arg2 / 315360000000000;
        let v1 = if (arg3 == 3) {
            500
        } else if (arg3 == 2) {
            250
        } else if (arg3 == 1) {
            100
        } else {
            0
        };
        v0 + v0 * v1 / 10000
    }

    fun calculate_volume_tier(arg0: &YieldFarmingRegistry, arg1: address) : u8 {
        let v0 = 1000000;
        if (v0 >= 10000000) {
            3
        } else if (v0 >= 5000000) {
            2
        } else if (v0 >= 1000000) {
            1
        } else {
            0
        }
    }

    public entry fun claim_rewards(arg0: &mut YieldFarmingRegistry, arg1: &mut GasYieldPool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, StakeInfo>(&arg1.participants, v1), 1);
        let v2 = calculate_accumulated_rewards(0x2::table::borrow<address, StakeInfo>(&arg1.participants, v1), arg1, v0);
        assert!(v2 > 0, 5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.reward_balance) >= v2, 5);
        let v3 = 0x2::table::borrow_mut<address, StakeInfo>(&mut arg1.participants, v1);
        v3.pending_rewards = 0;
        v3.last_reward_calculation = v0;
        v3.total_rewards_earned = v3.total_rewards_earned + v2;
        let v4 = v2 - v2 * arg0.governance_fee_rate / 10000;
        if (v3.auto_compound && arg1.compounding_enabled) {
            v3.staked_amount = v3.staked_amount + v4;
            arg1.staked_gas_credits = arg1.staked_gas_credits + v4;
            let v5 = RewardsClaimed{
                pool_id         : 0x2::object::uid_to_inner(&arg1.id),
                user            : v1,
                reward_amount   : v4,
                auto_compounded : true,
                timestamp       : v0,
            };
            0x2::event::emit<RewardsClaimed>(v5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.reward_balance, v4, arg3), v1);
            let v6 = RewardsClaimed{
                pool_id         : 0x2::object::uid_to_inner(&arg1.id),
                user            : v1,
                reward_amount   : v4,
                auto_compounded : false,
                timestamp       : v0,
            };
            0x2::event::emit<RewardsClaimed>(v6);
        };
        arg1.total_rewards_distributed = arg1.total_rewards_distributed + v2;
        arg0.total_rewards_distributed = arg0.total_rewards_distributed + v2;
    }

    public entry fun create_compound_strategy(arg0: vector<u8>, arg1: vector<u64>, arg2: vector<u64>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<u64>(&arg2), 7);
        let v0 = CompoundStrategy{
            id                   : 0x2::object::new(arg5),
            strategy_name        : 0x1::string::utf8(arg0),
            pools                : arg1,
            pool_weights         : arg2,
            rebalance_frequency  : arg3,
            last_rebalance       : 0,
            total_managed_amount : 0,
            performance_fee      : arg4,
            strategy_manager     : 0x2::tx_context::sender(arg5),
        };
        let v1 = StrategyCreated{
            strategy_id     : 0x2::object::uid_to_inner(&v0.id),
            strategy_name   : v0.strategy_name,
            pools_count     : 0x1::vector::length<u64>(&arg1),
            manager         : 0x2::tx_context::sender(arg5),
            performance_fee : arg4,
        };
        0x2::event::emit<StrategyCreated>(v1);
        0x2::transfer::transfer<CompoundStrategy>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun create_cross_chain_yield(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = CrossChainYield{
            id                  : 0x2::object::new(arg6),
            target_chain        : 0x1::string::utf8(arg0),
            protocol_name       : 0x1::string::utf8(arg1),
            estimated_apy       : arg2,
            risk_level          : arg3,
            required_bridge_fee : arg4,
            minimum_deposit     : arg5,
            active              : true,
        };
        0x2::transfer::transfer<CrossChainYield>(v0, 0x2::tx_context::sender(arg6));
    }

    public entry fun create_liquidity_reward(arg0: u64, arg1: address, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = LiquidityMiningReward{
            id               : 0x2::object::new(arg5),
            pool_id          : arg0,
            recipient        : arg1,
            reward_amount    : arg2,
            earned_timestamp : v0,
            reward_type      : arg3,
            claimed          : false,
        };
        let v2 = RewardMinted{
            recipient     : arg1,
            pool_id       : arg0,
            reward_amount : arg2,
            reward_type   : arg3,
            timestamp     : v0,
        };
        0x2::event::emit<RewardMinted>(v2);
        0x2::transfer::transfer<LiquidityMiningReward>(v1, arg1);
    }

    public entry fun create_yield_pool(arg0: &mut YieldFarmingRegistry, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg7), 3);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        arg0.pool_counter = arg0.pool_counter + 1;
        let v1 = GasYieldPool{
            id                           : 0x2::object::new(arg7),
            pool_name                    : 0x1::string::utf8(arg1),
            staked_gas_credits           : 0,
            total_participants           : 0,
            reward_rate                  : arg2,
            farming_duration             : arg3,
            pool_start_time              : v0,
            pool_end_time                : v0 + arg3,
            participants                 : 0x2::table::new<address, StakeInfo>(arg7),
            reward_balance               : 0x2::coin::into_balance<0x2::sui::SUI>(arg4),
            emergency_withdrawal_enabled : false,
            pool_admin                   : 0x2::tx_context::sender(arg7),
            total_rewards_distributed    : 0,
            compounding_enabled          : arg5,
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.active_pools, arg0.pool_counter, v2);
        let v3 = PoolCreated{
            pool_id          : v2,
            pool_name        : v1.pool_name,
            reward_rate      : arg2,
            farming_duration : arg3,
            admin            : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<PoolCreated>(v3);
        0x2::transfer::share_object<GasYieldPool>(v1);
    }

    public entry fun emergency_withdraw(arg0: &mut GasYieldPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.emergency_withdrawal_enabled, 3);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, StakeInfo>(&arg0.participants, v0), 1);
        let v1 = 0x2::table::remove<address, StakeInfo>(&mut arg0.participants, v0);
        let v2 = v1.staked_amount * 2000 / 10000;
        arg0.staked_gas_credits = arg0.staked_gas_credits - v1.staked_amount;
        arg0.total_participants = arg0.total_participants - 1;
        let v3 = EmergencyWithdrawal{
            pool_id         : 0x2::object::uid_to_inner(&arg0.id),
            user            : v0,
            amount          : v1.staked_amount - v2,
            penalty_applied : v2,
            timestamp       : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<EmergencyWithdrawal>(v3);
    }

    public fun get_cross_chain_info(arg0: &CrossChainYield) : (0x1::string::String, 0x1::string::String, u64, u8, u64, bool) {
        (arg0.target_chain, arg0.protocol_name, arg0.estimated_apy, arg0.risk_level, arg0.minimum_deposit, arg0.active)
    }

    public fun get_farming_stats(arg0: &YieldFarmingRegistry) : (u64, u64, u64) {
        (arg0.pool_counter, arg0.total_staked_across_pools, arg0.total_rewards_distributed)
    }

    public fun get_pool_info(arg0: &GasYieldPool) : (0x1::string::String, u64, u64, u64, u64, u64, bool) {
        (arg0.pool_name, arg0.staked_gas_credits, arg0.total_participants, arg0.reward_rate, arg0.pool_start_time, arg0.pool_end_time, arg0.compounding_enabled)
    }

    public fun get_stake_info(arg0: &GasYieldPool, arg1: address) : (u64, u64, u64, u64, u8, bool) {
        if (0x2::table::contains<address, StakeInfo>(&arg0.participants, arg1)) {
            let v6 = 0x2::table::borrow<address, StakeInfo>(&arg0.participants, arg1);
            (v6.staked_amount, v6.stake_timestamp, v6.pending_rewards, v6.lock_end_time, v6.volume_bonus_tier, v6.auto_compound)
        } else {
            (0, 0, 0, 0, 0, false)
        }
    }

    public fun get_strategy_info(arg0: &CompoundStrategy) : (0x1::string::String, vector<u64>, vector<u64>, u64, address) {
        (arg0.strategy_name, arg0.pools, arg0.pool_weights, arg0.performance_fee, arg0.strategy_manager)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = YieldFarmingRegistry{
            id                        : 0x2::object::new(arg0),
            active_pools              : 0x2::table::new<u64, 0x2::object::ID>(arg0),
            pool_counter              : 0,
            total_staked_across_pools : 0,
            total_rewards_distributed : 0,
            governance_fee_rate       : 1000,
            admin                     : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<YieldFarmingRegistry>(v0);
    }

    public entry fun stake_gas_credits(arg0: &mut YieldFarmingRegistry, arg1: &mut GasYieldPool, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 < arg1.pool_end_time, 4);
        assert!(arg2 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = v0 + arg1.farming_duration;
        let v3 = calculate_volume_tier(arg0, v1);
        if (0x2::table::contains<address, StakeInfo>(&arg1.participants, v1)) {
            let v4 = 0x2::table::borrow_mut<address, StakeInfo>(&mut arg1.participants, v1);
            v4.staked_amount = v4.staked_amount + arg2;
            v4.volume_bonus_tier = v3;
            v4.auto_compound = arg3;
        } else {
            let v5 = StakeInfo{
                staked_amount           : arg2,
                stake_timestamp         : v0,
                last_reward_calculation : v0,
                pending_rewards         : 0,
                volume_bonus_tier       : v3,
                lock_end_time           : v2,
                auto_compound           : arg3,
                total_rewards_earned    : 0,
            };
            0x2::table::add<address, StakeInfo>(&mut arg1.participants, v1, v5);
            arg1.total_participants = arg1.total_participants + 1;
        };
        arg1.staked_gas_credits = arg1.staked_gas_credits + arg2;
        arg0.total_staked_across_pools = arg0.total_staked_across_pools + arg2;
        let v6 = GasStaked{
            pool_id          : 0x2::object::uid_to_inner(&arg1.id),
            user             : v1,
            amount           : arg2,
            lock_end_time    : v2,
            expected_rewards : calculate_expected_rewards(arg2, arg1.reward_rate, arg1.farming_duration, v3),
        };
        0x2::event::emit<GasStaked>(v6);
    }

    // decompiled from Move bytecode v6
}

