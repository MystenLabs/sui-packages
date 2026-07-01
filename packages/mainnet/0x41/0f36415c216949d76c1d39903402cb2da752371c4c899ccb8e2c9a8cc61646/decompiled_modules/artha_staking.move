module 0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha_staking {
    struct StakingPool has key {
        id: 0x2::object::UID,
        total_staked: u64,
        reward_balance: 0x2::balance::Balance<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>,
    }

    struct StakePosition has store, key {
        id: 0x2::object::UID,
        amount: u64,
        start_time: u64,
        lock_period: u64,
        apy_bps: u64,
        owner: address,
    }

    fun calc_reward(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 * arg1 * arg2 / 315360000000000
    }

    public fun fund_pool(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>) {
        0x2::balance::join<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>(&mut arg0.reward_balance, 0x2::coin::into_balance<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>(arg1));
    }

    fun get_lock_params(arg0: u64) : (u64, u64) {
        if (arg0 <= 30) {
            (2592000000, 800)
        } else if (arg0 <= 90) {
            (7776000000, 1500)
        } else if (arg0 <= 180) {
            (15552000000, 2000)
        } else {
            (31536000000, 3000)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool{
            id             : 0x2::object::new(arg0),
            total_staked   : 0,
            reward_balance : 0x2::balance::zero<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>(),
        };
        0x2::transfer::share_object<StakingPool>(v0);
    }

    public fun position_amount(arg0: &StakePosition) : u64 {
        arg0.amount
    }

    public fun position_apy(arg0: &StakePosition) : u64 {
        arg0.apy_bps
    }

    public fun reward_pool_balance(arg0: &StakingPool) : u64 {
        0x2::balance::value<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>(&arg0.reward_balance)
    }

    public fun stake(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2) = get_lock_params(arg2);
        let v3 = StakePosition{
            id          : 0x2::object::new(arg4),
            amount      : v0,
            start_time  : 0x2::clock::timestamp_ms(arg3),
            lock_period : v1,
            apy_bps     : v2,
            owner       : 0x2::tx_context::sender(arg4),
        };
        arg0.total_staked = arg0.total_staked + v0;
        0x2::balance::join<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>(&mut arg0.reward_balance, 0x2::coin::into_balance<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>(arg1));
        0x2::transfer::public_transfer<StakePosition>(v3, 0x2::tx_context::sender(arg4));
    }

    public fun total_staked(arg0: &StakingPool) : u64 {
        arg0.total_staked
    }

    public fun unstake(arg0: &mut StakingPool, arg1: StakePosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.owner == v0, 1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg1.start_time + arg1.lock_period, 2);
        let StakePosition {
            id          : v2,
            amount      : v3,
            start_time  : v4,
            lock_period : _,
            apy_bps     : v6,
            owner       : _,
        } = arg1;
        0x2::object::delete(v2);
        let v8 = v3 + calc_reward(v3, v6, v1 - v4);
        assert!(0x2::balance::value<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>(&arg0.reward_balance) >= v8, 3);
        arg0.total_staked = arg0.total_staked - v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>>(0x2::coin::from_balance<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>(0x2::balance::split<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>(&mut arg0.reward_balance, v8), arg3), v0);
    }

    public fun unstake_early(arg0: &mut StakingPool, arg1: StakePosition, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1.owner == v0, 1);
        let StakePosition {
            id          : v1,
            amount      : v2,
            start_time  : _,
            lock_period : _,
            apy_bps     : _,
            owner       : _,
        } = arg1;
        0x2::object::delete(v1);
        arg0.total_staked = arg0.total_staked - v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>>(0x2::coin::from_balance<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>(0x2::balance::split<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>(&mut arg0.reward_balance, v2 - v2 * 10 / 100), arg2), v0);
    }

    // decompiled from Move bytecode v7
}

