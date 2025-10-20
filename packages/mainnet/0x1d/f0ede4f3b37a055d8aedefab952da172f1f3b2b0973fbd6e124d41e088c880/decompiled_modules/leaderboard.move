module 0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::leaderboard {
    struct LeaderboardEntry has copy, drop, store {
        user: address,
        auctions_won: u64,
        volume_won: u64,
    }

    struct Leaderboard has key {
        id: 0x2::object::UID,
        by_auctions_won: vector<LeaderboardEntry>,
        by_volume_won: vector<LeaderboardEntry>,
        user_index: 0x2::table::Table<address, bool>,
        max_entries: u64,
    }

    struct LeaderboardUpdated has copy, drop {
        user: address,
        auctions_won: u64,
        volume_won: u64,
        timestamp: u64,
    }

    public fun entry_details(arg0: &LeaderboardEntry) : (address, u64, u64) {
        (arg0.user, arg0.auctions_won, arg0.volume_won)
    }

    public fun get_rank_by_auctions_won(arg0: &Leaderboard, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<LeaderboardEntry>(&arg0.by_auctions_won)) {
            if (0x1::vector::borrow<LeaderboardEntry>(&arg0.by_auctions_won, v0).user == arg1) {
                return v0 + 1
            };
            v0 = v0 + 1;
        };
        0
    }

    public fun get_rank_by_volume_won(arg0: &Leaderboard, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<LeaderboardEntry>(&arg0.by_volume_won)) {
            if (0x1::vector::borrow<LeaderboardEntry>(&arg0.by_volume_won, v0).user == arg1) {
                return v0 + 1
            };
            v0 = v0 + 1;
        };
        0
    }

    public fun get_top_by_auctions_won(arg0: &Leaderboard, arg1: u64) : vector<LeaderboardEntry> {
        let v0 = 0x1::vector::length<LeaderboardEntry>(&arg0.by_auctions_won);
        let v1 = if (arg1 < v0) {
            arg1
        } else {
            v0
        };
        let v2 = 0x1::vector::empty<LeaderboardEntry>();
        let v3 = 0;
        while (v3 < v1) {
            0x1::vector::push_back<LeaderboardEntry>(&mut v2, *0x1::vector::borrow<LeaderboardEntry>(&arg0.by_auctions_won, v3));
            v3 = v3 + 1;
        };
        v2
    }

    public fun get_top_by_volume_won(arg0: &Leaderboard, arg1: u64) : vector<LeaderboardEntry> {
        let v0 = 0x1::vector::length<LeaderboardEntry>(&arg0.by_volume_won);
        let v1 = if (arg1 < v0) {
            arg1
        } else {
            v0
        };
        let v2 = 0x1::vector::empty<LeaderboardEntry>();
        let v3 = 0;
        while (v3 < v1) {
            0x1::vector::push_back<LeaderboardEntry>(&mut v2, *0x1::vector::borrow<LeaderboardEntry>(&arg0.by_volume_won, v3));
            v3 = v3 + 1;
        };
        v2
    }

    public fun get_total_ranked_users(arg0: &Leaderboard) : (u64, u64) {
        (0x1::vector::length<LeaderboardEntry>(&arg0.by_auctions_won), 0x1::vector::length<LeaderboardEntry>(&arg0.by_volume_won))
    }

    public fun get_user_entry_by_auctions(arg0: &Leaderboard, arg1: address) : (bool, u64, u64, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<LeaderboardEntry>(&arg0.by_auctions_won)) {
            let v1 = 0x1::vector::borrow<LeaderboardEntry>(&arg0.by_auctions_won, v0);
            if (v1.user == arg1) {
                return (true, v0 + 1, v1.auctions_won, v1.volume_won)
            };
            v0 = v0 + 1;
        };
        (false, 0, 0, 0)
    }

    public fun get_user_entry_by_volume(arg0: &Leaderboard, arg1: address) : (bool, u64, u64, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<LeaderboardEntry>(&arg0.by_volume_won)) {
            let v1 = 0x1::vector::borrow<LeaderboardEntry>(&arg0.by_volume_won, v0);
            if (v1.user == arg1) {
                return (true, v0 + 1, v1.auctions_won, v1.volume_won)
            };
            v0 = v0 + 1;
        };
        (false, 0, 0, 0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Leaderboard{
            id              : 0x2::object::new(arg0),
            by_auctions_won : 0x1::vector::empty<LeaderboardEntry>(),
            by_volume_won   : 0x1::vector::empty<LeaderboardEntry>(),
            user_index      : 0x2::table::new<address, bool>(arg0),
            max_entries     : 100,
        };
        0x2::transfer::share_object<Leaderboard>(v0);
    }

    public fun is_user_ranked(arg0: &Leaderboard, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.user_index, arg1)
    }

    public fun refresh_user_ranking(arg0: &mut Leaderboard, arg1: &0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::user_stats::UserStatsRegistry, arg2: address, arg3: &0x2::tx_context::TxContext) {
        update_leaderboard(arg0, arg1, arg2, arg3);
    }

    fun remove_user_from_list(arg0: &mut vector<LeaderboardEntry>, arg1: address) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<LeaderboardEntry>(arg0)) {
            if (0x1::vector::borrow<LeaderboardEntry>(arg0, v0).user == arg1) {
                0x1::vector::remove<LeaderboardEntry>(arg0, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    fun update_by_auctions_won(arg0: &mut Leaderboard, arg1: LeaderboardEntry) {
        let v0 = &mut arg0.by_auctions_won;
        remove_user_from_list(v0, arg1.user);
        let v1 = 0x1::vector::length<LeaderboardEntry>(&arg0.by_auctions_won);
        let v2 = v1;
        let v3 = 0;
        while (v3 < v1) {
            if (arg1.auctions_won > 0x1::vector::borrow<LeaderboardEntry>(&arg0.by_auctions_won, v3).auctions_won) {
                v2 = v3;
                break
            };
            v3 = v3 + 1;
        };
        if (v2 < arg0.max_entries) {
            0x1::vector::insert<LeaderboardEntry>(&mut arg0.by_auctions_won, arg1, v2);
            while (0x1::vector::length<LeaderboardEntry>(&arg0.by_auctions_won) > arg0.max_entries) {
                0x1::vector::pop_back<LeaderboardEntry>(&mut arg0.by_auctions_won);
            };
        };
    }

    fun update_by_volume_won(arg0: &mut Leaderboard, arg1: LeaderboardEntry) {
        let v0 = &mut arg0.by_volume_won;
        remove_user_from_list(v0, arg1.user);
        let v1 = 0x1::vector::length<LeaderboardEntry>(&arg0.by_volume_won);
        let v2 = v1;
        let v3 = 0;
        while (v3 < v1) {
            if (arg1.volume_won > 0x1::vector::borrow<LeaderboardEntry>(&arg0.by_volume_won, v3).volume_won) {
                v2 = v3;
                break
            };
            v3 = v3 + 1;
        };
        if (v2 < arg0.max_entries) {
            0x1::vector::insert<LeaderboardEntry>(&mut arg0.by_volume_won, arg1, v2);
            while (0x1::vector::length<LeaderboardEntry>(&arg0.by_volume_won) > arg0.max_entries) {
                0x1::vector::pop_back<LeaderboardEntry>(&mut arg0.by_volume_won);
            };
        };
    }

    public fun update_leaderboard(arg0: &mut Leaderboard, arg1: &0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::user_stats::UserStatsRegistry, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let (_, v1, _, _, _, v5) = 0x1df0ede4f3b37a055d8aedefab952da172f1f3b2b0973fbd6e124d41e088c880::user_stats::get_user_stats(arg1, arg2);
        let v6 = LeaderboardEntry{
            user         : arg2,
            auctions_won : v1,
            volume_won   : v5,
        };
        update_by_auctions_won(arg0, v6);
        update_by_volume_won(arg0, v6);
        if (!0x2::table::contains<address, bool>(&arg0.user_index, arg2)) {
            0x2::table::add<address, bool>(&mut arg0.user_index, arg2, true);
        };
        let v7 = LeaderboardUpdated{
            user         : arg2,
            auctions_won : v1,
            volume_won   : v5,
            timestamp    : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<LeaderboardUpdated>(v7);
    }

    // decompiled from Move bytecode v6
}

