module 0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardTier has copy, drop, store {
        min_price_usd_cents: u64,
        post_reward: u64,
        like_reward: u64,
        comment_reward: u64,
        streak_reward: u64,
    }

    struct DailyRecord has drop, store {
        epoch: u64,
        total_earned: u64,
        posts_rewarded: u8,
        likes_rewarded: u8,
        comments_rewarded: u8,
        streak_claimed: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>,
        tiers: vector<RewardTier>,
        active_tier: u8,
        daily_records: 0x2::table::Table<address, DailyRecord>,
        total_distributed: u64,
        total_recycled: u64,
    }

    struct TreasuryDeposit has copy, drop {
        amount: u64,
        new_balance: u64,
    }

    struct RewardDistributed has copy, drop {
        recipient: address,
        amount: u64,
        reason: vector<u8>,
    }

    struct TierChanged has copy, drop {
        old_tier: u8,
        new_tier: u8,
    }

    struct BoostPurchased has copy, drop {
        post_id: 0x2::object::ID,
        buyer: address,
        tier: u8,
        duration_hours: u8,
        amount_paid: u64,
    }

    struct TrendingPurchased has copy, drop {
        post_id: 0x2::object::ID,
        buyer: address,
        tier: u8,
        duration_hours: u8,
        amount_paid: u64,
    }

    struct StreakClaimed has copy, drop {
        user: address,
        amount: u64,
        epoch: u64,
    }

    public fun balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg0.balance)
    }

    public fun active_tier(arg0: &Treasury) : u8 {
        arg0.active_tier
    }

    fun apply_holding_multiplier(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= 1000000000000000) {
            arg0 * 2
        } else if (arg1 >= 250000000000000) {
            arg0 + arg0 / 2
        } else if (arg1 >= 50000000000000) {
            arg0 + arg0 / 4
        } else {
            arg0
        }
    }

    fun boost_cost(arg0: u8) : (u64, u8) {
        if (arg0 == 0) {
            (200000000000, 6)
        } else if (arg0 == 1) {
            (500000000000, 12)
        } else {
            assert!(arg0 == 2, 2);
            (1000000000000, 24)
        }
    }

    public fun claim_streak_reward(arg0: &mut Treasury, arg1: &0x2::coin::Coin<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::tx_context::epoch(arg2);
        let v2 = 0x2::coin::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(arg1);
        let v3 = get_daily_cap(v2);
        let v4 = *0x1::vector::borrow<RewardTier>(&arg0.tiers, (arg0.active_tier as u64));
        ensure_daily_record(arg0, v0, v1);
        let v5 = 0x2::table::borrow_mut<address, DailyRecord>(&mut arg0.daily_records, v0);
        assert!(!v5.streak_claimed, 5);
        let v6 = if (v3 > v5.total_earned) {
            v3 - v5.total_earned
        } else {
            0
        };
        if (v6 == 0) {
            return
        };
        let v7 = apply_holding_multiplier(v4.streak_reward, v2);
        let v8 = if (v7 <= v6) {
            v7
        } else {
            v6
        };
        v5.streak_claimed = true;
        v5.total_earned = v5.total_earned + v8;
        pay_reward(arg0, v0, v8, b"daily_streak", arg2);
        let v9 = StreakClaimed{
            user   : v0,
            amount : v8,
            epoch  : v1,
        };
        0x2::event::emit<StreakClaimed>(v9);
    }

    public fun daily_comments_rewarded(arg0: &Treasury, arg1: address) : u8 {
        if (0x2::table::contains<address, DailyRecord>(&arg0.daily_records, arg1)) {
            0x2::table::borrow<address, DailyRecord>(&arg0.daily_records, arg1).comments_rewarded
        } else {
            0
        }
    }

    public fun daily_earned(arg0: &Treasury, arg1: address) : u64 {
        if (0x2::table::contains<address, DailyRecord>(&arg0.daily_records, arg1)) {
            0x2::table::borrow<address, DailyRecord>(&arg0.daily_records, arg1).total_earned
        } else {
            0
        }
    }

    public fun daily_likes_rewarded(arg0: &Treasury, arg1: address) : u8 {
        if (0x2::table::contains<address, DailyRecord>(&arg0.daily_records, arg1)) {
            0x2::table::borrow<address, DailyRecord>(&arg0.daily_records, arg1).likes_rewarded
        } else {
            0
        }
    }

    public fun daily_posts_rewarded(arg0: &Treasury, arg1: address) : u8 {
        if (0x2::table::contains<address, DailyRecord>(&arg0.daily_records, arg1)) {
            0x2::table::borrow<address, DailyRecord>(&arg0.daily_records, arg1).posts_rewarded
        } else {
            0
        }
    }

    public fun deposit(arg0: &AdminCap, arg1: &mut Treasury, arg2: 0x2::coin::Coin<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>) {
        0x2::balance::join<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&mut arg1.balance, 0x2::coin::into_balance<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(arg2));
        let v0 = TreasuryDeposit{
            amount      : 0x2::coin::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg2),
            new_balance : 0x2::balance::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg1.balance),
        };
        0x2::event::emit<TreasuryDeposit>(v0);
    }

    public(friend) fun distribute_comment_reward(arg0: &mut Treasury, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_daily_cap(arg2);
        let v1 = *0x1::vector::borrow<RewardTier>(&arg0.tiers, (arg0.active_tier as u64));
        ensure_daily_record(arg0, arg1, 0x2::tx_context::epoch(arg3));
        let v2 = 0x2::table::borrow_mut<address, DailyRecord>(&mut arg0.daily_records, arg1);
        if (v2.comments_rewarded >= 10) {
            return
        };
        if (v2.total_earned >= v0) {
            return
        };
        let v3 = v0 - v2.total_earned;
        let v4 = apply_holding_multiplier(v1.comment_reward, arg2);
        let v5 = if (v4 <= v3) {
            v4
        } else {
            v3
        };
        v2.comments_rewarded = v2.comments_rewarded + 1;
        v2.total_earned = v2.total_earned + v5;
        pay_reward(arg0, arg1, v5, b"comment_received", arg3);
    }

    public(friend) fun distribute_like_reward(arg0: &mut Treasury, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_daily_cap(arg2);
        let v1 = *0x1::vector::borrow<RewardTier>(&arg0.tiers, (arg0.active_tier as u64));
        ensure_daily_record(arg0, arg1, 0x2::tx_context::epoch(arg3));
        let v2 = 0x2::table::borrow_mut<address, DailyRecord>(&mut arg0.daily_records, arg1);
        if (v2.likes_rewarded >= 20) {
            return
        };
        if (v2.total_earned >= v0) {
            return
        };
        let v3 = v0 - v2.total_earned;
        let v4 = apply_holding_multiplier(v1.like_reward, arg2);
        let v5 = if (v4 <= v3) {
            v4
        } else {
            v3
        };
        v2.likes_rewarded = v2.likes_rewarded + 1;
        v2.total_earned = v2.total_earned + v5;
        pay_reward(arg0, arg1, v5, b"like_received", arg3);
    }

    public(friend) fun distribute_post_reward(arg0: &mut Treasury, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_daily_cap(arg2);
        let v1 = *0x1::vector::borrow<RewardTier>(&arg0.tiers, (arg0.active_tier as u64));
        ensure_daily_record(arg0, arg1, 0x2::tx_context::epoch(arg3));
        let v2 = 0x2::table::borrow_mut<address, DailyRecord>(&mut arg0.daily_records, arg1);
        if (v2.posts_rewarded >= 3) {
            return
        };
        if (v2.total_earned >= v0) {
            return
        };
        let v3 = v0 - v2.total_earned;
        let v4 = apply_holding_multiplier(v1.post_reward, arg2);
        let v5 = if (v4 <= v3) {
            v4
        } else {
            v3
        };
        v2.posts_rewarded = v2.posts_rewarded + 1;
        v2.total_earned = v2.total_earned + v5;
        pay_reward(arg0, arg1, v5, b"post_created", arg3);
    }

    fun ensure_daily_record(arg0: &mut Treasury, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, DailyRecord>(&arg0.daily_records, arg1)) {
            let v0 = DailyRecord{
                epoch             : arg2,
                total_earned      : 0,
                posts_rewarded    : 0,
                likes_rewarded    : 0,
                comments_rewarded : 0,
                streak_claimed    : false,
            };
            0x2::table::add<address, DailyRecord>(&mut arg0.daily_records, arg1, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<address, DailyRecord>(&mut arg0.daily_records, arg1);
            if (v1.epoch != arg2) {
                v1.epoch = arg2;
                v1.total_earned = 0;
                v1.posts_rewarded = 0;
                v1.likes_rewarded = 0;
                v1.comments_rewarded = 0;
                v1.streak_claimed = false;
            };
        };
    }

    fun get_daily_cap(arg0: u64) : u64 {
        if (arg0 >= 1000000000000000) {
            2000000000000
        } else if (arg0 >= 250000000000000) {
            750000000000
        } else if (arg0 >= 50000000000000) {
            400000000000
        } else {
            250000000000
        }
    }

    public fun get_tier(arg0: &Treasury, arg1: u8) : RewardTier {
        *0x1::vector::borrow<RewardTier>(&arg0.tiers, (arg1 as u64))
    }

    public fun holding_multiplier_bps(arg0: u64) : u64 {
        if (arg0 >= 1000000000000000) {
            20000
        } else if (arg0 >= 250000000000000) {
            15000
        } else if (arg0 >= 50000000000000) {
            12500
        } else {
            10000
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = 0x1::vector::empty<RewardTier>();
        let v2 = RewardTier{
            min_price_usd_cents : 0,
            post_reward         : 50000000000,
            like_reward         : 5000000000,
            comment_reward      : 10000000000,
            streak_reward       : 25000000000,
        };
        0x1::vector::push_back<RewardTier>(&mut v1, v2);
        let v3 = RewardTier{
            min_price_usd_cents : 10,
            post_reward         : 20000000000,
            like_reward         : 2000000000,
            comment_reward      : 4000000000,
            streak_reward       : 10000000000,
        };
        0x1::vector::push_back<RewardTier>(&mut v1, v3);
        let v4 = RewardTier{
            min_price_usd_cents : 50,
            post_reward         : 10000000000,
            like_reward         : 1000000000,
            comment_reward      : 2000000000,
            streak_reward       : 5000000000,
        };
        0x1::vector::push_back<RewardTier>(&mut v1, v4);
        let v5 = RewardTier{
            min_price_usd_cents : 100,
            post_reward         : 2000000000,
            like_reward         : 500000000,
            comment_reward      : 1000000000,
            streak_reward       : 2000000000,
        };
        0x1::vector::push_back<RewardTier>(&mut v1, v5);
        let v6 = RewardTier{
            min_price_usd_cents : 500,
            post_reward         : 1000000000,
            like_reward         : 200000000,
            comment_reward      : 500000000,
            streak_reward       : 1000000000,
        };
        0x1::vector::push_back<RewardTier>(&mut v1, v6);
        let v7 = RewardTier{
            min_price_usd_cents : 1000,
            post_reward         : 500000000,
            like_reward         : 100000000,
            comment_reward      : 200000000,
            streak_reward       : 500000000,
        };
        0x1::vector::push_back<RewardTier>(&mut v1, v7);
        let v8 = Treasury{
            id                : 0x2::object::new(arg0),
            balance           : 0x2::balance::zero<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(),
            tiers             : v1,
            active_tier       : 0,
            daily_records     : 0x2::table::new<address, DailyRecord>(arg0),
            total_distributed : 0,
            total_recycled    : 0,
        };
        0x2::transfer::share_object<Treasury>(v8);
    }

    fun pay_reward(arg0: &mut Treasury, arg1: address, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg0.balance);
        if (v0 == 0 || arg2 == 0) {
            return
        };
        let v1 = if (arg2 <= v0) {
            arg2
        } else {
            v0
        };
        arg0.total_distributed = arg0.total_distributed + v1;
        let v2 = RewardDistributed{
            recipient : arg1,
            amount    : v1,
            reason    : arg3,
        };
        0x2::event::emit<RewardDistributed>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>>(0x2::coin::from_balance<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(0x2::balance::split<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&mut arg0.balance, v1), arg4), arg1);
    }

    public fun purchase_boost(arg0: &mut Treasury, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::coin::Coin<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = boost_cost(arg2);
        assert!(0x2::coin::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg3) == v0, 4);
        let v2 = 0x2::coin::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg3);
        0x2::balance::join<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&mut arg0.balance, 0x2::coin::into_balance<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(arg3));
        arg0.total_recycled = arg0.total_recycled + v2;
        let v3 = BoostPurchased{
            post_id        : arg1,
            buyer          : 0x2::tx_context::sender(arg4),
            tier           : arg2,
            duration_hours : v1,
            amount_paid    : v2,
        };
        0x2::event::emit<BoostPurchased>(v3);
    }

    public fun purchase_trending(arg0: &mut Treasury, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::coin::Coin<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = trending_cost(arg2);
        assert!(0x2::coin::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg3) == v0, 4);
        let v2 = 0x2::coin::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg3);
        0x2::balance::join<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&mut arg0.balance, 0x2::coin::into_balance<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(arg3));
        arg0.total_recycled = arg0.total_recycled + v2;
        let v3 = TrendingPurchased{
            post_id        : arg1,
            buyer          : 0x2::tx_context::sender(arg4),
            tier           : arg2,
            duration_hours : v1,
            amount_paid    : v2,
        };
        0x2::event::emit<TrendingPurchased>(v3);
    }

    public(friend) fun recycle_ad_revenue(arg0: &mut Treasury, arg1: 0x2::balance::Balance<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>) {
        0x2::balance::join<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&mut arg0.balance, arg1);
        arg0.total_recycled = arg0.total_recycled + 0x2::balance::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg1);
    }

    public fun set_active_tier(arg0: &AdminCap, arg1: &mut Treasury, arg2: u8) {
        assert!((arg2 as u64) < 0x1::vector::length<RewardTier>(&arg1.tiers), 1);
        arg1.active_tier = arg2;
        let v0 = TierChanged{
            old_tier : arg1.active_tier,
            new_tier : arg2,
        };
        0x2::event::emit<TierChanged>(v0);
    }

    public fun streak_claimed_today(arg0: &Treasury, arg1: address) : bool {
        0x2::table::contains<address, DailyRecord>(&arg0.daily_records, arg1) && 0x2::table::borrow<address, DailyRecord>(&arg0.daily_records, arg1).streak_claimed
    }

    public fun tier_count(arg0: &Treasury) : u64 {
        0x1::vector::length<RewardTier>(&arg0.tiers)
    }

    public fun total_distributed(arg0: &Treasury) : u64 {
        arg0.total_distributed
    }

    public fun total_recycled(arg0: &Treasury) : u64 {
        arg0.total_recycled
    }

    fun trending_cost(arg0: u8) : (u64, u8) {
        if (arg0 == 0) {
            (2000000000000, 12)
        } else {
            assert!(arg0 == 1, 3);
            (5000000000000, 24)
        }
    }

    public fun withdraw(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY> {
        0x2::coin::from_balance<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(0x2::balance::split<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&mut arg1.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

