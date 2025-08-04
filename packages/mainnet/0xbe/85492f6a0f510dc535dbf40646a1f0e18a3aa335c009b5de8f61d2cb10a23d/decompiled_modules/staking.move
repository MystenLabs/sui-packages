module 0xbe85492f6a0f510dc535dbf40646a1f0e18a3aa335c009b5de8f61d2cb10a23d::staking {
    struct UserState has key {
        id: 0x2::object::UID,
        is_claimed: bool,
        staked_amount: u64,
        pending_reward: u64,
    }

    struct Stake<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        amount: u64,
        lock_period: u64,
        start_time: u64,
        multiplier: u64,
        claimed: bool,
    }

    struct StakingPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_staked: u64,
        rewards_balance: 0x2::balance::Balance<T0>,
        user_rewards: 0x2::vec_map::VecMap<address, u64>,
    }

    struct StakeCreated has copy, drop {
        stake_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        lock_period: u64,
        multiplier: u64,
    }

    struct StakeClaimed has copy, drop {
        stake_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        reward: u64,
    }

    fun calculate_reward(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = &arg2;
        let v1 = 2592000;
        let v2 = if (v0 == &v1) {
            (arg0 as u128) * 167 / 10000
        } else {
            let v3 = 7776000;
            if (v0 == &v3) {
                (arg0 as u128) * 10 / 100
            } else {
                let v4 = 15552000;
                if (v0 == &v4) {
                    (arg0 as u128) * 40 / 100
                } else {
                    let v5 = 31536000;
                    if (v0 == &v5) {
                        (arg0 as u128) * 120 / 100
                    } else {
                        0
                    }
                }
            }
        };
        (v2 as u64)
    }

    public entry fun claim<T0>(arg0: &mut UserState, arg1: &mut StakingPool<T0>, arg2: Stake<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.owner == 0x2::tx_context::sender(arg3), 4);
        assert!(!arg2.claimed, 3);
        assert!(0x2::tx_context::epoch(arg3) - arg2.start_time >= arg2.lock_period, 2);
        assert!(!arg0.is_claimed, 5);
        arg0.is_claimed = true;
        arg0.staked_amount = arg0.staked_amount - arg2.amount;
        let v0 = calculate_reward(arg2.amount, arg2.multiplier, arg2.lock_period);
        let v1 = arg2.amount + v0;
        assert!(0x2::balance::value<T0>(&arg1.rewards_balance) >= v1, 1);
        arg1.total_staked = arg1.total_staked - arg2.amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.rewards_balance, v1, arg3), 0x2::tx_context::sender(arg3));
        let v2 = StakeClaimed{
            stake_id : 0x2::object::id<Stake<T0>>(&arg2),
            owner    : arg2.owner,
            amount   : arg2.amount,
            reward   : v0,
        };
        0x2::event::emit<StakeClaimed>(v2);
        let Stake {
            id          : v3,
            owner       : _,
            amount      : _,
            lock_period : _,
            start_time  : _,
            multiplier  : _,
            claimed     : _,
        } = arg2;
        0x2::object::delete(v3);
    }

    fun get_multiplier(arg0: u64) : (u64, bool) {
        if (arg0 == 2592000) {
            (10000, true)
        } else if (arg0 == 7776000) {
            (14000, true)
        } else if (arg0 == 15552000) {
            (20000, true)
        } else if (arg0 == 31536000) {
            (32000, true)
        } else {
            (0, false)
        }
    }

    public entry fun get_staking_state<T0>(arg0: &mut StakingPool<T0>, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        (arg0.total_staked, 0x2::balance::value<T0>(&arg0.rewards_balance))
    }

    public entry fun get_user(arg0: &mut UserState) : (u64, bool, u64) {
        (arg0.staked_amount, arg0.is_claimed, arg0.pending_reward)
    }

    public fun get_user_reward<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: &Stake<T0>) : u64 {
        assert!(arg2.owner == arg1, 4);
        if (0x2::vec_map::contains<address, u64>(&arg0.user_rewards, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.user_rewards, &arg1)
        } else {
            0
        }
    }

    public entry fun get_user_reward_entry<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: &Stake<T0>) : u64 {
        get_user_reward<T0>(arg0, arg1, arg2)
    }

    public entry fun initialize_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool<T0>{
            id              : 0x2::object::new(arg0),
            total_staked    : 0,
            rewards_balance : 0x2::balance::zero<T0>(),
            user_rewards    : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::share_object<StakingPool<T0>>(v0);
    }

    public entry fun initialize_user_state(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserState{
            id             : 0x2::object::new(arg0),
            is_claimed     : false,
            staked_amount  : 0,
            pending_reward : 0,
        };
        0x2::transfer::transfer<UserState>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun stake<T0>(arg0: &mut StakingPool<T0>, arg1: &mut UserState, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 1);
        let (v1, v2) = get_multiplier(arg3);
        assert!(v2, 0);
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = Stake<T0>{
            id          : 0x2::object::new(arg4),
            owner       : v3,
            amount      : v0,
            lock_period : arg3,
            start_time  : 0x2::tx_context::epoch(arg4),
            multiplier  : v1,
            claimed     : false,
        };
        arg0.total_staked = arg0.total_staked + v0;
        arg1.staked_amount = arg1.staked_amount + v0;
        arg1.pending_reward = arg1.pending_reward + calculate_reward(v0, v1, arg3);
        0x2::balance::join<T0>(&mut arg0.rewards_balance, 0x2::coin::into_balance<T0>(arg2));
        if (!0x2::vec_map::contains<address, u64>(&arg0.user_rewards, &v3)) {
            0x2::vec_map::insert<address, u64>(&mut arg0.user_rewards, v3, 0);
        };
        let v5 = StakeCreated{
            stake_id    : 0x2::object::id<Stake<T0>>(&v4),
            owner       : v3,
            amount      : v0,
            lock_period : arg3,
            multiplier  : v1,
        };
        0x2::event::emit<StakeCreated>(v5);
        0x2::transfer::transfer<Stake<T0>>(v4, v3);
    }

    // decompiled from Move bytecode v6
}

