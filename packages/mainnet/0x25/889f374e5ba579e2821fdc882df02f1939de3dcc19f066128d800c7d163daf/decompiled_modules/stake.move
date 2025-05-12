module 0x25889f374e5ba579e2821fdc882df02f1939de3dcc19f066128d800c7d163daf::stake {
    struct StakeOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct UserInfo<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<T0>,
        reward_debt: u128,
    }

    struct GlobalState<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_staked: u64,
        acc_reward_per_share: u128,
        last_update_time: u64,
        reward_rate_per_ms: u64,
        reserve: 0x2::balance::Balance<T0>,
        staked: 0x2::vec_map::VecMap<address, UserInfo<T0>>,
    }

    struct StakeEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct UnstakeEvent has copy, drop {
        user: address,
        amount: u64,
        reward: u64,
    }

    struct StakeInfo has copy, drop {
        total_staked: u64,
        acc_reward_per_share: u128,
        last_update_time: u64,
        reward_rate_per_ms: u64,
        reserve: u64,
        pending_reward: u64,
        staked: u64,
        accumulated: u128,
        reward_debt: u128,
        now: u64,
    }

    struct HarvestEvent has copy, drop {
        user: address,
        amount: u64,
    }

    fun stake<T0>(arg0: &mut GlobalState<T0>, arg1: &mut UserInfo<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0);
        update_reward<T0>(arg0, arg3);
        let v1 = harvest<T0>(arg0, arg1, arg3, arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        0x2::balance::join<T0>(&mut arg1.amount, 0x2::coin::into_balance<T0>(arg2));
        0x2::balance::join<T0>(&mut arg1.amount, 0x2::coin::into_balance<T0>(v1));
        arg0.total_staked = arg0.total_staked + v0 + v2;
        arg1.reward_debt = (0x2::balance::value<T0>(&arg1.amount) as u128) * arg0.acc_reward_per_share / 1000000000000;
        let v3 = StakeEvent{
            user   : 0x2::tx_context::sender(arg4),
            amount : v0 + v2,
        };
        0x2::event::emit<StakeEvent>(v3);
    }

    public fun collectReserve<T0>(arg0: &mut GlobalState<T0>, arg1: &mut StakeOwnerCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve, 0x2::balance::value<T0>(&arg0.reserve)), arg2)
    }

    public fun compute_info<T0>(arg0: &mut GlobalState<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        if (0x2::vec_map::contains<address, UserInfo<T0>>(&arg0.staked, &v1)) {
            let v2 = 0x2::tx_context::sender(arg2);
            let v3 = 0x2::vec_map::get<address, UserInfo<T0>>(&arg0.staked, &v2);
            if (v0 <= arg0.last_update_time || arg0.total_staked == 0) {
                return
            };
            let v4 = (0x2::balance::value<T0>(&v3.amount) as u128) * (arg0.acc_reward_per_share + (((v0 - arg0.last_update_time) * arg0.reward_rate_per_ms) as u128) * 1000000000000 / (arg0.total_staked as u128)) / 1000000000000;
            let v5 = if (v4 >= v3.reward_debt) {
                v4 - v3.reward_debt
            } else {
                0
            };
            let v6 = StakeInfo{
                total_staked         : arg0.total_staked,
                acc_reward_per_share : arg0.acc_reward_per_share,
                last_update_time     : arg0.last_update_time,
                reward_rate_per_ms   : arg0.reward_rate_per_ms,
                reserve              : 0x2::balance::value<T0>(&arg0.reserve),
                pending_reward       : (v5 as u64),
                staked               : 0x2::balance::value<T0>(&v3.amount),
                accumulated          : v4,
                reward_debt          : v3.reward_debt,
                now                  : v0,
            };
            0x2::event::emit<StakeInfo>(v6);
        } else {
            let v7 = StakeInfo{
                total_staked         : arg0.total_staked,
                acc_reward_per_share : arg0.acc_reward_per_share,
                last_update_time     : arg0.last_update_time,
                reward_rate_per_ms   : arg0.reward_rate_per_ms,
                reserve              : 0x2::balance::value<T0>(&arg0.reserve),
                pending_reward       : 0,
                staked               : 0,
                accumulated          : 0,
                reward_debt          : 0,
                now                  : v0,
            };
            0x2::event::emit<StakeInfo>(v7);
        };
    }

    public fun fund<T0>(arg0: &mut GlobalState<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.reserve, 0x2::coin::into_balance<T0>(arg1));
    }

    fun harvest<T0>(arg0: &mut GlobalState<T0>, arg1: &mut UserInfo<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        update_reward<T0>(arg0, arg2);
        let v0 = 0x2::balance::value<T0>(&arg0.reserve);
        let v1 = (0x2::balance::value<T0>(&arg1.amount) as u128) * arg0.acc_reward_per_share / 1000000000000;
        if (v1 <= arg1.reward_debt) {
            return 0x2::coin::zero<T0>(arg3)
        };
        let v2 = v1 - arg1.reward_debt;
        let v3 = if ((v2 as u64) > v0) {
            v0
        } else {
            (v2 as u64)
        };
        arg1.reward_debt = v1;
        let v4 = HarvestEvent{
            user   : 0x2::tx_context::sender(arg3),
            amount : v3,
        };
        0x2::event::emit<HarvestEvent>(v4);
        if (v3 > 0) {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve, v3), arg3)
        } else {
            0x2::coin::zero<T0>(arg3)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakeOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<StakeOwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun init_global_state<T0>(arg0: &0x2::clock::Clock, arg1: &mut StakeOwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalState<T0>{
            id                   : 0x2::object::new(arg3),
            total_staked         : 0,
            acc_reward_per_share : 0,
            last_update_time     : 0x2::clock::timestamp_ms(arg0),
            reward_rate_per_ms   : arg2,
            reserve              : 0x2::balance::zero<T0>(),
            staked               : 0x2::vec_map::empty<address, UserInfo<T0>>(),
        };
        0x2::transfer::share_object<GlobalState<T0>>(v0);
    }

    public fun univeral_stake<T0>(arg0: &mut GlobalState<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x2::vec_map::contains<address, UserInfo<T0>>(&arg0.staked, &v0)) {
            let v1 = 0x2::tx_context::sender(arg3);
            let (_, v3) = 0x2::vec_map::remove<address, UserInfo<T0>>(&mut arg0.staked, &v1);
            let v4 = v3;
            let v5 = &mut v4;
            stake<T0>(arg0, v5, arg1, arg2, arg3);
            0x2::vec_map::insert<address, UserInfo<T0>>(&mut arg0.staked, 0x2::tx_context::sender(arg3), v4);
        } else {
            let v6 = UserInfo<T0>{
                id          : 0x2::object::new(arg3),
                amount      : 0x2::balance::zero<T0>(),
                reward_debt : 0,
            };
            let v7 = &mut v6;
            stake<T0>(arg0, v7, arg1, arg2, arg3);
            0x2::vec_map::insert<address, UserInfo<T0>>(&mut arg0.staked, 0x2::tx_context::sender(arg3), v6);
        };
    }

    public fun universal_harvest<T0>(arg0: &mut GlobalState<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_map::contains<address, UserInfo<T0>>(&arg0.staked, &v0), 2);
        let v1 = 0x2::tx_context::sender(arg2);
        let (_, v3) = 0x2::vec_map::remove<address, UserInfo<T0>>(&mut arg0.staked, &v1);
        let v4 = v3;
        let v5 = &mut v4;
        let v6 = harvest<T0>(arg0, v5, arg1, arg2);
        0x2::vec_map::insert<address, UserInfo<T0>>(&mut arg0.staked, 0x2::tx_context::sender(arg2), v4);
        v6
    }

    public fun universal_unstake<T0>(arg0: &mut GlobalState<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_map::contains<address, UserInfo<T0>>(&arg0.staked, &v0), 2);
        let v1 = 0x2::tx_context::sender(arg3);
        let (_, v3) = 0x2::vec_map::remove<address, UserInfo<T0>>(&mut arg0.staked, &v1);
        let v4 = v3;
        assert!(0x2::balance::value<T0>(&v4.amount) >= arg2, 1);
        update_reward<T0>(arg0, arg1);
        let v5 = &mut v4;
        let v6 = harvest<T0>(arg0, v5, arg1, arg3);
        arg0.total_staked = arg0.total_staked - arg2;
        0x2::coin::join<T0>(&mut v6, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4.amount, arg2), arg3));
        0x2::vec_map::insert<address, UserInfo<T0>>(&mut arg0.staked, 0x2::tx_context::sender(arg3), v4);
        let v7 = UnstakeEvent{
            user   : 0x2::tx_context::sender(arg3),
            amount : arg2,
            reward : 0x2::coin::value<T0>(&v6),
        };
        0x2::event::emit<UnstakeEvent>(v7);
        v6
    }

    fun update_reward<T0>(arg0: &mut GlobalState<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 <= arg0.last_update_time || arg0.total_staked == 0) {
            return
        };
        arg0.acc_reward_per_share = arg0.acc_reward_per_share + (((v0 - arg0.last_update_time) * arg0.reward_rate_per_ms) as u128) * 1000000000000 / (arg0.total_staked as u128);
        arg0.last_update_time = v0;
    }

    // decompiled from Move bytecode v6
}

