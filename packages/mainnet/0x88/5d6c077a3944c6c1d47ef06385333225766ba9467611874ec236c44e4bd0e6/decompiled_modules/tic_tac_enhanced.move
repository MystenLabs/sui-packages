module 0x885d6c077a3944c6c1d47ef06385333225766ba9467611874ec236c44e4bd0e6::tic_tac_enhanced {
    struct PlayerStats has copy, drop, store {
        player: address,
        total_profit: u64,
        total_loss: u64,
        games_won: u64,
        games_lost: u64,
        last_updated: u64,
    }

    struct Leaderboard has key {
        id: 0x2::object::UID,
        top_players: vector<PlayerStats>,
        all_time_volume: u64,
        total_games: u64,
    }

    struct GameEnhanced has key {
        id: 0x2::object::UID,
        board: vector<u8>,
        turn: u8,
        x: address,
        o: address,
        mode: u8,
        status: u8,
        stake_amount: u64,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        creator: address,
        winner: address,
        game_link: 0x1::string::String,
        viewer_link: 0x1::string::String,
        created_at: u64,
        completed_at: u64,
        last_move_epoch: u64,
        x_total_time: u64,
        o_total_time: u64,
    }

    struct TimeoutVictory has copy, drop {
        game_id: address,
        winner: address,
        loser: address,
        reason: 0x1::string::String,
    }

    struct LeaderboardUpdated has copy, drop {
        player: address,
        new_profit: u64,
        rank: u64,
    }

    public fun check_sufficient_balance(arg0: u64, arg1: u64) : bool {
        arg1 >= arg0 + 10000000
    }

    public fun claim_timeout_victory(arg0: &mut GameEnhanced, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 10);
        let v0 = 0x2::tx_context::epoch(arg1);
        assert!(v0 - arg0.last_move_epoch >= 60, 11);
        let v1 = if (arg0.turn % 2 == 0) {
            arg0.x
        } else {
            arg0.o
        };
        let v2 = 0x2::tx_context::sender(arg1);
        assert!(v2 != v1, 12);
        assert!(v2 == arg0.x || v2 == arg0.o, 0);
        arg0.winner = v2;
        arg0.status = 4;
        arg0.completed_at = v0;
        let v3 = TimeoutVictory{
            game_id : 0x2::object::uid_to_address(&arg0.id),
            winner  : v2,
            loser   : v1,
            reason  : 0x1::string::utf8(b"Opponent timeout - no move for 1 hour"),
        };
        0x2::event::emit<TimeoutVictory>(v3);
    }

    public fun get_leaderboard(arg0: &Leaderboard) : vector<PlayerStats> {
        arg0.top_players
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
                let v6 = if (v4.total_profit > v4.total_loss) {
                    v4.total_profit - v4.total_loss
                } else {
                    0
                };
                let v7 = if (v5.total_profit > v5.total_loss) {
                    v5.total_profit - v5.total_loss
                } else {
                    0
                };
                if (v6 < v7) {
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

    public fun update_leaderboard(arg0: &mut Leaderboard, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg4);
        update_player_stats(arg0, arg1, arg3, 0, true, v0);
        update_player_stats(arg0, arg2, 0, arg3, false, v0);
        arg0.all_time_volume = arg0.all_time_volume + arg3 * 2;
        arg0.total_games = arg0.total_games + 1;
        sort_leaderboard(arg0);
    }

    fun update_player_stats(arg0: &mut Leaderboard, arg1: address, arg2: u64, arg3: u64, arg4: bool, arg5: u64) {
        let v0 = 0;
        let v1 = false;
        let v2 = &mut arg0.top_players;
        while (v0 < 0x1::vector::length<PlayerStats>(v2)) {
            let v3 = 0x1::vector::borrow_mut<PlayerStats>(v2, v0);
            if (v3.player == arg1) {
                v3.total_profit = v3.total_profit + arg2;
                v3.total_loss = v3.total_loss + arg3;
                if (arg4) {
                    v3.games_won = v3.games_won + 1;
                } else {
                    v3.games_lost = v3.games_lost + 1;
                };
                v3.last_updated = arg5;
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        if (!v1) {
            let v4 = if (arg4) {
                1
            } else {
                0
            };
            let v5 = if (arg4) {
                0
            } else {
                1
            };
            let v6 = PlayerStats{
                player       : arg1,
                total_profit : arg2,
                total_loss   : arg3,
                games_won    : v4,
                games_lost   : v5,
                last_updated : arg5,
            };
            0x1::vector::push_back<PlayerStats>(v2, v6);
        };
    }

    // decompiled from Move bytecode v6
}

