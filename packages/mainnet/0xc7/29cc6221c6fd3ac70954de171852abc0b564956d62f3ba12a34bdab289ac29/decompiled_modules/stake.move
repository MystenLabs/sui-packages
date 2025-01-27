module 0x9b7e4baeb2d8866d55d8b4bae0ba47644a8ec846181b4a278c181243b4a7d53::stake {
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

    struct ReferralRewardPaid has copy, drop {
        from_stake: 0x2::object::ID,
        referrer: address,
        amount: u64,
        level: u8,
        timestamp: u64,
    }

    struct AffiliateRoiRewardPaid has copy, drop {
        from_stake: 0x2::object::ID,
        stake_amount: u64,
        monthly_roi_amount: u64,
        referrer: address,
        reward_amount: u64,
        level: u8,
        timestamp: u64,
    }

    struct StakeUnstaked has copy, drop {
        stake_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        timestamp: u64,
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
        last_roi_distribution: u64,
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

    struct UserRewards has store, key {
        id: 0x2::object::UID,
        owner: address,
        total_referral_rewards: u64,
        total_affiliate_rewards: u64,
        total_performance_rewards: u64,
        referral_rewards_history: vector<ReferralReward>,
        affiliate_rewards_history: vector<AffiliateReward>,
        performance_rewards_history: vector<PerformanceReward>,
    }

    struct ReferralReward has store {
        amount: u64,
        from_stake: 0x2::object::ID,
        level: u8,
        timestamp: u64,
    }

    struct AffiliateReward has store {
        amount: u64,
        from_stake: 0x2::object::ID,
        monthly_roi_amount: u64,
        level: u8,
        timestamp: u64,
    }

    struct PerformanceReward has store {
        amount: u64,
        business_volume: u64,
        timestamp: u64,
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

    public fun add_affiliate_reward(arg0: &mut UserRewards, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: u8, arg5: u64) {
        arg0.total_affiliate_rewards = arg0.total_affiliate_rewards + arg1;
        let v0 = AffiliateReward{
            amount             : arg1,
            from_stake         : arg2,
            monthly_roi_amount : arg3,
            level              : arg4,
            timestamp          : arg5,
        };
        0x1::vector::push_back<AffiliateReward>(&mut arg0.affiliate_rewards_history, v0);
    }

    public fun add_performance_reward(arg0: &mut UserRewards, arg1: u64, arg2: u64, arg3: u64) {
        arg0.total_performance_rewards = arg0.total_performance_rewards + arg1;
        let v0 = PerformanceReward{
            amount          : arg1,
            business_volume : arg2,
            timestamp       : arg3,
        };
        0x1::vector::push_back<PerformanceReward>(&mut arg0.performance_rewards_history, v0);
    }

    public fun add_referral_reward(arg0: &mut UserRewards, arg1: u64, arg2: 0x2::object::ID, arg3: u8, arg4: u64) {
        arg0.total_referral_rewards = arg0.total_referral_rewards + arg1;
        let v0 = ReferralReward{
            amount     : arg1,
            from_stake : arg2,
            level      : arg3,
            timestamp  : arg4,
        };
        0x1::vector::push_back<ReferralReward>(&mut arg0.referral_rewards_history, v0);
    }

    public entry fun admin_withdraw<T0>(arg0: &mut StakingPool<T0>, arg1: u64, arg2: &AdminCap, arg3: &AdminStorage, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg2, arg3, arg5), 7);
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.total_staked), 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_staked, arg1), arg5), arg4);
    }

    public entry fun admin_withdraw_rewards<T0>(arg0: &mut StakingPool<T0>, arg1: u64, arg2: &AdminCap, arg3: &AdminStorage, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg2, arg3, arg5), 7);
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.rewards_pool), 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.rewards_pool, arg1), arg5), arg4);
    }

    fun calculate_monthly_roi(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 100
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

    fun calculate_referral_rewards(arg0: &Stake) : u64 {
        let v0 = 0;
        let v1 = 0;
        loop {
            let v2 = vector[2, 2, 1];
            if (v1 < 0x1::vector::length<u64>(&v2)) {
                let v3 = vector[2, 2, 1];
                v0 = v0 + arg0.amount * *0x1::vector::borrow<u64>(&v3, v1) / 100;
                v1 = v1 + 1;
            } else {
                break
            };
        };
        v0
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

    fun calculate_roi_affiliate_reward(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 100
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
        assert!(is_month_passed(v0, arg0.last_roi_distribution), 6);
        let v1 = calculate_monthly_roi(arg0.amount, arg0.monthly_roi);
        process_roi_affiliate_rewards<T0>(arg0, arg1, v1, v0, arg3);
        arg0.claimed_rewards = arg0.claimed_rewards + v1;
        arg0.last_roi_distribution = v0;
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
        0x2::dynamic_field::add<vector<u8>, 0x2::table::Table<address, UserRewards>>(&mut v0.id, b"user_rewards", 0x2::table::new<address, UserRewards>(arg0));
        0x2::transfer::share_object<StakingPool<T0>>(v0);
    }

    public entry fun create_stake<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg2 >= 1000, 1);
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
        let v5 = if (arg2 < 20000) {
            5
        } else {
            7
        };
        let v6 = Stake{
            id                    : 0x2::object::new(arg5),
            amount                : arg2,
            owner                 : v0,
            start_time            : v3,
            maturity_time         : v4,
            monthly_roi           : v5,
            claimed_rewards       : 0,
            referrer              : arg3,
            level                 : 1,
            last_roi_distribution : v3,
        };
        if (arg3 != @0x0) {
            set_user_referrer<T0>(arg0, v0, arg3);
            update_business_volume<T0>(arg0, arg3, arg2, arg5);
            let v7 = get_full_referral_chain<T0>(arg0, arg3, 15);
            let v8 = 0;
            let v9 = arg2;
            while (v8 < 0x1::vector::length<address>(&v7)) {
                if (v8 > 0) {
                    v9 = v9 / 2;
                    if (v9 > 0) {
                        update_business_volume<T0>(arg0, *0x1::vector::borrow<address>(&v7, v8), v9, arg5);
                    };
                };
                v8 = v8 + 1;
            };
            assert!(0x2::balance::value<T0>(&arg0.rewards_pool) >= calculate_total_affiliate_rewards(&v6) + calculate_referral_rewards(&v6), 9);
            process_affiliate_rewards<T0>(&v6, arg0, arg5);
            process_referral_rewards<T0>(&v6, arg0, arg5);
        };
        arg0.total_stakes = arg0.total_stakes + 1;
        increment_stake_count<T0>(arg0, v0);
        let v10 = StakeCreated{
            stake_id      : 0x2::object::uid_to_inner(&v6.id),
            owner         : v0,
            amount        : arg2,
            start_time    : v3,
            maturity_time : v4,
        };
        0x2::event::emit<StakeCreated>(v10);
        0x2::transfer::transfer<Stake>(v6, v0);
    }

    public fun create_user_rewards(arg0: &mut 0x2::tx_context::TxContext) : UserRewards {
        UserRewards{
            id                          : 0x2::object::new(arg0),
            owner                       : 0x2::tx_context::sender(arg0),
            total_referral_rewards      : 0,
            total_affiliate_rewards     : 0,
            total_performance_rewards   : 0,
            referral_rewards_history    : 0x1::vector::empty<ReferralReward>(),
            affiliate_rewards_history   : 0x1::vector::empty<AffiliateReward>(),
            performance_rewards_history : 0x1::vector::empty<PerformanceReward>(),
        }
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

    public fun get_total_rewards(arg0: &UserRewards) : (u64, u64, u64) {
        (arg0.total_referral_rewards, arg0.total_affiliate_rewards, arg0.total_performance_rewards)
    }

    public fun get_user_referrer<T0>(arg0: &StakingPool<T0>, arg1: address) : address {
        let v0 = UserReferrerKey{user: arg1};
        if (0x2::dynamic_field::exists_<UserReferrerKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<UserReferrerKey, UserReferrer>(&arg0.id, v0).referrer
        } else {
            @0x0
        }
    }

    public fun get_user_rewards<T0>(arg0: &StakingPool<T0>, arg1: address) : &UserRewards {
        0x2::dynamic_field::borrow<address, UserRewards>(&arg0.id, arg1)
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

    fun is_admin(arg0: &AdminCap, arg1: &AdminStorage, arg2: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::sender(arg2) == 0x2::tx_context::sender(arg2)
    }

    fun is_month_passed(arg0: u64, arg1: u64) : bool {
        arg0 >= arg1 + 2592000000
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

    fun process_referral_rewards<T0>(arg0: &Stake, arg1: &mut StakingPool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.referrer;
        let v1 = 0;
        let v2 = 0x2::tx_context::epoch(arg2);
        loop {
            let v3 = vector[2, 2, 1];
            if (v1 < 0x1::vector::length<u64>(&v3) && v0 != @0x0) {
                let v4 = vector[2, 2, 1];
                let v5 = arg0.amount * *0x1::vector::borrow<u64>(&v4, v1) / 100;
                if (v5 > 0) {
                    assert!(0x2::balance::value<T0>(&arg1.rewards_pool) >= v5, 9);
                    let v6 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::table::Table<address, UserRewards>>(&mut arg1.id, b"user_rewards");
                    if (!0x2::table::contains<address, UserRewards>(v6, v0)) {
                        let v7 = UserRewards{
                            id                          : 0x2::object::new(arg2),
                            owner                       : v0,
                            total_referral_rewards      : 0,
                            total_affiliate_rewards     : 0,
                            total_performance_rewards   : 0,
                            referral_rewards_history    : 0x1::vector::empty<ReferralReward>(),
                            affiliate_rewards_history   : 0x1::vector::empty<AffiliateReward>(),
                            performance_rewards_history : 0x1::vector::empty<PerformanceReward>(),
                        };
                        0x2::table::add<address, UserRewards>(v6, v0, v7);
                    };
                    let v8 = 0x2::table::borrow_mut<address, UserRewards>(v6, v0);
                    add_referral_reward(v8, v5, 0x2::object::uid_to_inner(&arg0.id), (v1 as u8), v2);
                    let v9 = ReferralRewardPaid{
                        from_stake : 0x2::object::uid_to_inner(&arg0.id),
                        referrer   : v0,
                        amount     : v5,
                        level      : (v1 as u8),
                        timestamp  : v2,
                    };
                    0x2::event::emit<ReferralRewardPaid>(v9);
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.rewards_pool, v5), arg2), v0);
                    v0 = get_user_referrer<T0>(arg1, v0);
                };
                v1 = v1 + 1;
            } else {
                break
            };
        };
    }

    fun process_roi_affiliate_rewards<T0>(arg0: &Stake, arg1: &mut StakingPool<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.referrer;
        let v1 = 0;
        loop {
            let v2 = vector[20, 10, 8, 5, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2];
            if (v1 < 0x1::vector::length<u64>(&v2) && v0 != @0x0) {
                let v3 = vector[20, 10, 8, 5, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2];
                let v4 = calculate_roi_affiliate_reward(arg2, *0x1::vector::borrow<u64>(&v3, v1));
                if (v4 > 0) {
                    assert!(0x2::balance::value<T0>(&arg1.rewards_pool) >= v4, 9);
                    let v5 = AffiliateRoiRewardPaid{
                        from_stake         : 0x2::object::uid_to_inner(&arg0.id),
                        stake_amount       : arg0.amount,
                        monthly_roi_amount : arg2,
                        referrer           : v0,
                        reward_amount      : v4,
                        level              : (v1 as u8),
                        timestamp          : arg3,
                    };
                    0x2::event::emit<AffiliateRoiRewardPaid>(v5);
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.rewards_pool, v4), arg4), v0);
                    v0 = get_user_referrer<T0>(arg1, v0);
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

    public entry fun unstake<T0>(arg0: Stake, arg1: &mut StakingPool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(arg0.owner == v1, 4);
        assert!(v0 >= arg0.maturity_time, 12);
        let v2 = arg0.amount;
        let v3 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.total_staked, v2), arg3);
        decrease_stake_count<T0>(arg1, v1);
        let v4 = StakeUnstaked{
            stake_id  : 0x2::object::uid_to_inner(&arg0.id),
            owner     : v1,
            amount    : v2,
            timestamp : v0,
        };
        0x2::event::emit<StakeUnstaked>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v1);
        let Stake {
            id                    : v5,
            amount                : _,
            owner                 : _,
            start_time            : _,
            maturity_time         : _,
            monthly_roi           : _,
            claimed_rewards       : _,
            referrer              : _,
            level                 : _,
            last_roi_distribution : _,
        } = arg0;
        0x2::object::delete(v5);
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

