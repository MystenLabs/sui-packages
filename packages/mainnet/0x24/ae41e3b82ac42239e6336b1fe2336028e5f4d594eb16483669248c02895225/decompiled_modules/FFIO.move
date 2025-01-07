module 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::FFIO {
    struct FFIO has drop {
        dummy_field: bool,
    }

    struct RewardState has key {
        id: 0x2::object::UID,
        duration: u64,
        finishAt: u64,
        updatedAt: u64,
        rewardRate: u64,
        version: u64,
    }

    struct UserState has key {
        id: 0x2::object::UID,
        rewardPerTokenStored: u64,
        userRewardPerTokenPaid: 0x2::vec_map::VecMap<address, u64>,
        balanceOf: 0x2::vec_map::VecMap<address, u64>,
        rewards: 0x2::vec_map::VecMap<address, u64>,
        version: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        rewardsTreasury: 0x2::balance::Balance<FFIO>,
        stakedCoinsTreasury: 0x2::balance::Balance<FFIO>,
        gameRewardsTreasury: 0x2::balance::Balance<FFIO>,
        version: u64,
    }

    struct FindFourAdminCap has key {
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

    struct PresaleState has key {
        id: 0x2::object::UID,
        token_supply: 0x2::balance::Balance<FFIO>,
        price: u64,
        tokens_sold: u64,
        cap: u64,
        version: u64,
    }

    public entry fun buy_token(arg0: &mut PresaleState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_version_PresaleState(arg0);
        let v0 = arg2 * arg0.price;
        let v1 = arg2 * 1000000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v0, 0);
        assert!(arg0.tokens_sold + v1 <= arg0.cap, 1);
        arg0.tokens_sold = arg0.tokens_sold + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0, arg3), @0x8418bb05799666b73c4645aa15e4d1ccae824e1487c01a665f51767826d192b7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<FFIO>>(0x2::coin::take<FFIO>(&mut arg0.token_supply, v1, arg3), 0x2::tx_context::sender(arg3));
    }

    fun check_version_PresaleState(arg0: &PresaleState) {
        assert!(arg0.version == 1, 1);
    }

    fun check_version_RewardState(arg0: &RewardState) {
        assert!(arg0.version == 1, 1);
    }

    fun check_version_Treasury(arg0: &Treasury) {
        assert!(arg0.version == 1, 1);
    }

    fun check_version_UserState(arg0: &UserState) {
        assert!(arg0.version == 1, 1);
    }

    public(friend) fun create_url(arg0: vector<u8>) : 0x2::url::Url {
        0x2::url::new_unsafe(0x1::ascii::string(arg0))
    }

    public entry fun distribute_tokens<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg3);
        assert!(0x2::coin::value<T0>(arg0) >= (arg2 as u64) * (0x1::vector::length<address>(&arg1) as u64), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg2, arg3), *0x1::vector::borrow<address>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    fun earned(arg0: u64, arg1: address, arg2: &UserState, arg3: &RewardState, arg4: &0x2::clock::Clock) : u64 {
        check_version_UserState(arg2);
        check_version_RewardState(arg3);
        (((*0x2::vec_map::get<address, u64>(&arg2.balanceOf, &arg1) as u256) * ((rewardPerToken(arg0, arg2, arg3, arg4) as u256) - (*0x2::vec_map::get<address, u64>(&arg2.userRewardPerTokenPaid, &arg1) as u256)) / (0x2::math::pow(10, 9) as u256) + (*0x2::vec_map::get<address, u64>(&arg2.rewards, &arg1) as u256)) as u64)
    }

    public entry fun getReward(arg0: &mut UserState, arg1: &mut RewardState, arg2: &mut Treasury, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version_UserState(arg0);
        check_version_RewardState(arg1);
        check_version_Treasury(arg2);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_map::contains<address, u64>(&arg0.rewards, &v0), 107);
        assert!(*0x2::vec_map::get<address, u64>(&mut arg0.rewards, &v0) > 0, 105);
        updateReward(0x2::balance::value<FFIO>(&arg2.stakedCoinsTreasury), v0, arg0, arg1, arg3);
        let v1 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.rewards, &v0);
        let v2 = RewardPaid{
            user   : 0x2::tx_context::sender(arg4),
            reward : *v1,
        };
        0x2::event::emit<RewardPaid>(v2);
        *v1 = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FFIO>>(0x2::coin::take<FFIO>(&mut arg2.rewardsTreasury, *v1, arg4), 0x2::tx_context::sender(arg4));
    }

    fun init(arg0: FFIO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FindFourAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<FindFourAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = RewardState{
            id         : 0x2::object::new(arg1),
            duration   : 0,
            finishAt   : 0,
            updatedAt  : 0,
            rewardRate : 0,
            version    : 1,
        };
        0x2::transfer::share_object<RewardState>(v1);
        let v2 = UserState{
            id                     : 0x2::object::new(arg1),
            rewardPerTokenStored   : 0,
            userRewardPerTokenPaid : 0x2::vec_map::empty<address, u64>(),
            balanceOf              : 0x2::vec_map::empty<address, u64>(),
            rewards                : 0x2::vec_map::empty<address, u64>(),
            version                : 1,
        };
        0x2::transfer::share_object<UserState>(v2);
        let v3 = FindFourAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<FindFourAdminCap>(v3, 0x2::tx_context::sender(arg1));
        let (v4, v5) = 0x2::coin::create_currency<FFIO>(arg0, 9, b"FFIO", b"Find4.io Coin", b"Play to earn!", 0x1::option::some<0x2::url::Url>(create_url(b"https://www.find4.io/f4-42.png")), arg1);
        let v6 = v4;
        let v7 = 500000000 * 1000000000;
        let v8 = Treasury{
            id                  : 0x2::object::new(arg1),
            rewardsTreasury     : 0x2::balance::zero<FFIO>(),
            stakedCoinsTreasury : 0x2::balance::zero<FFIO>(),
            gameRewardsTreasury : 0x2::balance::zero<FFIO>(),
            version             : 1,
        };
        0x2::balance::join<FFIO>(&mut v8.rewardsTreasury, 0x2::coin::into_balance<FFIO>(0x2::coin::mint<FFIO>(&mut v6, 8 * v7, arg1)));
        0x2::balance::join<FFIO>(&mut v8.gameRewardsTreasury, 0x2::coin::into_balance<FFIO>(0x2::coin::mint<FFIO>(&mut v6, 10 * v7, arg1)));
        0x2::transfer::share_object<Treasury>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<FFIO>>(0x2::coin::mint<FFIO>(&mut v6, 14 * v7, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFIO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFIO>>(v6, 0x2::tx_context::sender(arg1));
        let v9 = PresaleState{
            id           : 0x2::object::new(arg1),
            token_supply : 0x2::coin::into_balance<FFIO>(0x2::coin::mint<FFIO>(&mut v6, 4 * v7, arg1)),
            price        : 1000000000 / 100,
            tokens_sold  : 0,
            cap          : 4 * v7,
            version      : 1,
        };
        0x2::transfer::share_object<PresaleState>(v9);
    }

    fun rewardPerToken(arg0: u64, arg1: &UserState, arg2: &RewardState, arg3: &0x2::clock::Clock) : u64 {
        check_version_UserState(arg1);
        check_version_RewardState(arg2);
        if (arg0 == 0) {
            return arg1.rewardPerTokenStored
        };
        (((arg1.rewardPerTokenStored as u256) + (arg2.rewardRate as u256) * ((0x2::math::min(0x2::clock::timestamp_ms(arg3), arg2.finishAt) as u256) - (arg2.updatedAt as u256)) * (0x2::math::pow(10, 9) as u256) / (arg0 as u256)) as u64)
    }

    public(friend) fun reward_winner(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_version_Treasury(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FFIO>>(0x2::coin::take<FFIO>(&mut arg0.gameRewardsTreasury, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun setRewardAmount(arg0: &FindFourAdminCap, arg1: 0x2::coin::Coin<FFIO>, arg2: &mut UserState, arg3: &mut RewardState, arg4: &mut Treasury, arg5: &0x2::clock::Clock) {
        check_version_UserState(arg2);
        check_version_RewardState(arg3);
        check_version_Treasury(arg4);
        let v0 = 0x2::coin::value<FFIO>(&arg1);
        updateReward(0x2::balance::value<FFIO>(&arg4.stakedCoinsTreasury), @0x0, arg2, arg3, arg5);
        0x2::balance::join<FFIO>(&mut arg4.rewardsTreasury, 0x2::coin::into_balance<FFIO>(arg1));
        if (0x2::clock::timestamp_ms(arg5) >= arg3.finishAt) {
            arg3.rewardRate = v0 / arg3.duration;
        } else {
            arg3.rewardRate = (v0 + (arg3.finishAt - 0x2::clock::timestamp_ms(arg5)) * arg3.rewardRate) / arg3.duration;
        };
        assert!(arg3.rewardRate > 0, 101);
        assert!(arg3.rewardRate * arg3.duration <= 0x2::balance::value<FFIO>(&arg4.rewardsTreasury), 103);
        arg3.finishAt = 0x2::clock::timestamp_ms(arg5) + arg3.duration;
        arg3.updatedAt = 0x2::clock::timestamp_ms(arg5);
        let v1 = RewardAdded{reward: v0};
        0x2::event::emit<RewardAdded>(v1);
    }

    public entry fun setRewardDuration(arg0: &FindFourAdminCap, arg1: &mut RewardState, arg2: u64, arg3: &0x2::clock::Clock) {
        check_version_RewardState(arg1);
        assert!(arg1.finishAt < 0x2::clock::timestamp_ms(arg3), 100);
        arg1.duration = arg2;
        let v0 = RewardDurationUpdated{newDuration: arg2};
        0x2::event::emit<RewardDurationUpdated>(v0);
    }

    public entry fun stake(arg0: 0x2::coin::Coin<FFIO>, arg1: &mut UserState, arg2: &mut RewardState, arg3: &mut Treasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version_UserState(arg1);
        check_version_RewardState(arg2);
        check_version_Treasury(arg3);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<FFIO>(&arg0);
        if (!0x2::vec_map::contains<address, u64>(&arg1.balanceOf, &v0)) {
            0x2::vec_map::insert<address, u64>(&mut arg1.balanceOf, v0, 0);
            0x2::vec_map::insert<address, u64>(&mut arg1.userRewardPerTokenPaid, v0, 0);
            0x2::vec_map::insert<address, u64>(&mut arg1.rewards, v0, 0);
        };
        updateReward(0x2::balance::value<FFIO>(&arg3.stakedCoinsTreasury), v0, arg1, arg2, arg4);
        0x2::balance::join<FFIO>(&mut arg3.stakedCoinsTreasury, 0x2::coin::into_balance<FFIO>(arg0));
        let v2 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.balanceOf, &v0);
        *v2 = *v2 + v1;
        let v3 = Staked{
            user   : 0x2::tx_context::sender(arg5),
            amount : v1,
        };
        0x2::event::emit<Staked>(v3);
    }

    public entry fun updateCap(arg0: &FindFourAdminCap, arg1: &mut PresaleState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.cap = arg2;
    }

    public entry fun updatePresalePrice(arg0: &FindFourAdminCap, arg1: &mut PresaleState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.price = arg2;
    }

    fun updateReward(arg0: u64, arg1: address, arg2: &mut UserState, arg3: &mut RewardState, arg4: &0x2::clock::Clock) {
        check_version_UserState(arg2);
        check_version_RewardState(arg3);
        arg2.rewardPerTokenStored = rewardPerToken(arg0, arg2, arg3, arg4);
        arg3.updatedAt = 0x2::math::min(0x2::clock::timestamp_ms(arg4), arg3.finishAt);
        if (arg1 != @0x0) {
            *0x2::vec_map::get_mut<address, u64>(&mut arg2.rewards, &arg1) = earned(arg0, arg1, arg2, arg3, arg4);
            *0x2::vec_map::get_mut<address, u64>(&mut arg2.userRewardPerTokenPaid, &arg1) = arg2.rewardPerTokenStored;
        };
    }

    public entry fun update_version(arg0: &FindFourAdminCap, arg1: &mut UserState, arg2: &mut RewardState, arg3: &mut Treasury, arg4: &mut PresaleState) {
        arg1.version = 1;
        arg2.version = 1;
        arg3.version = 1;
        arg4.version = 1;
    }

    public entry fun withdraw(arg0: &mut UserState, arg1: &mut RewardState, arg2: &mut Treasury, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version_UserState(arg0);
        check_version_RewardState(arg1);
        check_version_Treasury(arg2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::vec_map::get<address, u64>(&mut arg0.balanceOf, &v0);
        assert!(0x2::vec_map::contains<address, u64>(&arg0.balanceOf, &v0), 106);
        assert!(arg3 > 0, 102);
        assert!(arg3 <= *v1, 104);
        updateReward(0x2::balance::value<FFIO>(&arg2.stakedCoinsTreasury), v0, arg0, arg1, arg4);
        let v2 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.balanceOf, &v0);
        *v2 = *v2 - arg3;
        0x2::transfer::public_transfer<0x2::coin::Coin<FFIO>>(0x2::coin::take<FFIO>(&mut arg2.stakedCoinsTreasury, arg3, arg5), 0x2::tx_context::sender(arg5));
        let v3 = Withdrawn{
            user   : 0x2::tx_context::sender(arg5),
            amount : arg3,
        };
        0x2::event::emit<Withdrawn>(v3);
    }

    // decompiled from Move bytecode v6
}

