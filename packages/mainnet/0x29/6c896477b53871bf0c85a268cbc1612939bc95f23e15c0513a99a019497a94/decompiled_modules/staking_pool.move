module 0x296c896477b53871bf0c85a268cbc1612939bc95f23e15c0513a99a019497a94::staking_pool {
    struct StakingPool has key {
        id: 0x2::object::UID,
        owner: address,
        total_staked: 0x2::balance::Balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>,
        reward_pool: 0x2::balance::Balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>,
        stakers: 0x2::table::Table<address, StakerInfo>,
        total_stakers: u64,
        total_rewards_distributed: u128,
        reward_per_token_stored: u128,
        last_update_time: u64,
        total_rewards_added: u128,
        is_paused: bool,
        pause_timestamp: u64,
        pause_reason: vector<u8>,
        min_stake_duration_ms: u64,
        unclaimed_reward_dust: u128,
        reward_shortfall: u128,
        last_emergency_withdrawal: u64,
        critical_state: bool,
        reserved_rewards: u128,
    }

    struct StakerInfo has drop, store {
        amount_staked: u128,
        stake_start_time: u64,
        reward_per_token_paid: u128,
        rewards_earned: u128,
        min_duration_when_staked: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pending_transfer: 0x1::option::Option<PendingTransfer>,
        last_proposal_time: u64,
    }

    struct PendingTransfer has copy, drop, store {
        to: address,
        proposed_at: u64,
        ready_at: u64,
    }

    struct Staked has copy, drop {
        staker: address,
        amount: u128,
        total_staked: u128,
        reward_per_token: u128,
        timestamp: u64,
    }

    struct Unstaked has copy, drop {
        staker: address,
        amount: u128,
        rewards_claimed: u128,
        total_staked: u128,
        timestamp: u64,
    }

    struct RewardsClaimed has copy, drop {
        staker: address,
        amount: u128,
        timestamp: u64,
    }

    struct RewardsDeposited has copy, drop {
        amount: u128,
        reward_per_token_increase: u128,
        total_staked: u128,
        dust_accumulated: u128,
        timestamp: u64,
    }

    struct PoolPaused has copy, drop {
        reason: vector<u8>,
        timestamp: u64,
    }

    struct PoolUnpaused has copy, drop {
        timestamp: u64,
    }

    struct MinStakeDurationUpdated has copy, drop {
        old_duration: u64,
        new_duration: u64,
        timestamp: u64,
    }

    struct EmergencyWithdrawal has copy, drop {
        admin: address,
        amount: u64,
        timestamp: u64,
    }

    struct RewardShortfall has copy, drop {
        staker: address,
        expected: u128,
        received: u128,
        shortfall: u128,
        timestamp: u64,
    }

    struct DustSwept has copy, drop {
        amount: u128,
        method: vector<u8>,
        timestamp: u64,
    }

    struct AdminTransferProposed has copy, drop {
        from: address,
        to: address,
        ready_at: u64,
        timestamp: u64,
    }

    struct AdminTransferCancelled has copy, drop {
        from: address,
        to: address,
        timestamp: u64,
    }

    struct AdminTransferCompleted has copy, drop {
        from: address,
        to: address,
        timestamp: u64,
    }

    struct CircuitBreakerTriggered has copy, drop {
        reason: vector<u8>,
        reward_pool_balance: u128,
        reserved_rewards: u128,
        required_amount: u128,
        timestamp: u64,
    }

    struct RewardReserved has copy, drop {
        staker: address,
        amount: u128,
        total_reserved: u128,
        timestamp: u64,
    }

    struct RewardReleased has copy, drop {
        staker: address,
        amount: u128,
        total_reserved: u128,
        timestamp: u64,
    }

    struct BatchUpdateCompleted has copy, drop {
        total_addresses: u64,
        updated_count: u64,
        timestamp: u64,
    }

    struct CriticalStateReset has copy, drop {
        available_balance: u128,
        reserved_rewards: u128,
        timestamp: u64,
    }

    fun auto_sweep_dust_if_needed(arg0: &mut StakingPool, arg1: u64) {
        if (arg0.unclaimed_reward_dust >= 100000000) {
            let v0 = (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.total_staked) as u128);
            if (v0 > 0) {
                let v1 = arg0.unclaimed_reward_dust;
                let v2 = (v1 as u256) * (1000000000000000000 as u256) / (v0 as u256);
                if (v2 <= (340282366920938463463374607431768211455 as u256)) {
                    let v3 = (v2 as u128);
                    if (arg0.reward_per_token_stored + v3 <= 340282366920938463463374607431768211455) {
                        arg0.reward_per_token_stored = checked_add(arg0.reward_per_token_stored, v3);
                        let v4 = ((v2 * (v0 as u256) / (1000000000000000000 as u256)) as u128);
                        arg0.unclaimed_reward_dust = checked_sub(v1, v4);
                        let v5 = DustSwept{
                            amount    : v4,
                            method    : b"AUTO",
                            timestamp : arg1,
                        };
                        0x2::event::emit<DustSwept>(v5);
                    };
                };
            };
        };
    }

    public entry fun batch_update_rewards(arg0: &mut StakingPool, arg1: vector<address>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0, 9);
        assert!(v0 <= 100, 16);
        let v1 = 0x2::table::new<address, bool>(arg3);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<address>(&arg1, v3);
            assert!(!0x2::table::contains<address, bool>(&v1, *v4), 25);
            0x2::table::add<address, bool>(&mut v1, *v4, true);
            if (0x2::table::contains<address, StakerInfo>(&arg0.stakers, *v4)) {
                update_user_rewards(arg0, *v4);
                v2 = v2 + 1;
            };
            v3 = v3 + 1;
        };
        0x2::table::drop<address, bool>(v1);
        let v5 = BatchUpdateCompleted{
            total_addresses : v0,
            updated_count   : v2,
            timestamp       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<BatchUpdateCompleted>(v5);
    }

    public entry fun cancel_admin_transfer(arg0: &mut AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<PendingTransfer>(&arg0.pending_transfer), 21);
        let v0 = 0x1::option::extract<PendingTransfer>(&mut arg0.pending_transfer);
        let v1 = AdminTransferCancelled{
            from      : 0x2::tx_context::sender(arg2),
            to        : v0.to,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<AdminTransferCancelled>(v1);
    }

    fun checked_add(arg0: u128, arg1: u128) : u128 {
        let v0 = arg0 + arg1;
        assert!(v0 >= arg0 && v0 >= arg1, 11);
        v0
    }

    fun checked_sub(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 >= arg1, 2);
        arg0 - arg1
    }

    public entry fun claim_rewards(arg0: &mut StakingPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, StakerInfo>(&arg0.stakers, v0), 1);
        assert!(!arg0.critical_state, 23);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        update_user_rewards(arg0, v0);
        let v2 = 0x2::table::borrow<address, StakerInfo>(&arg0.stakers, v0).rewards_earned;
        if (v2 == 0) {
            let v3 = RewardsClaimed{
                staker    : v0,
                amount    : 0,
                timestamp : v1,
            };
            0x2::event::emit<RewardsClaimed>(v3);
            return
        };
        let v4 = if (v2 > 18446744073709551615) {
            0
        } else {
            (v2 as u64)
        };
        reserve_rewards(arg0, v2, v0, v1);
        0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.stakers, v0).rewards_earned = 0;
        arg0.total_rewards_distributed = checked_add(arg0.total_rewards_distributed, (v4 as u128));
        let v5 = 0x2::balance::split<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&mut arg0.reward_pool, v4);
        release_rewards(arg0, v2, v0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>>(0x2::coin::from_balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(v5, arg2), v0);
        let v6 = RewardsClaimed{
            staker    : v0,
            amount    : (v4 as u128),
            timestamp : v1,
        };
        0x2::event::emit<RewardsClaimed>(v6);
    }

    public entry fun complete_admin_transfer(arg0: AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<PendingTransfer>(&arg0.pending_transfer), 21);
        let v0 = *0x1::option::borrow<PendingTransfer>(&arg0.pending_transfer);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x2::tx_context::sender(arg2);
        assert!(v1 >= v0.ready_at, 20);
        assert!(v2 == v0.to, 22);
        let v3 = AdminCap{
            id                 : 0x2::object::new(arg2),
            pending_transfer   : 0x1::option::none<PendingTransfer>(),
            last_proposal_time : 0,
        };
        0x2::transfer::transfer<AdminCap>(v3, v0.to);
        let AdminCap {
            id                 : v4,
            pending_transfer   : _,
            last_proposal_time : _,
        } = arg0;
        0x2::object::delete(v4);
        let v7 = AdminTransferCompleted{
            from      : v2,
            to        : v0.to,
            timestamp : v1,
        };
        0x2::event::emit<AdminTransferCompleted>(v7);
    }

    public entry fun deposit_rewards(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>, arg2: &0x2::clock::Clock) {
        let v0 = (0x2::coin::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg1) as u128);
        assert!(v0 > 0, 9);
        assert!(v0 <= 333000000000000, 13);
        let v1 = (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.total_staked) as u128);
        let v2 = 0;
        let v3 = 0;
        if (v1 > 0) {
            let v4 = (v0 as u256) * (1000000000000000000 as u256);
            let v5 = v4 / (v1 as u256);
            let v6 = v5;
            assert!(v5 <= (340282366920938463463374607431768211455 as u256), 11);
            if (v4 % (v1 as u256) > 0) {
                let v7 = v5 + 1;
                assert!(v7 <= (340282366920938463463374607431768211455 as u256), 11);
                v6 = v7;
            };
            let v8 = (v6 as u128);
            v2 = v8;
            if (v8 == 0) {
                v3 = v0;
                arg0.unclaimed_reward_dust = checked_add(arg0.unclaimed_reward_dust, v0);
            } else {
                assert!(arg0.reward_per_token_stored + v8 <= 340282366920938463463374607431768211455, 11);
                let v9 = (v8 as u256) * (v1 as u256) / (1000000000000000000 as u256);
                if (v9 > (v0 as u256)) {
                    let v10 = ((v9 - (v0 as u256)) as u128);
                    v3 = v10;
                    arg0.unclaimed_reward_dust = checked_add(arg0.unclaimed_reward_dust, v10);
                };
                arg0.reward_per_token_stored = checked_add(arg0.reward_per_token_stored, v8);
            };
            assert!(v8 > 0, 24);
            assert!(arg0.reward_per_token_stored + v8 <= 340282366920938463463374607431768211455, 11);
            let v11 = (v8 as u256) * (v1 as u256) / (1000000000000000000 as u256);
            if (v11 > (v0 as u256)) {
                let v12 = ((v11 - (v0 as u256)) as u128);
                v3 = v12;
                arg0.unclaimed_reward_dust = checked_add(arg0.unclaimed_reward_dust, v12);
            };
            arg0.reward_per_token_stored = checked_add(arg0.reward_per_token_stored, v8);
        } else {
            v3 = v0;
            arg0.unclaimed_reward_dust = checked_add(arg0.unclaimed_reward_dust, v0);
        };
        arg0.total_rewards_added = checked_add(arg0.total_rewards_added, v0);
        0x2::balance::join<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&mut arg0.reward_pool, 0x2::coin::into_balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(arg1));
        let v13 = RewardsDeposited{
            amount                    : v0,
            reward_per_token_increase : v2,
            total_staked              : v1,
            dust_accumulated          : v3,
            timestamp                 : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RewardsDeposited>(v13);
    }

    public entry fun emergency_withdraw_rewards(arg0: &AdminCap, arg1: &mut StakingPool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (arg1.last_emergency_withdrawal > 0) {
            assert!(v0 - arg1.last_emergency_withdrawal >= 86400000, 19);
        };
        assert!(arg2 > 0, 9);
        let v1 = 0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg1.reward_pool);
        assert!(v1 >= arg2, 6);
        assert!(arg2 <= (((v1 as u128) * 10 / 100) as u64), 13);
        arg1.last_emergency_withdrawal = v0;
        let v2 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>>(0x2::coin::from_balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(0x2::balance::split<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&mut arg1.reward_pool, arg2), arg4), v2);
        let v3 = EmergencyWithdrawal{
            admin     : v2,
            amount    : arg2,
            timestamp : v0,
        };
        0x2::event::emit<EmergencyWithdrawal>(v3);
    }

    public fun get_available_rewards(arg0: &StakingPool) : u128 {
        let v0 = (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.reward_pool) as u128);
        if (v0 > arg0.reserved_rewards) {
            v0 - arg0.reserved_rewards
        } else {
            0
        }
    }

    public fun get_health_dashboard(arg0: &StakingPool) : (u128, u128, u64, u128, u128, u128, u128, bool, u128) {
        let (v0, v1) = verify_pool_integrity(arg0);
        ((0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.total_staked) as u128), (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.reward_pool) as u128), arg0.total_stakers, arg0.reward_per_token_stored, arg0.unclaimed_reward_dust, arg0.reward_shortfall, arg0.reserved_rewards, v0, v1)
    }

    public fun get_pool_stats(arg0: &StakingPool) : (u128, u128, u64, u128, u128, bool, u64, u128, u128, u128) {
        ((0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.total_staked) as u128), (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.reward_pool) as u128), arg0.total_stakers, arg0.total_rewards_distributed, arg0.total_rewards_added, arg0.is_paused, arg0.min_stake_duration_ms, arg0.unclaimed_reward_dust, arg0.reward_shortfall, arg0.reserved_rewards)
    }

    public fun get_reward_pool_balance(arg0: &StakingPool) : u128 {
        (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.reward_pool) as u128)
    }

    public fun get_staked_amount(arg0: &StakingPool, arg1: address) : u128 {
        if (!0x2::table::contains<address, StakerInfo>(&arg0.stakers, arg1)) {
            return 0
        };
        0x2::table::borrow<address, StakerInfo>(&arg0.stakers, arg1).amount_staked
    }

    public fun get_time_until_unstake(arg0: &StakingPool, arg1: address, arg2: u64) : u64 {
        if (!0x2::table::contains<address, StakerInfo>(&arg0.stakers, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, StakerInfo>(&arg0.stakers, arg1);
        let v1 = v0.stake_start_time + v0.min_duration_when_staked;
        if (arg2 >= v1) {
            0
        } else {
            v1 - arg2
        }
    }

    public fun get_total_pending_rewards(arg0: &StakingPool, arg1: address) : u128 {
        if (!0x2::table::contains<address, StakerInfo>(&arg0.stakers, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, StakerInfo>(&arg0.stakers, arg1);
        let v1 = (v0.rewards_earned as u256) + (update_user_rewards_dry_run(arg0, v0) as u256);
        if (v1 > (340282366920938463463374607431768211455 as u256)) {
            340282366920938463463374607431768211455
        } else {
            (v1 as u128)
        }
    }

    public fun get_total_staked(arg0: &StakingPool) : u128 {
        (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.total_staked) as u128)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = StakingPool{
            id                        : 0x2::object::new(arg0),
            owner                     : v0,
            total_staked              : 0x2::balance::zero<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(),
            reward_pool               : 0x2::balance::zero<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(),
            stakers                   : 0x2::table::new<address, StakerInfo>(arg0),
            total_stakers             : 0,
            total_rewards_distributed : 0,
            reward_per_token_stored   : 0,
            last_update_time          : 0,
            total_rewards_added       : 0,
            is_paused                 : false,
            pause_timestamp           : 0,
            pause_reason              : 0x1::vector::empty<u8>(),
            min_stake_duration_ms     : 259200000,
            unclaimed_reward_dust     : 0,
            reward_shortfall          : 0,
            last_emergency_withdrawal : 0,
            critical_state            : false,
            reserved_rewards          : 0,
        };
        0x2::transfer::share_object<StakingPool>(v1);
        let v2 = AdminCap{
            id                 : 0x2::object::new(arg0),
            pending_transfer   : 0x1::option::none<PendingTransfer>(),
            last_proposal_time : 0,
        };
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    fun mul_div_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 10);
        assert!(arg0 <= 340282366920938463463374607431768211455, 11);
        assert!(arg1 <= 340282366920938463463374607431768211455, 11);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= (340282366920938463463374607431768211455 as u256), 11);
        (v0 as u128)
    }

    public entry fun pause_pool(arg0: &AdminCap, arg1: &mut StakingPool, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg1.is_paused = true;
        arg1.pause_timestamp = v0;
        arg1.pause_reason = arg2;
        let v1 = PoolPaused{
            reason    : arg2,
            timestamp : v0,
        };
        0x2::event::emit<PoolPaused>(v1);
    }

    public entry fun propose_admin_transfer(arg0: &mut AdminCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0.last_proposal_time > 0) {
            assert!(v0 - arg0.last_proposal_time >= 172800000, 19);
        };
        arg0.last_proposal_time = v0;
        let v1 = v0 + 172800000;
        let v2 = PendingTransfer{
            to          : arg1,
            proposed_at : v0,
            ready_at    : v1,
        };
        0x1::option::fill<PendingTransfer>(&mut arg0.pending_transfer, v2);
        let v3 = AdminTransferProposed{
            from      : 0x2::tx_context::sender(arg3),
            to        : arg1,
            ready_at  : v1,
            timestamp : v0,
        };
        0x2::event::emit<AdminTransferProposed>(v3);
    }

    fun release_rewards(arg0: &mut StakingPool, arg1: u128, arg2: address, arg3: u64) {
        arg0.reserved_rewards = checked_sub(arg0.reserved_rewards, arg1);
        let v0 = RewardReleased{
            staker         : arg2,
            amount         : arg1,
            total_reserved : arg0.reserved_rewards,
            timestamp      : arg3,
        };
        0x2::event::emit<RewardReleased>(v0);
    }

    fun reserve_rewards(arg0: &mut StakingPool, arg1: u128, arg2: address, arg3: u64) {
        let v0 = (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.reward_pool) as u128);
        let v1 = checked_sub(v0, arg0.reserved_rewards);
        if (v1 < arg1) {
            let v2 = arg1 - v1;
            arg0.reward_shortfall = checked_add(arg0.reward_shortfall, v2);
            arg0.critical_state = true;
            let v3 = CircuitBreakerTriggered{
                reason              : b"INSUFFICIENT_UNRESERVED_REWARDS",
                reward_pool_balance : v0,
                reserved_rewards    : arg0.reserved_rewards,
                required_amount     : arg1,
                timestamp           : arg3,
            };
            0x2::event::emit<CircuitBreakerTriggered>(v3);
            let v4 = RewardShortfall{
                staker    : arg2,
                expected  : arg1,
                received  : v1,
                shortfall : v2,
                timestamp : arg3,
            };
            0x2::event::emit<RewardShortfall>(v4);
            abort 23
        };
        arg0.reserved_rewards = checked_add(arg0.reserved_rewards, arg1);
        let v5 = RewardReserved{
            staker         : arg2,
            amount         : arg1,
            total_reserved : arg0.reserved_rewards,
            timestamp      : arg3,
        };
        0x2::event::emit<RewardReserved>(v5);
    }

    public entry fun reset_critical_state(arg0: &AdminCap, arg1: &mut StakingPool, arg2: &0x2::clock::Clock) {
        assert!(arg1.is_paused, 27);
        let v0 = (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg1.reward_pool) as u128);
        assert!(v0 >= arg1.reserved_rewards + arg1.reserved_rewards / 10, 6);
        arg1.critical_state = false;
        let v1 = CriticalStateReset{
            available_balance : v0,
            reserved_rewards  : arg1.reserved_rewards,
            timestamp         : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CriticalStateReset>(v1);
    }

    public entry fun stake(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 8);
        let v0 = (0x2::coin::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg1) as u128);
        assert!(v0 > 0, 5);
        assert!(v0 >= 1000000, 12);
        assert!(v0 <= 100000000000000, 13);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        if (0x2::table::contains<address, StakerInfo>(&arg0.stakers, v1)) {
            update_user_rewards(arg0, v1);
            let v3 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.stakers, v1);
            assert!(v3.amount_staked + v0 <= 340282366920938463463374607431768211455, 11);
            v3.amount_staked = checked_add(v3.amount_staked, v0);
        } else {
            let v4 = StakerInfo{
                amount_staked            : v0,
                stake_start_time         : v2,
                reward_per_token_paid    : arg0.reward_per_token_stored,
                rewards_earned           : 0,
                min_duration_when_staked : arg0.min_stake_duration_ms,
            };
            0x2::table::add<address, StakerInfo>(&mut arg0.stakers, v1, v4);
            arg0.total_stakers = arg0.total_stakers + 1;
        };
        0x2::balance::join<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&mut arg0.total_staked, 0x2::coin::into_balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(arg1));
        let v5 = (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.total_staked) as u128);
        auto_sweep_dust_if_needed(arg0, v2);
        let v6 = Staked{
            staker           : v1,
            amount           : v0,
            total_staked     : v5,
            reward_per_token : arg0.reward_per_token_stored,
            timestamp        : v2,
        };
        0x2::event::emit<Staked>(v6);
    }

    public entry fun sweep_dust_to_reward_pool(arg0: &AdminCap, arg1: &mut StakingPool, arg2: u64, arg3: 0x2::coin::Coin<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>, arg4: &0x2::clock::Clock) {
        assert!(arg2 > 0, 9);
        assert!(0x2::coin::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg3) == arg2, 9);
        assert!(arg1.unclaimed_reward_dust >= (arg2 as u128), 6);
        0x2::balance::join<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&mut arg1.reward_pool, 0x2::coin::into_balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(arg3));
        arg1.unclaimed_reward_dust = checked_sub(arg1.unclaimed_reward_dust, (arg2 as u128));
        let v0 = DustSwept{
            amount    : (arg2 as u128),
            method    : b"MANUAL",
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DustSwept>(v0);
    }

    public entry fun unpause_pool(arg0: &AdminCap, arg1: &mut StakingPool, arg2: &0x2::clock::Clock) {
        arg1.is_paused = false;
        arg1.pause_reason = 0x1::vector::empty<u8>();
        let v0 = PoolUnpaused{timestamp: 0x2::clock::timestamp_ms(arg2)};
        0x2::event::emit<PoolUnpaused>(v0);
    }

    public entry fun unstake(arg0: &mut StakingPool, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 8);
        assert!(!arg0.critical_state, 23);
        assert!(arg1 > 0, 9);
        let v0 = (arg1 as u128);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x2::table::contains<address, StakerInfo>(&arg0.stakers, v1), 1);
        let v3 = 0x2::table::borrow<address, StakerInfo>(&arg0.stakers, v1);
        assert!(v2 >= v3.stake_start_time + v3.min_duration_when_staked, 3);
        assert!(v3.amount_staked >= v0, 2);
        update_user_rewards(arg0, v1);
        let v4 = 0x2::table::borrow<address, StakerInfo>(&arg0.stakers, v1).rewards_earned;
        let v5 = if (v4 > 18446744073709551615) {
            0
        } else {
            (v4 as u64)
        };
        if (v5 > 0) {
            reserve_rewards(arg0, v4, v1, v2);
        };
        let v6 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.stakers, v1);
        v6.amount_staked = checked_sub(v6.amount_staked, v0);
        v6.rewards_earned = 0;
        arg0.total_rewards_distributed = checked_add(arg0.total_rewards_distributed, (v5 as u128));
        if (v6.amount_staked == 0) {
            0x2::table::remove<address, StakerInfo>(&mut arg0.stakers, v1);
            arg0.total_stakers = arg0.total_stakers - 1;
        };
        let v7 = 0x2::balance::split<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&mut arg0.total_staked, arg1);
        let v8 = (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.total_staked) as u128);
        if (v5 > 0) {
            let v9 = 0x2::balance::split<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&mut arg0.reward_pool, v5);
            release_rewards(arg0, v4, v1, v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>>(0x2::coin::from_balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(v7, arg3), v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>>(0x2::coin::from_balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(v9, arg3), v1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>>(0x2::coin::from_balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(v7, arg3), v1);
        };
        let v10 = Unstaked{
            staker          : v1,
            amount          : v0,
            rewards_claimed : (v5 as u128),
            total_staked    : v8,
            timestamp       : v2,
        };
        0x2::event::emit<Unstaked>(v10);
    }

    public entry fun update_min_stake_duration(arg0: &AdminCap, arg1: &mut StakingPool, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg2 > 0, 15);
        assert!(arg2 <= 31536000000, 15);
        if (arg2 > arg1.min_stake_duration_ms) {
            assert!(arg2 - arg1.min_stake_duration_ms <= 604800000, 26);
        };
        arg1.min_stake_duration_ms = arg2;
        let v0 = MinStakeDurationUpdated{
            old_duration : arg1.min_stake_duration_ms,
            new_duration : arg2,
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MinStakeDurationUpdated>(v0);
    }

    fun update_user_rewards(arg0: &mut StakingPool, arg1: address) {
        let v0 = 0x2::table::borrow_mut<address, StakerInfo>(&mut arg0.stakers, arg1);
        if (v0.reward_per_token_paid >= arg0.reward_per_token_stored) {
            return
        };
        let v1 = (v0.amount_staked as u256) * ((arg0.reward_per_token_stored - v0.reward_per_token_paid) as u256);
        let v2 = v1 / (1000000000000000000 as u256);
        let v3 = v2;
        assert!(v2 <= (340282366920938463463374607431768211455 as u256), 11);
        if (v1 % (1000000000000000000 as u256) > 0) {
            let v4 = v2 + 1;
            assert!(v4 <= (340282366920938463463374607431768211455 as u256), 11);
            v3 = v4;
        };
        let v5 = (v3 as u128);
        assert!(v0.rewards_earned + v5 <= 340282366920938463463374607431768211455, 11);
        v0.rewards_earned = checked_add(v0.rewards_earned, v5);
        v0.reward_per_token_paid = arg0.reward_per_token_stored;
    }

    fun update_user_rewards_dry_run(arg0: &StakingPool, arg1: &StakerInfo) : u128 {
        if (arg1.reward_per_token_paid >= arg0.reward_per_token_stored) {
            return 0
        };
        let v0 = (arg1.amount_staked as u256) * ((arg0.reward_per_token_stored - arg1.reward_per_token_paid) as u256);
        let v1 = v0 / (1000000000000000000 as u256);
        let v2 = v1;
        if (v1 > (340282366920938463463374607431768211455 as u256)) {
            return 0
        };
        if (v0 % (1000000000000000000 as u256) > 0) {
            let v3 = v1 + 1;
            if (v3 > (340282366920938463463374607431768211455 as u256)) {
                return (v1 as u128)
            };
            v2 = v3;
        };
        (v2 as u128)
    }

    public fun verify_pool_integrity(arg0: &StakingPool) : (bool, u128) {
        let v0 = (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.total_staked) as u128) + (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.reward_pool) as u128) + arg0.total_rewards_distributed + arg0.reward_shortfall;
        let v1 = if (v0 > arg0.total_rewards_added) {
            v0 - arg0.total_rewards_added
        } else {
            0
        };
        (v0 <= arg0.total_rewards_added, v1)
    }

    // decompiled from Move bytecode v6
}

