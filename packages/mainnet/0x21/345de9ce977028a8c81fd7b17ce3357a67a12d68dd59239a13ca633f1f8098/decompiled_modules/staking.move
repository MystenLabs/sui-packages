module 0x21345de9ce977028a8c81fd7b17ce3357a67a12d68dd59239a13ca633f1f8098::staking {
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

    public entry fun claim<T0>(arg0: &mut StakingPool<T0>, arg1: Stake<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 4);
        assert!(!arg1.claimed, 3);
        assert!(0x2::tx_context::epoch(arg2) - arg1.start_time >= arg1.lock_period, 2);
        let v0 = calculate_reward(arg1.amount, arg1.multiplier, arg1.lock_period);
        let v1 = arg1.amount + v0;
        assert!(0x2::balance::value<T0>(&arg0.rewards_balance) >= v1, 1);
        arg0.total_staked = arg0.total_staked - arg1.amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.rewards_balance, v1, arg2), 0x2::tx_context::sender(arg2));
        let v2 = StakeClaimed{
            stake_id : 0x2::object::id<Stake<T0>>(&arg1),
            owner    : arg1.owner,
            amount   : arg1.amount,
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
        } = arg1;
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

    public entry fun initialize_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool<T0>{
            id              : 0x2::object::new(arg0),
            total_staked    : 0,
            rewards_balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::public_transfer<StakingPool<T0>>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun stake<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let (v1, v2) = get_multiplier(arg2);
        assert!(v2, 0);
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = Stake<T0>{
            id          : 0x2::object::new(arg3),
            owner       : v3,
            amount      : v0,
            lock_period : arg2,
            start_time  : 0x2::tx_context::epoch(arg3),
            multiplier  : v1,
            claimed     : false,
        };
        arg0.total_staked = arg0.total_staked + v0;
        0x2::balance::join<T0>(&mut arg0.rewards_balance, 0x2::coin::into_balance<T0>(arg1));
        let v5 = StakeCreated{
            stake_id    : 0x2::object::id<Stake<T0>>(&v4),
            owner       : v3,
            amount      : v0,
            lock_period : arg2,
            multiplier  : v1,
        };
        0x2::event::emit<StakeCreated>(v5);
        0x2::transfer::transfer<Stake<T0>>(v4, v3);
    }

    // decompiled from Move bytecode v6
}

