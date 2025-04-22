module 0x350b924bb4f2ecd8b880f88b5e410a044b0fd97feec2d7d48b0ddabe0dfbcd6f::boss_raid_reward {
    struct RewardPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        daily_rewards: 0x2::table::Table<u64, u64>,
        rank_ranges: vector<RankRange>,
        user_ranks: 0x2::table::Table<u64, UserRankData>,
        claimed_rewards: 0x2::table::Table<u64, vector<address>>,
    }

    struct RankRange has copy, drop, store {
        start_rank: u64,
        end_rank: u64,
        portion: u64,
    }

    struct UserRankData has store {
        user_ranks: 0x2::table::Table<address, u64>,
    }

    struct DailyRewardSet has copy, drop {
        date: u64,
        amount: u64,
    }

    struct RankRangeSet has copy, drop {
        start_rank: u64,
        end_rank: u64,
        portion: u64,
    }

    struct UserRankSet has copy, drop {
        date: u64,
        user: address,
        rank: u64,
    }

    struct RewardClaimed has copy, drop {
        date: u64,
        user: address,
        amount: u64,
    }

    public entry fun claim_reward(arg0: &mut RewardPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<u64, u64>(&arg0.daily_rewards, arg1), 5);
        assert!(0x2::table::contains<u64, UserRankData>(&arg0.user_ranks, arg1), 5);
        let (v1, v2) = get_user_rank(arg0, arg1, v0);
        assert!(v1, 6);
        assert!(!is_reward_claimed(arg0, arg1, v0), 7);
        let v3 = get_rank_portion(arg0, v2);
        assert!(v3 > 0, 8);
        let v4 = *0x2::table::borrow<u64, u64>(&arg0.daily_rewards, arg1) * v3 / 10000;
        assert!(v4 > 0, 8);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v4, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v4, arg2), v0);
        0x1::vector::push_back<address>(0x2::table::borrow_mut<u64, vector<address>>(&mut arg0.claimed_rewards, arg1), v0);
        let v5 = RewardClaimed{
            date   : arg1,
            user   : v0,
            amount : v4,
        };
        0x2::event::emit<RewardClaimed>(v5);
    }

    public entry fun deposit(arg0: &mut RewardPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public fun get_balance(arg0: &RewardPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_daily_reward(arg0: &RewardPool, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.daily_rewards, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.daily_rewards, arg1)
        } else {
            0
        }
    }

    public fun get_rank_portion(arg0: &RewardPool, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<RankRange>(&arg0.rank_ranges)) {
            let v1 = 0x1::vector::borrow<RankRange>(&arg0.rank_ranges, v0);
            if (arg1 >= v1.start_rank && arg1 <= v1.end_rank) {
                return v1.portion
            };
            v0 = v0 + 1;
        };
        0
    }

    public fun get_user_rank(arg0: &RewardPool, arg1: u64, arg2: address) : (bool, u64) {
        if (!0x2::table::contains<u64, UserRankData>(&arg0.user_ranks, arg1)) {
            return (false, 0)
        };
        let v0 = 0x2::table::borrow<u64, UserRankData>(&arg0.user_ranks, arg1);
        if (!0x2::table::contains<address, u64>(&v0.user_ranks, arg2)) {
            return (false, 0)
        };
        (true, *0x2::table::borrow<address, u64>(&v0.user_ranks, arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPool{
            id              : 0x2::object::new(arg0),
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            admin           : 0x2::tx_context::sender(arg0),
            daily_rewards   : 0x2::table::new<u64, u64>(arg0),
            rank_ranges     : 0x1::vector::empty<RankRange>(),
            user_ranks      : 0x2::table::new<u64, UserRankData>(arg0),
            claimed_rewards : 0x2::table::new<u64, vector<address>>(arg0),
        };
        0x2::transfer::share_object<RewardPool>(v0);
    }

    public fun is_reward_claimed(arg0: &RewardPool, arg1: u64, arg2: address) : bool {
        if (!0x2::table::contains<u64, vector<address>>(&arg0.claimed_rewards, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<u64, vector<address>>(&arg0.claimed_rewards, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(v0)) {
            if (*0x1::vector::borrow<address>(v0, v1) == arg2) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public entry fun set_daily_reward(arg0: &mut RewardPool, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        if (0x2::table::contains<u64, u64>(&arg0.daily_rewards, arg1)) {
            *0x2::table::borrow_mut<u64, u64>(&mut arg0.daily_rewards, arg1) = arg2;
        } else {
            0x2::table::add<u64, u64>(&mut arg0.daily_rewards, arg1, arg2);
        };
        let v0 = DailyRewardSet{
            date   : arg1,
            amount : arg2,
        };
        0x2::event::emit<DailyRewardSet>(v0);
    }

    public entry fun set_rank_range(arg0: &mut RewardPool, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        assert!(arg1 <= arg2, 3);
        assert!(arg3 <= 10000, 2);
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        while (v0 < 0x1::vector::length<RankRange>(&arg0.rank_ranges)) {
            let v3 = 0x1::vector::borrow<RankRange>(&arg0.rank_ranges, v0);
            if (v3.start_rank == arg1 && v3.end_rank == arg2) {
                v1 = true;
                v2 = v0;
                break
            };
            let v4 = arg1 <= v3.end_rank && arg2 >= v3.start_rank || v3.start_rank <= arg2 && v3.end_rank >= arg1;
            assert!(!v4, 4);
            v0 = v0 + 1;
        };
        let v5 = RankRange{
            start_rank : arg1,
            end_rank   : arg2,
            portion    : arg3,
        };
        if (v1) {
            *0x1::vector::borrow_mut<RankRange>(&mut arg0.rank_ranges, v2) = v5;
        } else {
            0x1::vector::push_back<RankRange>(&mut arg0.rank_ranges, v5);
        };
        let v6 = RankRangeSet{
            start_rank : arg1,
            end_rank   : arg2,
            portion    : arg3,
        };
        0x2::event::emit<RankRangeSet>(v6);
    }

    public entry fun set_rank_ranges_batch(arg0: &mut RewardPool, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        let v0 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 0);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 0);
        arg0.rank_ranges = 0x1::vector::empty<RankRange>();
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v1);
            let v3 = *0x1::vector::borrow<u64>(&arg2, v1);
            let v4 = *0x1::vector::borrow<u64>(&arg3, v1);
            assert!(v2 <= v3, 3);
            assert!(v4 <= 10000, 2);
            let v5 = 0;
            while (v5 < v1) {
                let v6 = *0x1::vector::borrow<u64>(&arg1, v5);
                let v7 = *0x1::vector::borrow<u64>(&arg2, v5);
                let v8 = v2 <= v7 && v3 >= v6 || v6 <= v3 && v7 >= v2;
                assert!(!v8, 4);
                v5 = v5 + 1;
            };
            let v9 = RankRange{
                start_rank : v2,
                end_rank   : v3,
                portion    : v4,
            };
            0x1::vector::push_back<RankRange>(&mut arg0.rank_ranges, v9);
            let v10 = RankRangeSet{
                start_rank : v2,
                end_rank   : v3,
                portion    : v4,
            };
            0x2::event::emit<RankRangeSet>(v10);
            v1 = v1 + 1;
        };
    }

    public entry fun set_user_ranks(arg0: &mut RewardPool, arg1: u64, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 0);
        let v1 = UserRankData{user_ranks: 0x2::table::new<address, u64>(arg4)};
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<address>(&arg2, v2);
            let v4 = *0x1::vector::borrow<u64>(&arg3, v2);
            0x2::table::add<address, u64>(&mut v1.user_ranks, v3, v4);
            let v5 = UserRankSet{
                date : arg1,
                user : v3,
                rank : v4,
            };
            0x2::event::emit<UserRankSet>(v5);
            v2 = v2 + 1;
        };
        if (0x2::table::contains<u64, UserRankData>(&arg0.user_ranks, arg1)) {
            let UserRankData { user_ranks: v6 } = 0x2::table::remove<u64, UserRankData>(&mut arg0.user_ranks, arg1);
            0x2::table::drop<address, u64>(v6);
        };
        0x2::table::add<u64, UserRankData>(&mut arg0.user_ranks, arg1, v1);
        if (!0x2::table::contains<u64, vector<address>>(&arg0.claimed_rewards, arg1)) {
            0x2::table::add<u64, vector<address>>(&mut arg0.claimed_rewards, arg1, 0x1::vector::empty<address>());
        };
    }

    // decompiled from Move bytecode v6
}

