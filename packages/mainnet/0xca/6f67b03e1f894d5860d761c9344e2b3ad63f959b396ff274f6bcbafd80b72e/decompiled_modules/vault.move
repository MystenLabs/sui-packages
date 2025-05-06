module 0xca6f67b03e1f894d5860d761c9344e2b3ad63f959b396ff274f6bcbafd80b72e::vault {
    struct RewardState has key {
        id: 0x2::object::UID,
        duration: u64,
        finishAt: u64,
        updatedAt: u64,
        rewardRate: u64,
    }

    struct UserState has key {
        id: 0x2::object::UID,
        rewardPerTokenStored: u64,
        userRewardPerTokenPaid: 0x2::vec_map::VecMap<address, u64>,
        balanceOf: 0x2::vec_map::VecMap<address, u64>,
        rewards: 0x2::vec_map::VecMap<address, u64>,
    }

    struct Treasury<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        rewardsTreasury: 0x2::balance::Balance<T0>,
        stakedCoinsTreasury: 0x2::balance::Balance<T1>,
        enable: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct RewardAdded has copy, drop {
        reward: u64,
    }

    struct RewardDurationUpdated has copy, drop {
        newDuration: u64,
    }

    struct Staked has copy, drop {
        user: address,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        user: address,
        amount: u64,
    }

    struct RewardPaid has copy, drop {
        user: address,
        reward: u64,
    }

    fun earned(arg0: u64, arg1: address, arg2: &UserState, arg3: &RewardState, arg4: &0x2::clock::Clock) : u64 {
        (((*0x2::vec_map::get<address, u64>(&arg2.balanceOf, &arg1) as u256) * ((rewardPerToken(arg0, arg2, arg3, arg4) as u256) - (*0x2::vec_map::get<address, u64>(&arg2.userRewardPerTokenPaid, &arg1) as u256)) / (0x2::math::pow(10, 9) as u256) + (*0x2::vec_map::get<address, u64>(&arg2.rewards, &arg1) as u256)) as u64)
    }

    public entry fun enable_system<T0, T1>(arg0: &mut AdminCap, arg1: &mut Treasury<T0, T1>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.enable = arg2;
    }

    public entry fun getReward<T0, T1>(arg0: &mut UserState, arg1: &mut RewardState, arg2: &mut Treasury<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.enable, 4040);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_map::contains<address, u64>(&arg0.rewards, &v0), 107);
        updateReward(0x2::balance::value<T1>(&arg2.stakedCoinsTreasury), v0, arg0, arg1, arg3);
        assert!(*0x2::vec_map::get<address, u64>(&mut arg0.rewards, &v0) > 0, 105);
        let v1 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.rewards, &v0);
        let v2 = RewardPaid{
            user   : 0x2::tx_context::sender(arg4),
            reward : *v1,
        };
        0x2::event::emit<RewardPaid>(v2);
        *v1 = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.rewardsTreasury, *v1, arg4), 0x2::tx_context::sender(arg4));
    }

    public fun getTotalReward<T0, T1>(arg0: &Treasury<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.rewardsTreasury)
    }

    public fun getTotalStaked<T0, T1>(arg0: &Treasury<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.stakedCoinsTreasury)
    }

    public fun getUserEarned<T0, T1>(arg0: address, arg1: &UserState, arg2: &RewardState, arg3: &Treasury<T0, T1>, arg4: &0x2::clock::Clock) : u64 {
        earned(0x2::balance::value<T1>(&arg3.stakedCoinsTreasury), arg0, arg1, arg2, arg4)
    }

    public fun getUserStaked<T0, T1>(arg0: &UserState, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, u64>(&arg0.balanceOf, &arg1)) {
            return *0x2::vec_map::get<address, u64>(&arg0.balanceOf, &arg1)
        };
        0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardState{
            id         : 0x2::object::new(arg0),
            duration   : 0,
            finishAt   : 0,
            updatedAt  : 0,
            rewardRate : 0,
        };
        0x2::transfer::share_object<RewardState>(v0);
        let v1 = UserState{
            id                     : 0x2::object::new(arg0),
            rewardPerTokenStored   : 0,
            userRewardPerTokenPaid : 0x2::vec_map::empty<address, u64>(),
            balanceOf              : 0x2::vec_map::empty<address, u64>(),
            rewards                : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::share_object<UserState>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    fun rewardPerToken(arg0: u64, arg1: &UserState, arg2: &RewardState, arg3: &0x2::clock::Clock) : u64 {
        if (arg0 == 0) {
            return arg1.rewardPerTokenStored
        };
        (((arg1.rewardPerTokenStored as u256) + (arg2.rewardRate as u256) * ((0x2::math::min(0x2::clock::timestamp_ms(arg3), arg2.finishAt) as u256) - (arg2.updatedAt as u256)) * (0x2::math::pow(10, 9) as u256) / (arg0 as u256)) as u64)
    }

    public entry fun setRewardAmount<T0, T1>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut UserState, arg3: &mut RewardState, arg4: &mut Treasury<T0, T1>, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        updateReward(0x2::balance::value<T1>(&arg4.stakedCoinsTreasury), @0x0, arg2, arg3, arg5);
        0x2::balance::join<T0>(&mut arg4.rewardsTreasury, 0x2::coin::into_balance<T0>(arg1));
        if (0x2::clock::timestamp_ms(arg5) >= arg3.finishAt) {
            arg3.rewardRate = v0 / arg3.duration;
        } else {
            arg3.rewardRate = (v0 + (arg3.finishAt - 0x2::clock::timestamp_ms(arg5)) * arg3.rewardRate) / arg3.duration;
        };
        assert!(arg3.rewardRate > 0, 101);
        assert!(arg3.rewardRate * arg3.duration <= 0x2::balance::value<T0>(&arg4.rewardsTreasury), 103);
        arg3.finishAt = 0x2::clock::timestamp_ms(arg5) + arg3.duration;
        arg3.updatedAt = 0x2::clock::timestamp_ms(arg5);
        let v1 = RewardAdded{reward: v0};
        0x2::event::emit<RewardAdded>(v1);
    }

    public entry fun setRewardDuration(arg0: &AdminCap, arg1: &mut RewardState, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.finishAt < 0x2::clock::timestamp_ms(arg3), 100);
        arg1.duration = arg2;
        let v0 = RewardDurationUpdated{newDuration: arg2};
        0x2::event::emit<RewardDurationUpdated>(v0);
    }

    public entry fun setup_vault<T0, T1>(arg0: &mut AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0, T1>{
            id                  : 0x2::object::new(arg1),
            rewardsTreasury     : 0x2::balance::zero<T0>(),
            stakedCoinsTreasury : 0x2::balance::zero<T1>(),
            enable              : true,
        };
        0x2::transfer::share_object<Treasury<T0, T1>>(v0);
    }

    public entry fun stake<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut UserState, arg2: &mut RewardState, arg3: &mut Treasury<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.enable, 4040);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<T1>(&arg0);
        if (!0x2::vec_map::contains<address, u64>(&arg1.balanceOf, &v0)) {
            0x2::vec_map::insert<address, u64>(&mut arg1.balanceOf, v0, 0);
            0x2::vec_map::insert<address, u64>(&mut arg1.userRewardPerTokenPaid, v0, 0);
            0x2::vec_map::insert<address, u64>(&mut arg1.rewards, v0, 0);
        };
        updateReward(0x2::balance::value<T1>(&arg3.stakedCoinsTreasury), v0, arg1, arg2, arg4);
        0x2::balance::join<T1>(&mut arg3.stakedCoinsTreasury, 0x2::coin::into_balance<T1>(arg0));
        let v2 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.balanceOf, &v0);
        *v2 = *v2 + v1;
        let v3 = Staked{
            user   : 0x2::tx_context::sender(arg5),
            amount : v1,
        };
        0x2::event::emit<Staked>(v3);
    }

    fun updateReward(arg0: u64, arg1: address, arg2: &mut UserState, arg3: &mut RewardState, arg4: &0x2::clock::Clock) {
        arg2.rewardPerTokenStored = rewardPerToken(arg0, arg2, arg3, arg4);
        arg3.updatedAt = 0x2::math::min(0x2::clock::timestamp_ms(arg4), arg3.finishAt);
        if (arg1 != @0x0) {
            *0x2::vec_map::get_mut<address, u64>(&mut arg2.rewards, &arg1) = earned(arg0, arg1, arg2, arg3, arg4);
            *0x2::vec_map::get_mut<address, u64>(&mut arg2.userRewardPerTokenPaid, &arg1) = arg2.rewardPerTokenStored;
        };
    }

    public entry fun withdraw<T0, T1>(arg0: &mut UserState, arg1: &mut RewardState, arg2: &mut Treasury<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.enable, 4040);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::vec_map::get<address, u64>(&mut arg0.balanceOf, &v0);
        assert!(0x2::vec_map::contains<address, u64>(&arg0.balanceOf, &v0), 106);
        assert!(arg3 > 0, 102);
        assert!(arg3 <= *v1, 104);
        updateReward(0x2::balance::value<T1>(&arg2.stakedCoinsTreasury), v0, arg0, arg1, arg4);
        let v2 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.balanceOf, &v0);
        *v2 = *v2 - arg3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg2.stakedCoinsTreasury, arg3, arg5), 0x2::tx_context::sender(arg5));
        let v3 = Withdrawn{
            user   : 0x2::tx_context::sender(arg5),
            amount : arg3,
        };
        0x2::event::emit<Withdrawn>(v3);
    }

    // decompiled from Move bytecode v6
}

