module 0x885d6c077a3944c6c1d47ef06385333225766ba9467611874ec236c44e4bd0e6::leaderboard {
    struct PlayerStats has copy, drop, store {
        player: address,
        total_profit: u64,
        total_loss: u64,
        games_won: u64,
        games_lost: u64,
        games_drawn: u64,
        profit_is_positive: bool,
        net_amount: u64,
        last_updated: u64,
    }

    struct Leaderboard has key {
        id: 0x2::object::UID,
        top_players: vector<PlayerStats>,
        all_time_volume: u64,
        total_games: u64,
        total_players: u64,
    }

    struct LeaderboardUpdated has copy, drop {
        player: address,
        profit_is_positive: bool,
        net_amount: u64,
        new_rank: u64,
        games_won: u64,
        games_lost: u64,
    }

    public fun get_player_rank(arg0: &Leaderboard, arg1: address) : u64 {
        let v0 = 0;
        let v1 = &arg0.top_players;
        while (v0 < 0x1::vector::length<PlayerStats>(v1)) {
            if (0x1::vector::borrow<PlayerStats>(v1, v0).player == arg1) {
                return v0 + 1
            };
            v0 = v0 + 1;
        };
        0
    }

    public fun get_player_stats(arg0: &Leaderboard, arg1: address) : vector<PlayerStats> {
        let v0 = 0;
        let v1 = &arg0.top_players;
        let v2 = 0x1::vector::empty<PlayerStats>();
        while (v0 < 0x1::vector::length<PlayerStats>(v1)) {
            let v3 = 0x1::vector::borrow<PlayerStats>(v1, v0);
            if (v3.player == arg1) {
                0x1::vector::push_back<PlayerStats>(&mut v2, *v3);
                break
            };
            v0 = v0 + 1;
        };
        v2
    }

    public fun get_top_players(arg0: &Leaderboard) : vector<PlayerStats> {
        arg0.top_players
    }

    public fun get_total_games(arg0: &Leaderboard) : u64 {
        arg0.total_games
    }

    public fun get_total_volume(arg0: &Leaderboard) : u64 {
        arg0.all_time_volume
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Leaderboard{
            id              : 0x2::object::new(arg0),
            top_players     : 0x1::vector::empty<PlayerStats>(),
            all_time_volume : 0,
            total_games     : 0,
            total_players   : 0,
        };
        0x2::transfer::share_object<Leaderboard>(v0);
    }

    fun sort_leaderboard(arg0: &mut Leaderboard) {
        let v0 = &mut arg0.top_players;
        let v1 = 0x1::vector::length<PlayerStats>(v0);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0;
            while (v3 < v1 - v2 - 1) {
                let v4 = 0x1::vector::borrow<PlayerStats>(v0, v3);
                let v5 = 0x1::vector::borrow<PlayerStats>(v0, v3 + 1);
                if (v4.profit_is_positive && !v5.profit_is_positive && false || !v4.profit_is_positive && v5.profit_is_positive || v4.profit_is_positive && v5.profit_is_positive && v4.net_amount < v5.net_amount || v4.net_amount > v5.net_amount) {
                    0x1::vector::swap<PlayerStats>(v0, v3, v3 + 1);
                };
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        while (0x1::vector::length<PlayerStats>(v0) > 20) {
            0x1::vector::pop_back<PlayerStats>(v0);
        };
    }

    public fun update_player_stats(arg0: &mut Leaderboard, arg1: address, arg2: bool, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg5);
        let v1 = false;
        let v2 = 0;
        let v3 = &mut arg0.top_players;
        while (v2 < 0x1::vector::length<PlayerStats>(v3)) {
            let v4 = 0x1::vector::borrow_mut<PlayerStats>(v3, v2);
            if (v4.player == arg1) {
                if (arg3) {
                    v4.games_drawn = v4.games_drawn + 1;
                } else if (arg2) {
                    v4.total_profit = v4.total_profit + arg4;
                    v4.games_won = v4.games_won + 1;
                } else {
                    v4.total_loss = v4.total_loss + arg4;
                    v4.games_lost = v4.games_lost + 1;
                };
                if (v4.total_profit >= v4.total_loss) {
                    v4.profit_is_positive = true;
                    v4.net_amount = v4.total_profit - v4.total_loss;
                } else {
                    v4.profit_is_positive = false;
                    v4.net_amount = v4.total_loss - v4.total_profit;
                };
                v4.last_updated = v0;
                v1 = true;
                break
            };
            v2 = v2 + 1;
        };
        if (!v1) {
            let (v5, v6) = if (arg2 && !arg3) {
                (true, arg4)
            } else if (!arg2 && !arg3) {
                (false, arg4)
            } else {
                (true, 0)
            };
            let v7 = if (arg2 && !arg3) {
                arg4
            } else {
                0
            };
            let v8 = if (!arg2 && !arg3) {
                arg4
            } else {
                0
            };
            let v9 = if (arg2 && !arg3) {
                1
            } else {
                0
            };
            let v10 = if (!arg2 && !arg3) {
                1
            } else {
                0
            };
            let v11 = if (arg3) {
                1
            } else {
                0
            };
            let v12 = PlayerStats{
                player             : arg1,
                total_profit       : v7,
                total_loss         : v8,
                games_won          : v9,
                games_lost         : v10,
                games_drawn        : v11,
                profit_is_positive : v5,
                net_amount         : v6,
                last_updated       : v0,
            };
            0x1::vector::push_back<PlayerStats>(v3, v12);
            arg0.total_players = arg0.total_players + 1;
        };
        if (!arg3) {
            arg0.all_time_volume = arg0.all_time_volume + arg4;
        };
        arg0.total_games = arg0.total_games + 1;
        sort_leaderboard(arg0);
        let v13 = get_player_stats(arg0, arg1);
        if (0x1::vector::length<PlayerStats>(&v13) > 0) {
            let v14 = 0x1::vector::borrow<PlayerStats>(&v13, 0);
            let v15 = LeaderboardUpdated{
                player             : arg1,
                profit_is_positive : v14.profit_is_positive,
                net_amount         : v14.net_amount,
                new_rank           : get_player_rank(arg0, arg1),
                games_won          : v14.games_won,
                games_lost         : v14.games_lost,
            };
            0x2::event::emit<LeaderboardUpdated>(v15);
        };
    }

    // decompiled from Move bytecode v6
}

