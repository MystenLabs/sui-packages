module 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::FFIO {
    struct Treasury has key {
        id: 0x2::object::UID,
        rewardsTreasury: 0x2::balance::Balance<FFIO>,
        stakedCoinsTreasury: 0x2::balance::Balance<FFIO>,
        gameRewardsTreasury: 0x2::balance::Balance<FFIO>,
        version: u64,
    }

    struct StakeObject has key {
        id: 0x2::object::UID,
        amount: u64,
        start_epoch: u64,
        reward_rate: u64,
    }

    struct StakingPool has key {
        id: 0x2::object::UID,
        total_staked: 0x2::balance::Balance<FFIO>,
        reward_rate: u64,
        last_updated_time: u64,
        version: u64,
    }

    struct FFIO has drop {
        dummy_field: bool,
    }

    struct FindFourAdminCap has key {
        id: 0x2::object::UID,
    }

    struct PresaleState has key {
        id: 0x2::object::UID,
        token_supply: 0x2::balance::Balance<FFIO>,
        price: u64,
        tokens_sold: u64,
        cap: u64,
        version: u64,
    }

    struct RewardState has key {
        id: 0x2::object::UID,
        duration: u64,
        finishAt: u64,
        updatedAt: u64,
        rewardRate: u64,
        version: u64,
    }

    struct UserState2 has key {
        id: 0x2::object::UID,
        rewardPerTokenStored: u64,
        userRewardPerTokenPaid: 0x2::table::Table<address, u64>,
        balanceOf: 0x2::table::Table<address, u64>,
        rewards: 0x2::table::Table<address, u64>,
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

    public fun calculate_rewards(arg0: &StakingPool, arg1: &StakeObject, arg2: &0x2::clock::Clock) : u64 {
        check_version_StakingPool(arg0);
        if (arg0.reward_rate >= arg1.reward_rate) {
            return arg0.reward_rate * (getCurrentEpoch(arg2) - arg1.start_epoch) * arg1.amount / 1000000000
        };
        arg1.reward_rate * (getCurrentEpoch(arg2) - arg1.start_epoch) * arg1.amount / 1000000000
    }

    fun check_version_PresaleState(arg0: &PresaleState) {
        assert!(arg0.version == 1, 1);
    }

    fun check_version_RewardState(arg0: &RewardState) {
        assert!(arg0.version == 1, 1);
    }

    fun check_version_StakingPool(arg0: &StakingPool) {
        assert!(arg0.version == 1, 1);
    }

    fun check_version_Treasury(arg0: &Treasury) {
        assert!(arg0.version == 1, 1);
    }

    fun check_version_UserState(arg0: &UserState) {
        let v0 = b"old version";
        0x1::debug::print<vector<u8>>(&v0);
    }

    fun check_version_UserState2(arg0: &UserState2) {
        assert!(arg0.version == 1, 1);
    }

    public fun claim_rewards(arg0: &mut StakingPool, arg1: &mut Treasury, arg2: &StakeObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) != @0xcafe, 1);
        check_version_StakingPool(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FFIO>>(0x2::coin::take<FFIO>(&mut arg1.rewardsTreasury, calculate_rewards(arg0, arg2, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun claim_rewards2(arg0: &mut StakingPool, arg1: &mut Treasury, arg2: StakeObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) != @0xcafe, 1);
        check_version_StakingPool(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FFIO>>(0x2::coin::take<FFIO>(&mut arg1.rewardsTreasury, calculate_rewards(arg0, &arg2, arg3), arg4), 0x2::tx_context::sender(arg4));
        let v0 = StakeObject{
            id          : 0x2::object::new(arg4),
            amount      : arg2.amount,
            start_epoch : getCurrentEpoch(arg3),
            reward_rate : arg0.reward_rate,
        };
        0x2::transfer::transfer<StakeObject>(v0, 0x2::tx_context::sender(arg4));
        0x2::transfer::transfer<StakeObject>(arg2, @0xcafe);
    }

    public(friend) fun create_url(arg0: vector<u8>) : 0x2::url::Url {
        0x2::url::new_unsafe(0x1::ascii::string(arg0))
    }

    public entry fun distribute_tokens<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun distribute_tokens2(arg0: &mut 0x2::coin::Coin<FFIO>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = b"Deprecated!";
        0x1::debug::print<vector<u8>>(&v0);
    }

    public entry fun distribute_tokens3(arg0: &mut 0x2::coin::Coin<FFIO>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = b"Deprecated!";
        0x1::debug::print<vector<u8>>(&v0);
    }

    public entry fun distribute_tokens4(arg0: 0x2::coin::Coin<FFIO>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg3);
        assert!(0x2::coin::value<FFIO>(&arg0) >= (arg2 as u64) * (0x1::vector::length<address>(&arg1) as u64), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<FFIO>>(0x2::coin::split<FFIO>(&mut arg0, arg2, arg3), *0x1::vector::borrow<address>(&arg1, v0));
            v0 = v0 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<FFIO>>(arg0, 0x2::tx_context::sender(arg3));
    }

    fun earned(arg0: u64, arg1: address, arg2: &UserState, arg3: &RewardState, arg4: &0x2::clock::Clock) : u64 {
        0
    }

    fun earned2(arg0: u64, arg1: address, arg2: &UserState2, arg3: &RewardState, arg4: &0x2::clock::Clock) : u64 {
        let v0 = b"old version";
        0x1::debug::print<vector<u8>>(&v0);
        0
    }

    fun getCurrentEpoch(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public entry fun getReward(arg0: &mut UserState, arg1: &mut RewardState, arg2: &mut Treasury, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = b"old version";
        0x1::debug::print<vector<u8>>(&v0);
    }

    public entry fun getReward2(arg0: &mut UserState2, arg1: &mut RewardState, arg2: &mut Treasury, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = b"old version";
        0x1::debug::print<vector<u8>>(&v0);
    }

    public(friend) fun getStakedAmount(arg0: &StakeObject) : u64 {
        arg0.amount
    }

    fun init(arg0: FFIO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FindFourAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<FindFourAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = FindFourAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<FindFourAdminCap>(v1, 0x2::tx_context::sender(arg1));
        let (v2, v3) = 0x2::coin::create_currency<FFIO>(arg0, 9, b"WJKL4", b"F", b"Play to earn!", 0x1::option::some<0x2::url::Url>(create_url(b"https://www.find4.io/f4-42.png")), arg1);
        let v4 = v2;
        let v5 = 500000000 * 1000000000;
        let v6 = Treasury{
            id                  : 0x2::object::new(arg1),
            rewardsTreasury     : 0x2::balance::zero<FFIO>(),
            stakedCoinsTreasury : 0x2::balance::zero<FFIO>(),
            gameRewardsTreasury : 0x2::balance::zero<FFIO>(),
            version             : 1,
        };
        0x2::balance::join<FFIO>(&mut v6.rewardsTreasury, 0x2::coin::into_balance<FFIO>(0x2::coin::mint<FFIO>(&mut v4, 8 * v5, arg1)));
        0x2::balance::join<FFIO>(&mut v6.gameRewardsTreasury, 0x2::coin::into_balance<FFIO>(0x2::coin::mint<FFIO>(&mut v4, 10 * v5, arg1)));
        0x2::transfer::share_object<Treasury>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<FFIO>>(0x2::coin::mint<FFIO>(&mut v4, 14 * v5, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFIO>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFIO>>(v4, 0x2::tx_context::sender(arg1));
        let v7 = PresaleState{
            id           : 0x2::object::new(arg1),
            token_supply : 0x2::coin::into_balance<FFIO>(0x2::coin::mint<FFIO>(&mut v4, 4 * v5, arg1)),
            price        : 1000000000 / 100,
            tokens_sold  : 0,
            cap          : 4 * v5,
            version      : 1,
        };
        0x2::transfer::share_object<PresaleState>(v7);
    }

    public entry fun migrate(arg0: &FindFourAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool{
            id                : 0x2::object::new(arg1),
            total_staked      : 0x2::balance::zero<FFIO>(),
            reward_rate       : 10,
            last_updated_time : 0,
            version           : 1,
        };
        0x2::transfer::share_object<StakingPool>(v0);
    }

    fun rewardPerToken(arg0: u64, arg1: &UserState2, arg2: &RewardState, arg3: &0x2::clock::Clock) : u64 {
        0
    }

    fun rewardPerToken2(arg0: u64, arg1: &UserState2, arg2: &RewardState, arg3: &0x2::clock::Clock) : u64 {
        let v0 = b"old version";
        0x1::debug::print<vector<u8>>(&v0);
        0
    }

    public(friend) fun reward_winner(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_version_Treasury(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FFIO>>(0x2::coin::take<FFIO>(&mut arg0.gameRewardsTreasury, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun setRewardAmount(arg0: &FindFourAdminCap, arg1: 0x2::coin::Coin<FFIO>, arg2: &mut UserState, arg3: &mut RewardState, arg4: &mut Treasury, arg5: &0x2::clock::Clock) {
        check_version_UserState(arg2);
        0x2::coin::value<FFIO>(&arg1);
        0x2::balance::join<FFIO>(&mut arg4.rewardsTreasury, 0x2::coin::into_balance<FFIO>(arg1));
        let v0 = b"old version";
        0x1::debug::print<vector<u8>>(&v0);
    }

    public entry fun setRewardAmount2(arg0: &FindFourAdminCap, arg1: 0x2::coin::Coin<FFIO>, arg2: &mut UserState2, arg3: &mut RewardState, arg4: &mut Treasury, arg5: &0x2::clock::Clock) {
        abort 1
    }

    public entry fun setRewardDuration(arg0: &FindFourAdminCap, arg1: &mut RewardState, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = b"old version";
        0x1::debug::print<vector<u8>>(&v0);
    }

    public entry fun stake(arg0: 0x2::coin::Coin<FFIO>, arg1: &mut UserState, arg2: &mut RewardState, arg3: &mut Treasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version_UserState(arg1);
        0x2::balance::join<FFIO>(&mut arg3.stakedCoinsTreasury, 0x2::coin::into_balance<FFIO>(arg0));
        let v0 = b"old version";
        0x1::debug::print<vector<u8>>(&v0);
    }

    public entry fun stake2(arg0: 0x2::coin::Coin<FFIO>, arg1: &mut UserState2, arg2: &mut RewardState, arg3: &mut Treasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    public entry fun stake_existing_ffio(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<FFIO>, arg2: &mut Treasury, arg3: &0x2::clock::Clock, arg4: StakeObject, arg5: &mut 0x2::tx_context::TxContext) {
        check_version_StakingPool(arg0);
        claim_rewards(arg0, arg2, &arg4, arg3, arg5);
        assert!(0x2::tx_context::sender(arg5) != @0xcafe, 1);
        let v0 = StakeObject{
            id          : 0x2::object::new(arg5),
            amount      : 0x2::coin::value<FFIO>(&arg1) + arg4.amount,
            start_epoch : getCurrentEpoch(arg3),
            reward_rate : arg0.reward_rate,
        };
        0x2::balance::join<FFIO>(&mut arg2.stakedCoinsTreasury, 0x2::coin::into_balance<FFIO>(arg1));
        0x2::transfer::transfer<StakeObject>(v0, 0x2::tx_context::sender(arg5));
        0x2::transfer::transfer<StakeObject>(arg4, @0xcafe);
    }

    public entry fun stake_new_ffio(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<FFIO>, arg2: &mut Treasury, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version_StakingPool(arg0);
        assert!(0x2::tx_context::sender(arg4) != @0xcafe, 1);
        let v0 = StakeObject{
            id          : 0x2::object::new(arg4),
            amount      : 0x2::coin::value<FFIO>(&arg1),
            start_epoch : getCurrentEpoch(arg3),
            reward_rate : arg0.reward_rate,
        };
        0x2::balance::join<FFIO>(&mut arg2.stakedCoinsTreasury, 0x2::coin::into_balance<FFIO>(arg1));
        0x2::transfer::transfer<StakeObject>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun unstake_ffio(arg0: &mut StakingPool, arg1: &mut Treasury, arg2: &mut StakeObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) != @0xcafe, 1);
        check_version_StakingPool(arg0);
        claim_rewards(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<FFIO>>(0x2::coin::take<FFIO>(&mut arg1.stakedCoinsTreasury, arg2.amount, arg4), 0x2::tx_context::sender(arg4));
        arg2.amount = 0;
    }

    public entry fun updateCap(arg0: &FindFourAdminCap, arg1: &mut PresaleState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.cap = arg2;
    }

    public entry fun updatePresalePrice(arg0: &FindFourAdminCap, arg1: &mut PresaleState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.price = arg2;
    }

    fun updateReward(arg0: u64, arg1: address, arg2: &mut UserState, arg3: &mut RewardState, arg4: &0x2::clock::Clock) {
        let v0 = b"old version";
        0x1::debug::print<vector<u8>>(&v0);
    }

    fun updateReward2(arg0: u64, arg1: address, arg2: &mut UserState2, arg3: &mut RewardState, arg4: &0x2::clock::Clock) {
        let v0 = b"old version";
        0x1::debug::print<vector<u8>>(&v0);
    }

    public fun update_reward_rate(arg0: &FindFourAdminCap, arg1: &mut StakingPool, arg2: u64, arg3: &0x2::clock::Clock) {
        check_version_StakingPool(arg1);
        arg1.reward_rate = arg2;
        arg1.last_updated_time = getCurrentEpoch(arg3);
    }

    public entry fun update_version(arg0: &FindFourAdminCap, arg1: &mut UserState, arg2: &mut RewardState, arg3: &mut Treasury, arg4: &mut PresaleState) {
        let v0 = b"old version";
        0x1::debug::print<vector<u8>>(&v0);
    }

    public entry fun update_version2(arg0: &FindFourAdminCap, arg1: &mut UserState2, arg2: &mut RewardState, arg3: &mut Treasury, arg4: &mut PresaleState) {
        let v0 = b"old version";
        0x1::debug::print<vector<u8>>(&v0);
    }

    public entry fun update_version3(arg0: &FindFourAdminCap, arg1: &mut StakingPool, arg2: &mut Treasury, arg3: &mut PresaleState) {
        arg1.version = 1;
        arg2.version = 1;
        arg3.version = 1;
    }

    public entry fun withdraw(arg0: &mut UserState, arg1: &mut RewardState, arg2: &mut Treasury, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = b"old version";
        0x1::debug::print<vector<u8>>(&v0);
    }

    public entry fun withdraw2(arg0: &mut UserState2, arg1: &mut RewardState, arg2: &mut Treasury, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = b"old version";
        0x1::debug::print<vector<u8>>(&v0);
    }

    // decompiled from Move bytecode v6
}

