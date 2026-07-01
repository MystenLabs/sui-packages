module 0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha_staking {
    struct StakingPool has key {
        id: 0x2::object::UID,
        total_staked: u64,
        reward_balance: 0x2::balance::Balance<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>,
    }

    struct StakePosition has store, key {
        id: 0x2::object::UID,
        amount: u64,
        start_time: u64,
        lock_period: u64,
        apy_bps: u64,
        owner: address,
    }

    struct StakeEvent has copy, drop {
        amount: u64,
        lock_days: u64,
        apy_bps: u64,
    }

    struct UnstakeEvent has copy, drop {
        amount: u64,
        reward: u64,
    }

    fun calc_reward(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 * arg1 * arg2 / 315360000000000
    }

    public entry fun create_pool(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool{
            id             : 0x2::object::new(arg0),
            total_staked   : 0,
            reward_balance : 0x2::balance::zero<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(),
        };
        0x2::transfer::share_object<StakingPool>(v0);
    }

    public entry fun fund_pool(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>) {
        0x2::balance::join<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&mut arg0.reward_balance, 0x2::coin::into_balance<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(arg1));
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

    public fun reward_balance(arg0: &StakingPool) : u64 {
        0x2::balance::value<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&arg0.reward_balance)
    }

    public entry fun stake(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&arg1);
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
        0x2::balance::join<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&mut arg0.reward_balance, 0x2::coin::into_balance<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(arg1));
        let v4 = StakeEvent{
            amount    : v0,
            lock_days : arg2,
            apy_bps   : v2,
        };
        0x2::event::emit<StakeEvent>(v4);
        0x2::transfer::public_transfer<StakePosition>(v3, 0x2::tx_context::sender(arg4));
    }

    public fun total_staked(arg0: &StakingPool) : u64 {
        arg0.total_staked
    }

    public entry fun unstake(arg0: &mut StakingPool, arg1: StakePosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
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
        let v8 = calc_reward(v3, v6, v1 - v4);
        let v9 = v3 + v8;
        assert!(0x2::balance::value<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&arg0.reward_balance) >= v9, 3);
        arg0.total_staked = arg0.total_staked - v3;
        let v10 = UnstakeEvent{
            amount : v3,
            reward : v8,
        };
        0x2::event::emit<UnstakeEvent>(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>>(0x2::coin::from_balance<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(0x2::balance::split<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&mut arg0.reward_balance, v9), arg3), v0);
    }

    public entry fun unstake_early(arg0: &mut StakingPool, arg1: StakePosition, arg2: &mut 0x2::tx_context::TxContext) {
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
        0x2::transfer::public_transfer<0x2::coin::Coin<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>>(0x2::coin::from_balance<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(0x2::balance::split<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&mut arg0.reward_balance, v2 - v2 * 10 / 100), arg2), v0);
    }

    // decompiled from Move bytecode v7
}

