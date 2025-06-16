module 0x7191c2103149cd4248ac9df7760ada76d868dda0e7f53645aac8a9a03762f85b::staking {
    struct BOSU has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakingPool has key {
        id: 0x2::object::UID,
        admin: address,
        lock_period_days: u64,
        daily_reward_rate: u64,
        early_unstake_penalty: u64,
        total_staked: u64,
        reward_pool: u64,
        stakes: 0x2::table::Table<address, UserStake>,
    }

    struct UserStake has drop, store {
        amount: u64,
        stake_time: u64,
        last_claim_time: u64,
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

    struct PoolCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
        lock_period_days: u64,
        daily_reward_rate: u64,
        early_unstake_penalty: u64,
    }

    public entry fun add_rewards(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<BOSU>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.reward_pool = arg0.reward_pool + 0x2::coin::value<BOSU>(&arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BOSU>>(arg1, @0x0);
    }

    public fun calculate_pending_rewards(arg0: &StakingPool, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (0x2::table::contains<address, UserStake>(&arg0.stakes, arg1)) {
            let v1 = 0x2::table::borrow<address, UserStake>(&arg0.stakes, arg1);
            let v2 = 0x2::clock::timestamp_ms(arg2) / 1000 - v1.last_claim_time;
            if (v2 > 0) {
                v1.amount * arg0.daily_reward_rate / 10000 * v2 / 86400
            } else {
                0
            }
        } else {
            0
        }
    }

    public entry fun claim_rewards(arg0: &mut StakingPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, UserStake>(&arg0.stakes, v0), 3);
        let v1 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.stakes, v0);
        let v2 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v3 = v2 - v1.last_claim_time;
        if (v3 > 0) {
            let v4 = v1.amount * arg0.daily_reward_rate / 10000 * v3 / 86400;
            if (v4 > 0) {
                v1.last_claim_time = v2;
                let v5 = ClaimEvent{
                    user      : v0,
                    rewards   : v4,
                    timestamp : v2,
                };
                0x2::event::emit<ClaimEvent>(v5);
            };
        };
    }

    public entry fun create_pool(arg0: &AdminCap, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 5);
        assert!(arg3 > 0 && arg3 <= 1000, 5);
        assert!(arg4 <= 5000, 5);
        let v0 = 0x2::object::new(arg6);
        let v1 = StakingPool{
            id                    : v0,
            admin                 : arg1,
            lock_period_days      : arg2,
            daily_reward_rate     : arg3,
            early_unstake_penalty : arg4,
            total_staked          : 0,
            reward_pool           : 0,
            stakes                : 0x2::table::new<address, UserStake>(arg6),
        };
        let v2 = PoolCreatedEvent{
            pool_id               : 0x2::object::uid_to_inner(&v0),
            admin                 : arg1,
            lock_period_days      : arg2,
            daily_reward_rate     : arg3,
            early_unstake_penalty : arg4,
        };
        0x2::event::emit<PoolCreatedEvent>(v2);
        0x2::transfer::share_object<StakingPool>(v1);
    }

    public fun get_pool_info(arg0: &StakingPool) : (address, u64, u64, u64, u64, u64) {
        (arg0.admin, arg0.lock_period_days, arg0.daily_reward_rate, arg0.early_unstake_penalty, arg0.total_staked, arg0.reward_pool)
    }

    public fun get_user_stake(arg0: &StakingPool, arg1: address) : (u64, u64, u64) {
        if (0x2::table::contains<address, UserStake>(&arg0.stakes, arg1)) {
            let v3 = 0x2::table::borrow<address, UserStake>(&arg0.stakes, arg1);
            (v3.amount, v3.stake_time, v3.last_claim_time)
        } else {
            (0, 0, 0)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun stake(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<BOSU>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<BOSU>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2) / 1000;
        0x2::coin::destroy_zero<BOSU>(0x2::coin::split<BOSU>(&mut arg1, 0, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<BOSU>>(arg1, @0x0);
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
        assert!(0x2::table::contains<address, UserStake>(&arg0.stakes, v0), 3);
        let v1 = 0x2::table::borrow_mut<address, UserStake>(&mut arg0.stakes, v0);
        assert!(v1.amount >= arg1, 2);
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
        let v6 = UnstakeEvent{
            user      : v0,
            amount    : v3,
            penalty   : v4,
            timestamp : v2,
        };
        0x2::event::emit<UnstakeEvent>(v6);
    }

    public entry fun update_rates(arg0: &mut StakingPool, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        assert!(arg1 > 0 && arg1 <= 1000, 5);
        assert!(arg2 <= 5000, 5);
        arg0.daily_reward_rate = arg1;
        arg0.early_unstake_penalty = arg2;
    }

    // decompiled from Move bytecode v6
}

