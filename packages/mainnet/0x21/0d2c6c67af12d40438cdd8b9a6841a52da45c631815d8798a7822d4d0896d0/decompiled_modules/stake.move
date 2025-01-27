module 0x210d2c6c67af12d40438cdd8b9a6841a52da45c631815d8798a7822d4d0896d0::stake {
    struct PerformanceThreshold has copy, drop, store {
        business_volume: u64,
        weekly_reward: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminStorage has key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct UserStakeKey has copy, drop, store {
        user: address,
    }

    struct UserStake has store {
        stake_count: u64,
    }

    struct STAKE has drop {
        dummy_field: bool,
    }

    struct StakingPool<phantom T0> has key {
        id: 0x2::object::UID,
        total_staked: 0x2::balance::Balance<T0>,
        rewards_pool: 0x2::balance::Balance<T0>,
        total_stakes: u64,
        performance_thresholds: vector<PerformanceThreshold>,
    }

    struct BusinessVolumeKey has copy, drop, store {
        user: address,
    }

    struct BusinessVolume has drop, store {
        amount: u64,
    }

    struct UserReferrerKey has copy, drop, store {
        user: address,
    }

    struct UserReferrer has copy, drop, store {
        referrer: address,
    }

    struct Stake has store, key {
        id: 0x2::object::UID,
        amount: u64,
        owner: address,
        start_time: u64,
        maturity_time: u64,
        monthly_roi: u64,
        claimed_rewards: u64,
        referrer: address,
        level: u8,
    }

    struct BusinessVolumeUpdated has copy, drop {
        user: address,
        old_volume: u64,
        new_volume: u64,
        timestamp: u64,
    }

    struct StakeCreated has copy, drop {
        stake_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        start_time: u64,
        maturity_time: u64,
    }

    struct RewardClaimed has copy, drop {
        stake_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct AffiliateRewardPaid has copy, drop {
        from_stake: 0x2::object::ID,
        referrer: address,
        amount: u64,
        level: u8,
    }

    struct PerformanceBonusClaimed has copy, drop {
        user: address,
        business_volume: u64,
        bonus_amount: u64,
        timestamp: u64,
    }

    public entry fun admin_withdraw<T0>(arg0: &mut StakingPool<T0>, arg1: u64, arg2: &AdminCap, arg3: &AdminStorage, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg2, arg3), 7);
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.total_staked), 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_staked, arg1), arg5), arg4);
    }

    public fun calculate_performance_bonus<T0>(arg0: &mut StakingPool<T0>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PerformanceThreshold>(&arg0.performance_thresholds)) {
            let v1 = 0x1::vector::borrow<PerformanceThreshold>(&arg0.performance_thresholds, v0);
            if (arg1 >= v1.business_volume) {
                return v1.weekly_reward
            };
            v0 = v0 + 1;
        };
        0
    }

    public fun calculate_rewards(arg0: &Stake, arg1: u64) : u64 {
        if (arg1 < arg0.start_time) {
            return 0
        };
        let v0 = (arg1 - arg0.start_time) / 2592000000;
        let v1 = v0;
        if (v0 > 12) {
            v1 = 12;
        };
        arg0.amount * arg0.monthly_roi * v1 / 100 - arg0.claimed_rewards
    }

    fun calculate_total_affiliate_rewards(arg0: &Stake) : u64 {
        let v0 = 0;
        let v1 = 0;
        loop {
            let v2 = vector[20, 10, 8, 5, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2];
            if (v1 < 0x1::vector::length<u64>(&v2)) {
                let v3 = vector[20, 10, 8, 5, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2];
                v0 = v0 + arg0.amount * *0x1::vector::borrow<u64>(&v3, v1) / 100;
                v1 = v1 + 1;
            } else {
                break
            };
        };
        v0
    }

    public entry fun claim_performance_bonus<T0>(arg0: &mut StakingPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = get_business_volume<T0>(arg0, v0);
        let v2 = calculate_performance_bonus<T0>(arg0, v1);
        assert!(v2 > 0, 6);
        assert!(0x2::balance::value<T0>(&arg0.rewards_pool) >= v2, 9);
        let v3 = PerformanceBonusClaimed{
            user            : v0,
            business_volume : v1,
            bonus_amount    : v2,
            timestamp       : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<PerformanceBonusClaimed>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.rewards_pool, v2), arg1), v0);
    }

    public entry fun claim_rewards<T0>(arg0: &mut Stake, arg1: &mut StakingPool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 4);
        let v1 = calculate_rewards(arg0, v0);
        assert!(v1 > 0, 6);
        arg0.claimed_rewards = arg0.claimed_rewards + v1;
        let v2 = RewardClaimed{
            stake_id  : 0x2::object::uid_to_inner(&arg0.id),
            owner     : arg0.owner,
            amount    : v1,
            timestamp : v0,
        };
        0x2::event::emit<RewardClaimed>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.rewards_pool, v1), arg3), arg0.owner);
    }

    public fun create_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool<T0>{
            id                     : 0x2::object::new(arg0),
            total_staked           : 0x2::balance::zero<T0>(),
            rewards_pool           : 0x2::balance::zero<T0>(),
            total_stakes           : 0,
            performance_thresholds : init_performance_thresholds(),
        };
        0x2::transfer::share_object<StakingPool<T0>>(v0);
    }

    public entry fun create_stake<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg2 >= 50, 1);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(arg2 <= v1, 1);
        assert!(v0 != arg3, 11);
        if (arg0.total_stakes == 0) {
            assert!(arg3 == @0x0, 10);
        } else if (arg3 != @0x0) {
            assert!(has_active_stakes<T0>(arg0, arg3), 10);
        };
        let v2 = if (arg2 < v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
            0x2::coin::split<T0>(&mut arg1, arg2, arg5)
        } else {
            arg1
        };
        0x2::balance::join<T0>(&mut arg0.total_staked, 0x2::coin::into_balance<T0>(v2));
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = v3 + 12 * 30 * 24 * 60 * 60 * 1000;
        if (arg3 != @0x0) {
            set_user_referrer<T0>(arg0, v0, arg3);
            update_business_volume<T0>(arg0, arg3, arg2, arg5);
            let v5 = get_full_referral_chain<T0>(arg0, arg3, 15);
            let v6 = 0;
            let v7 = arg2;
            while (v6 < 0x1::vector::length<address>(&v5)) {
                if (v6 > 0) {
                    v7 = v7 / 2;
                    if (v7 > 0) {
                        update_business_volume<T0>(arg0, *0x1::vector::borrow<address>(&v5, v6), v7, arg5);
                    };
                };
                v6 = v6 + 1;
            };
        };
        let v8 = if (arg2 <= 1000) {
            5
        } else {
            7
        };
        let v9 = Stake{
            id              : 0x2::object::new(arg5),
            amount          : arg2,
            owner           : v0,
            start_time      : v3,
            maturity_time   : v4,
            monthly_roi     : v8,
            claimed_rewards : 0,
            referrer        : arg3,
            level           : 1,
        };
        assert!(0x2::balance::value<T0>(&arg0.rewards_pool) >= calculate_total_affiliate_rewards(&v9), 9);
        process_affiliate_rewards<T0>(&v9, arg0, arg5);
        arg0.total_stakes = arg0.total_stakes + 1;
        increment_stake_count<T0>(arg0, v0);
        let v10 = StakeCreated{
            stake_id      : 0x2::object::uid_to_inner(&v9.id),
            owner         : v0,
            amount        : arg2,
            start_time    : v3,
            maturity_time : v4,
        };
        0x2::event::emit<StakeCreated>(v10);
        0x2::transfer::transfer<Stake>(v9, v0);
    }

    public fun decrease_stake_count<T0>(arg0: &mut StakingPool<T0>, arg1: address) {
        let v0 = UserStakeKey{user: arg1};
        if (0x2::dynamic_field::exists_<UserStakeKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<UserStakeKey, UserStake>(&mut arg0.id, v0);
            if (v1.stake_count > 0) {
                v1.stake_count = v1.stake_count - 1;
            };
        };
    }

    public entry fun deposit_rewards<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(arg2 <= v0, 1);
        if (arg2 < v0) {
            0x2::balance::join<T0>(&mut arg0.rewards_pool, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg3)));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<T0>(&mut arg0.rewards_pool, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun get_business_volume<T0>(arg0: &StakingPool<T0>, arg1: address) : u64 {
        let v0 = BusinessVolumeKey{user: arg1};
        if (0x2::dynamic_field::exists_<BusinessVolumeKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<BusinessVolumeKey, BusinessVolume>(&arg0.id, v0).amount
        } else {
            0
        }
    }

    public fun get_full_referral_chain<T0>(arg0: &StakingPool<T0>, arg1: address, arg2: u8) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = get_user_referrer<T0>(arg0, arg1);
        let v2 = 0;
        while (v1 != @0x0 && v2 < arg2) {
            0x1::vector::push_back<address>(&mut v0, v1);
            v1 = get_user_referrer<T0>(arg0, v1);
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_pool_info<T0>(arg0: &StakingPool<T0>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.total_staked), 0x2::balance::value<T0>(&arg0.rewards_pool), arg0.total_stakes)
    }

    public fun get_stake_info(arg0: &Stake) : (address, u64, u64, u64, u64) {
        (arg0.owner, arg0.amount, arg0.start_time, arg0.maturity_time, arg0.claimed_rewards)
    }

    public fun get_user_referrer<T0>(arg0: &StakingPool<T0>, arg1: address) : address {
        let v0 = UserReferrerKey{user: arg1};
        if (0x2::dynamic_field::exists_<UserReferrerKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<UserReferrerKey, UserReferrer>(&arg0.id, v0).referrer
        } else {
            @0x0
        }
    }

    public fun has_active_stakes<T0>(arg0: &StakingPool<T0>, arg1: address) : bool {
        let v0 = UserStakeKey{user: arg1};
        if (!0x2::dynamic_field::exists_<UserStakeKey>(&arg0.id, v0)) {
            return false
        };
        0x2::dynamic_field::borrow<UserStakeKey, UserStake>(&arg0.id, v0).stake_count > 0
    }

    fun increment_stake_count<T0>(arg0: &mut StakingPool<T0>, arg1: address) {
        let v0 = UserStakeKey{user: arg1};
        if (!0x2::dynamic_field::exists_<UserStakeKey>(&arg0.id, v0)) {
            init_user_stake<T0>(arg0, arg1);
        };
        let v1 = 0x2::dynamic_field::borrow_mut<UserStakeKey, UserStake>(&mut arg0.id, v0);
        v1.stake_count = v1.stake_count + 1;
    }

    fun init(arg0: STAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = AdminStorage{
            id    : 0x2::object::new(arg1),
            admin : v0,
        };
        0x2::transfer::transfer<AdminCap>(v1, v0);
        0x2::transfer::share_object<AdminStorage>(v2);
    }

    fun init_performance_thresholds() : vector<PerformanceThreshold> {
        let v0 = 0x1::vector::empty<PerformanceThreshold>();
        let v1 = PerformanceThreshold{
            business_volume : 10000,
            weekly_reward   : 10,
        };
        0x1::vector::push_back<PerformanceThreshold>(&mut v0, v1);
        let v2 = PerformanceThreshold{
            business_volume : 30000,
            weekly_reward   : 30,
        };
        0x1::vector::push_back<PerformanceThreshold>(&mut v0, v2);
        let v3 = PerformanceThreshold{
            business_volume : 60000,
            weekly_reward   : 50,
        };
        0x1::vector::push_back<PerformanceThreshold>(&mut v0, v3);
        let v4 = PerformanceThreshold{
            business_volume : 120000,
            weekly_reward   : 100,
        };
        0x1::vector::push_back<PerformanceThreshold>(&mut v0, v4);
        let v5 = PerformanceThreshold{
            business_volume : 225000,
            weekly_reward   : 230,
        };
        0x1::vector::push_back<PerformanceThreshold>(&mut v0, v5);
        let v6 = PerformanceThreshold{
            business_volume : 500000,
            weekly_reward   : 600,
        };
        0x1::vector::push_back<PerformanceThreshold>(&mut v0, v6);
        let v7 = PerformanceThreshold{
            business_volume : 1000000,
            weekly_reward   : 1200,
        };
        0x1::vector::push_back<PerformanceThreshold>(&mut v0, v7);
        let v8 = PerformanceThreshold{
            business_volume : 2500000,
            weekly_reward   : 3000,
        };
        0x1::vector::push_back<PerformanceThreshold>(&mut v0, v8);
        let v9 = PerformanceThreshold{
            business_volume : 5000000,
            weekly_reward   : 6000,
        };
        0x1::vector::push_back<PerformanceThreshold>(&mut v0, v9);
        let v10 = PerformanceThreshold{
            business_volume : 10000000,
            weekly_reward   : 15000,
        };
        0x1::vector::push_back<PerformanceThreshold>(&mut v0, v10);
        let v11 = PerformanceThreshold{
            business_volume : 20000000,
            weekly_reward   : 30000,
        };
        0x1::vector::push_back<PerformanceThreshold>(&mut v0, v11);
        let v12 = PerformanceThreshold{
            business_volume : 50000000,
            weekly_reward   : 70000,
        };
        0x1::vector::push_back<PerformanceThreshold>(&mut v0, v12);
        v0
    }

    fun init_user_stake<T0>(arg0: &mut StakingPool<T0>, arg1: address) {
        let v0 = UserStakeKey{user: arg1};
        if (!0x2::dynamic_field::exists_<UserStakeKey>(&arg0.id, v0)) {
            let v1 = UserStake{stake_count: 0};
            0x2::dynamic_field::add<UserStakeKey, UserStake>(&mut arg0.id, v0, v1);
        };
    }

    fun is_admin(arg0: &AdminCap, arg1: &AdminStorage) : bool {
        0x2::object::uid_to_address(&arg0.id) == arg1.admin
    }

    fun process_affiliate_rewards<T0>(arg0: &Stake, arg1: &mut StakingPool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.rewards_pool) >= calculate_total_affiliate_rewards(arg0), 9);
        let v0 = arg0.referrer;
        let v1 = 0;
        loop {
            let v2 = vector[20, 10, 8, 5, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2];
            if (v1 < 0x1::vector::length<u64>(&v2) && v0 != @0x0) {
                let v3 = vector[20, 10, 8, 5, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2];
                let v4 = arg0.amount * *0x1::vector::borrow<u64>(&v3, v1) / 100;
                if (v4 > 0) {
                    assert!(0x2::balance::value<T0>(&arg1.rewards_pool) >= v4, 9);
                    let v5 = AffiliateRewardPaid{
                        from_stake : 0x2::object::uid_to_inner(&arg0.id),
                        referrer   : v0,
                        amount     : v4,
                        level      : (v1 as u8),
                    };
                    0x2::event::emit<AffiliateRewardPaid>(v5);
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.rewards_pool, v4), arg2), v0);
                    v0 = get_user_referrer<T0>(arg1, v0);
                    if (v0 == @0x0) {
                        break
                    };
                };
                v1 = v1 + 1;
            } else {
                break
            };
        };
    }

    public fun set_user_referrer<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: address) {
        let v0 = UserReferrerKey{user: arg1};
        if (0x2::dynamic_field::exists_<UserReferrerKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<UserReferrerKey, UserReferrer>(&mut arg0.id, v0);
        };
        let v1 = UserReferrer{referrer: arg2};
        0x2::dynamic_field::add<UserReferrerKey, UserReferrer>(&mut arg0.id, v0, v1);
    }

    public fun update_business_volume<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = BusinessVolumeKey{user: arg1};
        let v1 = if (0x2::dynamic_field::exists_<BusinessVolumeKey>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_field::remove<BusinessVolumeKey, BusinessVolume>(&mut arg0.id, v0);
            v2.amount
        } else {
            0
        };
        let v3 = v1 + arg2;
        let v4 = BusinessVolume{amount: v3};
        0x2::dynamic_field::add<BusinessVolumeKey, BusinessVolume>(&mut arg0.id, v0, v4);
        let v5 = BusinessVolumeUpdated{
            user       : arg1,
            old_volume : v1,
            new_volume : v3,
            timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<BusinessVolumeUpdated>(v5);
    }

    // decompiled from Move bytecode v6
}

