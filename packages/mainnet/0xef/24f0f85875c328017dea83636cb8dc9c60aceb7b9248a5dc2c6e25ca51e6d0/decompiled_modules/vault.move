module 0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::vault {
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

    struct Treasury has key {
        id: 0x2::object::UID,
        rewardsTreasury: 0x2::balance::Balance<0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop::STPOP>,
        stakedCoinsTreasury: 0x2::balance::Balance<0xa5acaa0f77c701fc014550491ea2f126b06124750f3237de18aa3b5dc66be87d::pop::POP>,
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
        (((*0x2::vec_map::get<address, u64>(&arg2.balanceOf, &arg1) as u256) * ((rewardPerToken(arg0, arg2, arg3, arg4) as u256) - (*0x2::vec_map::get<address, u64>(&arg2.userRewardPerTokenPaid, &arg1) as u256)) / (0x1::u64::pow(10, 9) as u256) + (*0x2::vec_map::get<address, u64>(&arg2.rewards, &arg1) as u256)) as u64)
    }

    public entry fun getReward(arg0: &mut UserState, arg1: &mut RewardState, arg2: &mut Treasury, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_map::contains<address, u64>(&arg0.rewards, &v0), 107);
        assert!(*0x2::vec_map::get<address, u64>(&mut arg0.rewards, &v0) > 0, 105);
        updateReward(0x2::balance::value<0xa5acaa0f77c701fc014550491ea2f126b06124750f3237de18aa3b5dc66be87d::pop::POP>(&arg2.stakedCoinsTreasury), v0, arg0, arg1, arg3);
        let v1 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.rewards, &v0);
        let v2 = RewardPaid{
            user   : 0x2::tx_context::sender(arg4),
            reward : *v1,
        };
        0x2::event::emit<RewardPaid>(v2);
        *v1 = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop::STPOP>>(0x2::coin::take<0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop::STPOP>(&mut arg2.rewardsTreasury, *v1, arg4), 0x2::tx_context::sender(arg4));
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
        let v2 = Treasury{
            id                  : 0x2::object::new(arg0),
            rewardsTreasury     : 0x2::balance::zero<0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop::STPOP>(),
            stakedCoinsTreasury : 0x2::balance::zero<0xa5acaa0f77c701fc014550491ea2f126b06124750f3237de18aa3b5dc66be87d::pop::POP>(),
        };
        0x2::transfer::share_object<Treasury>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    fun rewardPerToken(arg0: u64, arg1: &UserState, arg2: &RewardState, arg3: &0x2::clock::Clock) : u64 {
        if (arg0 == 0) {
            return arg1.rewardPerTokenStored
        };
        (((arg1.rewardPerTokenStored as u256) + (arg2.rewardRate as u256) * ((0x1::u64::min(0x2::clock::timestamp_ms(arg3), arg2.finishAt) as u256) - (arg2.updatedAt as u256)) * (0x2::math::pow(10, 9) as u256) / (arg0 as u256)) as u64)
    }

    public entry fun setRewardAmount(arg0: &AdminCap, arg1: 0x2::coin::Coin<0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop::STPOP>, arg2: &mut UserState, arg3: &mut RewardState, arg4: &mut Treasury, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::coin::value<0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop::STPOP>(&arg1);
        updateReward(0x2::balance::value<0xa5acaa0f77c701fc014550491ea2f126b06124750f3237de18aa3b5dc66be87d::pop::POP>(&arg4.stakedCoinsTreasury), @0x0, arg2, arg3, arg5);
        0x2::balance::join<0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop::STPOP>(&mut arg4.rewardsTreasury, 0x2::coin::into_balance<0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop::STPOP>(arg1));
        if (0x2::clock::timestamp_ms(arg5) >= arg3.finishAt) {
            arg3.rewardRate = v0 / arg3.duration;
        } else {
            arg3.rewardRate = (v0 + (arg3.finishAt - 0x2::clock::timestamp_ms(arg5)) * arg3.rewardRate) / arg3.duration;
        };
        assert!(arg3.rewardRate > 0, 101);
        assert!(arg3.rewardRate * arg3.duration <= 0x2::balance::value<0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop::STPOP>(&arg4.rewardsTreasury), 103);
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

    public entry fun stake(arg0: 0x2::coin::Coin<0xa5acaa0f77c701fc014550491ea2f126b06124750f3237de18aa3b5dc66be87d::pop::POP>, arg1: &mut UserState, arg2: &mut RewardState, arg3: &mut Treasury, arg4: &mut 0x2::coin::TreasuryCap<0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop::STPOP>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::balance::value<0xa5acaa0f77c701fc014550491ea2f126b06124750f3237de18aa3b5dc66be87d::pop::POP>(&arg3.stakedCoinsTreasury);
        let v2 = 0x2::coin::value<0xa5acaa0f77c701fc014550491ea2f126b06124750f3237de18aa3b5dc66be87d::pop::POP>(&arg0);
        if (!0x2::vec_map::contains<address, u64>(&arg1.balanceOf, &v0)) {
            0x2::vec_map::insert<address, u64>(&mut arg1.balanceOf, v0, 0);
            0x2::vec_map::insert<address, u64>(&mut arg1.userRewardPerTokenPaid, v0, 0);
            0x2::vec_map::insert<address, u64>(&mut arg1.rewards, v0, 0);
        };
        updateReward(v1, v0, arg1, arg2, arg5);
        0x2::balance::join<0xa5acaa0f77c701fc014550491ea2f126b06124750f3237de18aa3b5dc66be87d::pop::POP>(&mut arg3.stakedCoinsTreasury, 0x2::coin::into_balance<0xa5acaa0f77c701fc014550491ea2f126b06124750f3237de18aa3b5dc66be87d::pop::POP>(arg0));
        let v3 = if (v1 == 0) {
            v2
        } else {
            v2 * 0x2::balance::value<0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop::STPOP>(&arg3.rewardsTreasury) / v1
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop::STPOP>>(0x2::coin::mint<0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop::STPOP>(arg4, v3, arg6), v0);
        let v4 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.balanceOf, &v0);
        *v4 = *v4 + v2;
        let v5 = Staked{
            user   : v0,
            amount : v2,
        };
        0x2::event::emit<Staked>(v5);
    }

    fun updateReward(arg0: u64, arg1: address, arg2: &mut UserState, arg3: &mut RewardState, arg4: &0x2::clock::Clock) {
        arg2.rewardPerTokenStored = rewardPerToken(arg0, arg2, arg3, arg4);
        arg3.updatedAt = 0x1::u64::min(0x2::clock::timestamp_ms(arg4), arg3.finishAt);
        0x1::u64::pow(10, 9);
        if (arg1 != @0x0) {
            *0x2::vec_map::get_mut<address, u64>(&mut arg2.rewards, &arg1) = earned(arg0, arg1, arg2, arg3, arg4);
            *0x2::vec_map::get_mut<address, u64>(&mut arg2.userRewardPerTokenPaid, &arg1) = arg2.rewardPerTokenStored;
        };
    }

    public entry fun withdraw(arg0: &mut UserState, arg1: &mut RewardState, arg2: &mut Treasury, arg3: &mut 0x2::coin::TreasuryCap<0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop::STPOP>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::vec_map::get<address, u64>(&arg0.balanceOf, &v0);
        let v2 = 0x2::balance::value<0xa5acaa0f77c701fc014550491ea2f126b06124750f3237de18aa3b5dc66be87d::pop::POP>(&arg2.stakedCoinsTreasury);
        assert!(arg4 > 0, 102);
        assert!(arg4 <= *v1, 104);
        updateReward(v2, v0, arg0, arg1, arg5);
        let v3 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.balanceOf, &v0);
        *v3 = *v3 - arg4;
        0x2::coin::burn<0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop::STPOP>(arg3, 0x2::coin::take<0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop::STPOP>(&mut arg2.rewardsTreasury, arg4 * 0x2::balance::value<0xef24f0f85875c328017dea83636cb8dc9c60aceb7b9248a5dc2c6e25ca51e6d0::stpop::STPOP>(&arg2.rewardsTreasury) / v2, arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa5acaa0f77c701fc014550491ea2f126b06124750f3237de18aa3b5dc66be87d::pop::POP>>(0x2::coin::take<0xa5acaa0f77c701fc014550491ea2f126b06124750f3237de18aa3b5dc66be87d::pop::POP>(&mut arg2.stakedCoinsTreasury, arg4, arg6), v0);
        let v4 = Withdrawn{
            user   : v0,
            amount : arg4,
        };
        0x2::event::emit<Withdrawn>(v4);
    }

    // decompiled from Move bytecode v6
}

