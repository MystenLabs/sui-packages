module 0xf7dd9e992620bac74fadc3a1a3e9a4b9f1e6120402fb70bb41fefedaf8e93bfb::snake_game {
    struct GameState<phantom T0> has key {
        id: 0x2::object::UID,
        mnm_treasury: 0x2::balance::Balance<T0>,
        player_tickets: 0x2::table::Table<address, u64>,
        player_stats: 0x2::table::Table<address, PlayerStats>,
        player_daily_claims: 0x2::table::Table<address, DailyClaimInfo>,
        total_games_played: u64,
        total_tickets_earned: u64,
        total_mnm_claimed: u64,
        admin: address,
        daily_claim_limit: u64,
    }

    struct PlayerStats has copy, drop, store {
        games_played: u64,
        high_score: u64,
        total_tickets_earned: u64,
        total_mnm_claimed: u64,
        last_game_timestamp: u64,
    }

    struct DailyClaimInfo has copy, drop, store {
        last_claim_day: u64,
        claimed_today: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameCompleted has copy, drop {
        player: address,
        score: u64,
        tickets_earned: u64,
        timestamp: u64,
        high_score: bool,
    }

    struct TicketsClaimed has copy, drop {
        player: address,
        tickets_spent: u64,
        mnm_received: u64,
        timestamp: u64,
    }

    struct TreasuryDeposit has copy, drop {
        amount: u64,
        timestamp: u64,
    }

    public entry fun claim_mnm<T0>(arg0: &mut GameState<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = v1 / 86400000;
        assert!(0x2::table::contains<address, u64>(&arg0.player_tickets, v0), 1);
        let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.player_tickets, v0);
        assert!(*v3 >= arg1, 1);
        let v4 = arg1 / 5 * 1000000000;
        assert!(0x2::balance::value<T0>(&arg0.mnm_treasury) >= v4, 2);
        if (!0x2::table::contains<address, DailyClaimInfo>(&arg0.player_daily_claims, v0)) {
            let v5 = DailyClaimInfo{
                last_claim_day : v2,
                claimed_today  : 0,
            };
            0x2::table::add<address, DailyClaimInfo>(&mut arg0.player_daily_claims, v0, v5);
        };
        let v6 = 0x2::table::borrow_mut<address, DailyClaimInfo>(&mut arg0.player_daily_claims, v0);
        if (v6.last_claim_day < v2) {
            v6.last_claim_day = v2;
            v6.claimed_today = 0;
        };
        let v7 = v6.claimed_today + v4;
        assert!(v7 <= arg0.daily_claim_limit, 6);
        v6.claimed_today = v7;
        *v3 = *v3 - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.mnm_treasury, v4, arg3), v0);
        let v8 = 0x2::table::borrow_mut<address, PlayerStats>(&mut arg0.player_stats, v0);
        v8.total_mnm_claimed = v8.total_mnm_claimed + v4;
        arg0.total_mnm_claimed = arg0.total_mnm_claimed + v4;
        let v9 = TicketsClaimed{
            player        : v0,
            tickets_spent : arg1,
            mnm_received  : v4,
            timestamp     : v1,
        };
        0x2::event::emit<TicketsClaimed>(v9);
    }

    public entry fun deposit_mnm_treasury<T0>(arg0: &AdminCap, arg1: &mut GameState<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        0x2::balance::join<T0>(&mut arg1.mnm_treasury, 0x2::coin::into_balance<T0>(arg2));
        let v0 = TreasuryDeposit{
            amount    : 0x2::coin::value<T0>(&arg2),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TreasuryDeposit>(v0);
    }

    public fun get_claimed_today<T0>(arg0: &GameState<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::table::contains<address, DailyClaimInfo>(&arg0.player_daily_claims, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, DailyClaimInfo>(&arg0.player_daily_claims, arg1);
        if (v0.last_claim_day < 0x2::clock::timestamp_ms(arg2) / 86400000) {
            return 0
        };
        v0.claimed_today / 1000000000
    }

    public fun get_daily_claim_limit<T0>(arg0: &GameState<T0>) : u64 {
        arg0.daily_claim_limit / 1000000000
    }

    public fun get_global_stats<T0>(arg0: &GameState<T0>) : (u64, u64, u64) {
        (arg0.total_games_played, arg0.total_tickets_earned, arg0.total_mnm_claimed)
    }

    public fun get_player_stats<T0>(arg0: &GameState<T0>, arg1: address) : (u64, u64, u64, u64) {
        if (0x2::table::contains<address, PlayerStats>(&arg0.player_stats, arg1)) {
            let v4 = 0x2::table::borrow<address, PlayerStats>(&arg0.player_stats, arg1);
            (v4.games_played, v4.high_score, v4.total_tickets_earned, v4.total_mnm_claimed)
        } else {
            (0, 0, 0, 0)
        }
    }

    public fun get_remaining_daily_claim<T0>(arg0: &GameState<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::table::contains<address, DailyClaimInfo>(&arg0.player_daily_claims, arg1)) {
            return arg0.daily_claim_limit / 1000000000
        };
        let v0 = 0x2::table::borrow<address, DailyClaimInfo>(&arg0.player_daily_claims, arg1);
        if (v0.last_claim_day < 0x2::clock::timestamp_ms(arg2) / 86400000) {
            return arg0.daily_claim_limit / 1000000000
        };
        if (v0.claimed_today >= arg0.daily_claim_limit) {
            return 0
        };
        (arg0.daily_claim_limit - v0.claimed_today) / 1000000000
    }

    public fun get_ticket_balance<T0>(arg0: &GameState<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.player_tickets, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.player_tickets, arg1)
        } else {
            0
        }
    }

    public fun get_treasury_balance<T0>(arg0: &GameState<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.mnm_treasury)
    }

    public fun init_game<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = GameState<T0>{
            id                   : 0x2::object::new(arg0),
            mnm_treasury         : 0x2::balance::zero<T0>(),
            player_tickets       : 0x2::table::new<address, u64>(arg0),
            player_stats         : 0x2::table::new<address, PlayerStats>(arg0),
            player_daily_claims  : 0x2::table::new<address, DailyClaimInfo>(arg0),
            total_games_played   : 0,
            total_tickets_earned : 0,
            total_mnm_claimed    : 0,
            admin                : v0,
            daily_claim_limit    : 500000000000,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<GameState<T0>>(v1);
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public entry fun record_game_score<T0>(arg0: &mut GameState<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1 > 0, 0);
        assert!(arg1 <= 1000, 4);
        assert!(v1 - arg2 >= 10000, 5);
        if (!0x2::table::contains<address, PlayerStats>(&arg0.player_stats, v0)) {
            let v2 = PlayerStats{
                games_played         : 0,
                high_score           : 0,
                total_tickets_earned : 0,
                total_mnm_claimed    : 0,
                last_game_timestamp  : 0,
            };
            0x2::table::add<address, PlayerStats>(&mut arg0.player_stats, v0, v2);
        };
        if (!0x2::table::contains<address, u64>(&arg0.player_tickets, v0)) {
            0x2::table::add<address, u64>(&mut arg0.player_tickets, v0, 0);
        };
        let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.player_tickets, v0);
        *v3 = *v3 + arg1;
        let v4 = 0x2::table::borrow_mut<address, PlayerStats>(&mut arg0.player_stats, v0);
        v4.games_played = v4.games_played + 1;
        v4.total_tickets_earned = v4.total_tickets_earned + arg1;
        v4.last_game_timestamp = v1;
        let v5 = arg1 > v4.high_score;
        if (v5) {
            v4.high_score = arg1;
        };
        arg0.total_games_played = arg0.total_games_played + 1;
        arg0.total_tickets_earned = arg0.total_tickets_earned + arg1;
        let v6 = GameCompleted{
            player         : v0,
            score          : arg1,
            tickets_earned : arg1,
            timestamp      : v1,
            high_score     : v5,
        };
        0x2::event::emit<GameCompleted>(v6);
    }

    public entry fun set_daily_claim_limit<T0>(arg0: &AdminCap, arg1: &mut GameState<T0>, arg2: u64) {
        arg1.daily_claim_limit = arg2 * 1000000000;
    }

    // decompiled from Move bytecode v6
}

