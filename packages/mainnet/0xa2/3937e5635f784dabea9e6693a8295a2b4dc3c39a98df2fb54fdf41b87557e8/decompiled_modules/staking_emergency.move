module 0xa23937e5635f784dabea9e6693a8295a2b4dc3c39a98df2fb54fdf41b87557e8::staking_emergency {
    struct BOSU has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EmergencyCapability has store, key {
        id: 0x2::object::UID,
    }

    struct StakingPool has key {
        id: 0x2::object::UID,
        admin: address,
        lock_period_days: u64,
        daily_reward_rate: u64,
        early_unstake_penalty: u64,
        total_staked: u64,
        reward_pool: 0x2::balance::Balance<BOSU>,
        stake_balance: 0x2::balance::Balance<BOSU>,
        stakes: 0x2::table::Table<address, UserStake>,
        is_emergency: bool,
    }

    struct UserStake has drop, store {
        amount: u64,
        stake_time: u64,
        last_claim_time: u64,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: address,
        admin: address,
        lock_period_days: u64,
        daily_reward_rate: u64,
        early_unstake_penalty: u64,
    }

    struct StakeEvent has copy, drop {
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct UnstakeEvent has copy, drop {
        user: address,
        amount: u64,
        penalty: u64,
        timestamp: u64,
    }

    struct ClaimEvent has copy, drop {
        user: address,
        rewards: u64,
        timestamp: u64,
    }

    struct EmergencyWithdrawEvent has copy, drop {
        admin: address,
        amount: u64,
        timestamp: u64,
    }

    public entry fun add_rewards(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<BOSU>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        0x2::balance::join<BOSU>(&mut arg0.reward_pool, 0x2::coin::into_balance<BOSU>(arg1));
    }

    public entry fun claim_rewards(arg0: &mut StakingPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, UserStake>(&arg0.stakes, v0), 2);
        let v1 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.stakes, v0);
        let v2 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v3 = v2 - v1.last_claim_time;
        if (v3 > 0) {
            let v4 = v1.amount * arg0.daily_reward_rate / 10000 * v3 / 86400;
            if (v4 > 0 && v4 <= 0x2::balance::value<BOSU>(&arg0.reward_pool)) {
                v1.last_claim_time = v2;
                0x2::transfer::public_transfer<0x2::coin::Coin<BOSU>>(0x2::coin::from_balance<BOSU>(0x2::balance::split<BOSU>(&mut arg0.reward_pool, v4), arg2), v0);
                let v5 = ClaimEvent{
                    user      : v0,
                    rewards   : v4,
                    timestamp : v2,
                };
                0x2::event::emit<ClaimEvent>(v5);
            };
        };
    }

    public entry fun create_pool_with_emergency(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg5)};
        let v1 = EmergencyCapability{id: 0x2::object::new(arg5)};
        let v2 = StakingPool{
            id                    : 0x2::object::new(arg5),
            admin                 : arg0,
            lock_period_days      : arg1,
            daily_reward_rate     : arg2,
            early_unstake_penalty : arg3,
            total_staked          : 0,
            reward_pool           : 0x2::balance::zero<BOSU>(),
            stake_balance         : 0x2::balance::zero<BOSU>(),
            stakes                : 0x2::table::new<address, UserStake>(arg5),
            is_emergency          : false,
        };
        let v3 = PoolCreatedEvent{
            pool_id               : 0x2::object::uid_to_address(&v2.id),
            admin                 : arg0,
            lock_period_days      : arg1,
            daily_reward_rate     : arg2,
            early_unstake_penalty : arg3,
        };
        0x2::event::emit<PoolCreatedEvent>(v3);
        0x2::transfer::public_transfer<AdminCap>(v0, arg0);
        0x2::transfer::public_transfer<EmergencyCapability>(v1, arg0);
        0x2::transfer::share_object<StakingPool>(v2);
    }

    public entry fun disable_emergency_mode(arg0: &mut StakingPool, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        arg0.is_emergency = false;
    }

    public entry fun emergency_withdraw(arg0: &mut StakingPool, arg1: &EmergencyCapability, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 3);
        let v0 = 0x2::balance::value<BOSU>(&arg0.stake_balance);
        let v1 = if (arg2 > v0) {
            v0
        } else {
            arg2
        };
        if (v1 > 0) {
            arg0.is_emergency = true;
            0x2::transfer::public_transfer<0x2::coin::Coin<BOSU>>(0x2::coin::from_balance<BOSU>(0x2::balance::split<BOSU>(&mut arg0.stake_balance, v1), arg4), 0x2::tx_context::sender(arg4));
            let v2 = EmergencyWithdrawEvent{
                admin     : 0x2::tx_context::sender(arg4),
                amount    : v1,
                timestamp : 0x2::clock::timestamp_ms(arg3) / 1000,
            };
            0x2::event::emit<EmergencyWithdrawEvent>(v2);
        };
    }

    public fun get_emergency_balance(arg0: &StakingPool) : u64 {
        0x2::balance::value<BOSU>(&arg0.stake_balance)
    }

    public fun get_pool_info(arg0: &StakingPool) : (address, u64, u64, u64, u64, u64, u64, bool) {
        (arg0.admin, arg0.lock_period_days, arg0.daily_reward_rate, arg0.early_unstake_penalty, arg0.total_staked, 0x2::balance::value<BOSU>(&arg0.reward_pool), 0x2::balance::value<BOSU>(&arg0.stake_balance), arg0.is_emergency)
    }

    public fun get_user_stake(arg0: &StakingPool, arg1: address) : (u64, u64, u64) {
        if (0x2::table::contains<address, UserStake>(&arg0.stakes, arg1)) {
            let v3 = 0x2::table::borrow<address, UserStake>(&arg0.stakes, arg1);
            (v3.amount, v3.stake_time, v3.last_claim_time)
        } else {
            (0, 0, 0)
        }
    }

    public fun is_emergency_mode(arg0: &StakingPool) : bool {
        arg0.is_emergency
    }

    public entry fun stake(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<BOSU>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_emergency, 5);
        let v0 = 0x2::coin::value<BOSU>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2) / 1000;
        0x2::balance::join<BOSU>(&mut arg0.stake_balance, 0x2::coin::into_balance<BOSU>(arg1));
        if (0x2::table::contains<address, UserStake>(&arg0.stakes, v1)) {
            let v3 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.stakes, v1);
            v3.amount = v3.amount + v0;
            v3.last_claim_time = v2;
        } else {
            let v4 = UserStake{
                amount          : v0,
                stake_time      : v2,
                last_claim_time : v2,
            };
            0x2::table::add<address, UserStake>(&mut arg0.stakes, v1, v4);
        };
        arg0.total_staked = arg0.total_staked + v0;
        let v5 = StakeEvent{
            user      : v1,
            amount    : v0,
            timestamp : v2,
        };
        0x2::event::emit<StakeEvent>(v5);
    }

    public entry fun unstake(arg0: &mut StakingPool, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, UserStake>(&arg0.stakes, v0), 2);
        let v1 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.stakes, v0);
        assert!(v1.amount >= arg1, 1);
        let v2 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let (v3, v4) = if (v2 < v1.stake_time + arg0.lock_period_days * 86400) {
            let v5 = arg1 * arg0.early_unstake_penalty / 10000;
            (arg1 - v5, v5)
        } else {
            (arg1, 0)
        };
        v1.amount = v1.amount - arg1;
        arg0.total_staked = arg0.total_staked - arg1;
        if (v1.amount == 0) {
            0x2::table::remove<address, UserStake>(&mut arg0.stakes, v0);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BOSU>>(0x2::coin::from_balance<BOSU>(0x2::balance::split<BOSU>(&mut arg0.stake_balance, v3), arg3), v0);
        };
        let v6 = UnstakeEvent{
            user      : v0,
            amount    : v3,
            penalty   : v4,
            timestamp : v2,
        };
        0x2::event::emit<UnstakeEvent>(v6);
    }

    public entry fun update_rates(arg0: &mut StakingPool, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 3);
        assert!(arg2 > 0 && arg2 <= 1000, 4);
        assert!(arg3 <= 5000, 4);
        arg0.daily_reward_rate = arg2;
        arg0.early_unstake_penalty = arg3;
    }

    // decompiled from Move bytecode v6
}

