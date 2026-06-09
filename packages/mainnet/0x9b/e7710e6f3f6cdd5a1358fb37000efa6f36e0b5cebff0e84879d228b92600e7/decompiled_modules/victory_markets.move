module 0x9be7710e6f3f6cdd5a1358fb37000efa6f36e0b5cebff0e84879d228b92600e7::victory_markets {
    struct PlayerEntered has copy, drop {
        player: address,
        champion_pick: 0x1::string::String,
    }

    struct PredictionMade has copy, drop {
        player: address,
        match_id: u64,
        outcome: u8,
    }

    struct ResultSubmitted has copy, drop {
        match_id: u64,
        outcome: u8,
        submitted_by: address,
        dispute_deadline: u64,
    }

    struct ResultOverridden has copy, drop {
        match_id: u64,
        old_outcome: u8,
        new_outcome: u8,
        overridden_by: address,
    }

    struct ResultFinalized has copy, drop {
        match_id: u64,
        outcome: u8,
    }

    struct LeaderboardSettled has copy, drop {
        winner_count: u64,
        settled_by: address,
    }

    struct SettlementConfirmed has copy, drop {
        confirmed_by: address,
    }

    struct PayoutDistributed has copy, drop {
        player: address,
        amount: u64,
    }

    struct Admin2Set has copy, drop {
        new_admin: address,
    }

    struct EntriesClosed has copy, drop {
        dummy_field: bool,
    }

    struct PrePicksClosed has copy, drop {
        dummy_field: bool,
    }

    struct VictoryDeposited has copy, drop {
        amount: u64,
    }

    struct TreasuryWithdrawn has copy, drop {
        amount: u64,
    }

    struct PrizePoolWithdrawn has copy, drop {
        amount: u64,
        to: address,
    }

    struct FeeConfigUpdated has copy, drop {
        entry_fee: u64,
        pool_portion: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Match has copy, drop, store {
        match_id: u64,
        home_team: 0x1::string::String,
        away_team: 0x1::string::String,
        round: u8,
        kickoff_ms: u64,
        outcome: u8,
        result_submitted_at: u64,
        finalized: bool,
    }

    struct Prediction has copy, drop, store {
        outcome: u8,
    }

    struct Player has copy, drop, store {
        champion_pick: 0x1::string::String,
        entered_at: u64,
        has_pre_pick: bool,
    }

    struct Tournament has key {
        id: 0x2::object::UID,
        admin1: address,
        admin2: address,
        entry_fee: u64,
        pool_portion: u64,
        dispute_window_ms: u64,
        entries: 0x2::table::Table<address, Player>,
        players: vector<address>,
        total_entries: u64,
        matches: 0x2::table::Table<u64, Match>,
        match_count: u64,
        predictions: 0x2::table::Table<vector<u8>, Prediction>,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        victory_pool: 0x2::balance::Balance<0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::victory_token::VICTORY_TOKEN>,
        is_open: bool,
        pre_pick_open: bool,
        winners: vector<address>,
        payouts: vector<u64>,
        settled_by: address,
        settlement_confirmed: bool,
        paid: 0x2::table::Table<address, bool>,
    }

    entry fun add_match(arg0: &mut Tournament, arg1: &AdminCap, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg7)), 13835622439755055111);
        assert!(!0x2::table::contains<u64, Match>(&arg0.matches, arg2), 13840407518655807521);
        let v0 = Match{
            match_id            : arg2,
            home_team           : arg3,
            away_team           : arg4,
            round               : arg5,
            kickoff_ms          : arg6,
            outcome             : 0,
            result_submitted_at : 0,
            finalized           : false,
        };
        0x2::table::add<u64, Match>(&mut arg0.matches, arg2, v0);
        arg0.match_count = arg0.match_count + 1;
    }

    entry fun add_matches_batch(arg0: &mut Tournament, arg1: &AdminCap, arg2: vector<u64>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<u8>, arg6: vector<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg7)), 13835622555719172103);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            let v1 = *0x1::vector::borrow<u64>(&arg2, v0);
            if (!0x2::table::contains<u64, Match>(&arg0.matches, v1)) {
                let v2 = Match{
                    match_id            : v1,
                    home_team           : *0x1::vector::borrow<0x1::string::String>(&arg3, v0),
                    away_team           : *0x1::vector::borrow<0x1::string::String>(&arg4, v0),
                    round               : *0x1::vector::borrow<u8>(&arg5, v0),
                    kickoff_ms          : *0x1::vector::borrow<u64>(&arg6, v0),
                    outcome             : 0,
                    result_submitted_at : 0,
                    finalized           : false,
                };
                0x2::table::add<u64, Match>(&mut arg0.matches, v1, v2);
                arg0.match_count = arg0.match_count + 1;
            };
            v0 = v0 + 1;
        };
    }

    entry fun close_entries(arg0: &mut Tournament, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 13835623199964266503);
        arg0.is_open = false;
        let v0 = EntriesClosed{dummy_field: false};
        0x2::event::emit<EntriesClosed>(v0);
    }

    entry fun close_pre_picks(arg0: &mut Tournament, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 13835623242913939463);
        arg0.pre_pick_open = false;
        let v0 = PrePicksClosed{dummy_field: false};
        0x2::event::emit<PrePicksClosed>(v0);
    }

    entry fun confirm_settlement(arg0: &mut Tournament, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 13835623401827729415);
        assert!(0x2::tx_context::sender(arg2) != arg0.settled_by, 13835623410417664007);
        arg0.settlement_confirmed = true;
        let v0 = SettlementConfirmed{confirmed_by: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<SettlementConfirmed>(v0);
    }

    entry fun deposit_victory(arg0: &mut Tournament, arg1: &AdminCap, arg2: 0x2::coin::Coin<0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::victory_token::VICTORY_TOKEN>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 13835623663820734471);
        0x2::balance::join<0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::victory_token::VICTORY_TOKEN>(&mut arg0.victory_pool, 0x2::coin::into_balance<0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::victory_token::VICTORY_TOKEN>(arg2));
        let v0 = VictoryDeposited{amount: 0x2::coin::value<0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::victory_token::VICTORY_TOKEN>(&arg2)};
        0x2::event::emit<VictoryDeposited>(v0);
    }

    public fun dispute_window_ms(arg0: &Tournament) : u64 {
        arg0.dispute_window_ms
    }

    entry fun distribute_payouts(arg0: &mut Tournament, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg4)), 13835623534971715591);
        assert!(arg0.settlement_confirmed, 13837875339081416727);
        let v0 = 0x1::vector::length<address>(&arg0.winners);
        let v1 = if (arg3 > v0) {
            v0
        } else {
            arg3
        };
        while (arg2 < v1) {
            let v2 = *0x1::vector::borrow<address>(&arg0.winners, arg2);
            let v3 = *0x1::vector::borrow<u64>(&arg0.payouts, arg2);
            if (v3 > 0 && !0x2::table::contains<address, bool>(&arg0.paid, v2)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::victory_token::VICTORY_TOKEN>>(0x2::coin::from_balance<0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::victory_token::VICTORY_TOKEN>(0x2::balance::split<0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::victory_token::VICTORY_TOKEN>(&mut arg0.victory_pool, v3), arg4), v2);
                0x2::table::add<address, bool>(&mut arg0.paid, v2, true);
                let v4 = PayoutDistributed{
                    player : v2,
                    amount : v3,
                };
                0x2::event::emit<PayoutDistributed>(v4);
            };
            arg2 = arg2 + 1;
        };
    }

    entry fun enter(arg0: &mut Tournament, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_open, 13835903760113074185);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.entry_fee, 13835059339477516291);
        assert!(!0x2::table::contains<address, Player>(&arg0.entries, 0x2::tx_context::sender(arg4)), 13835340818749325317);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg0.pool_portion));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, v0);
        let v1 = Player{
            champion_pick : arg2,
            entered_at    : 0x2::clock::timestamp_ms(arg3),
            has_pre_pick  : arg0.pre_pick_open,
        };
        0x2::table::add<address, Player>(&mut arg0.entries, 0x2::tx_context::sender(arg4), v1);
        0x1::vector::push_back<address>(&mut arg0.players, 0x2::tx_context::sender(arg4));
        arg0.total_entries = arg0.total_entries + 1;
        let v2 = PlayerEntered{
            player        : 0x2::tx_context::sender(arg4),
            champion_pick : arg2,
        };
        0x2::event::emit<PlayerEntered>(v2);
    }

    public fun entry_fee(arg0: &Tournament) : u64 {
        arg0.entry_fee
    }

    entry fun finalize_result(arg0: &mut Tournament, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::table::contains<u64, Match>(&arg0.matches, arg1), 13836186055428669451);
        let v0 = 0x2::table::borrow_mut<u64, Match>(&mut arg0.matches, arg1);
        assert!(!v0.finalized, 13836467543290413069);
        assert!(v0.result_submitted_at > 0, 13837030497539063825);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.result_submitted_at + arg0.dispute_window_ms, 13837311985400807443);
        v0.finalized = true;
        let v1 = ResultFinalized{
            match_id : arg1,
            outcome  : v0.outcome,
        };
        0x2::event::emit<ResultFinalized>(v1);
    }

    public fun get_match(arg0: &Tournament, arg1: u64) : 0x1::option::Option<Match> {
        if (0x2::table::contains<u64, Match>(&arg0.matches, arg1)) {
            0x1::option::some<Match>(*0x2::table::borrow<u64, Match>(&arg0.matches, arg1))
        } else {
            0x1::option::none<Match>()
        }
    }

    public fun get_player(arg0: &Tournament, arg1: address) : 0x1::option::Option<Player> {
        if (0x2::table::contains<address, Player>(&arg0.entries, arg1)) {
            0x1::option::some<Player>(*0x2::table::borrow<address, Player>(&arg0.entries, arg1))
        } else {
            0x1::option::none<Player>()
        }
    }

    public fun get_prediction(arg0: &Tournament, arg1: address, arg2: u64) : 0x1::option::Option<Prediction> {
        let v0 = prediction_key(arg1, arg2);
        if (0x2::table::contains<vector<u8>, Prediction>(&arg0.predictions, v0)) {
            0x1::option::some<Prediction>(*0x2::table::borrow<vector<u8>, Prediction>(&arg0.predictions, v0))
        } else {
            0x1::option::none<Prediction>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Tournament{
            id                   : 0x2::object::new(arg0),
            admin1               : v0,
            admin2               : @0x0,
            entry_fee            : 10000000000,
            pool_portion         : 9000000000,
            dispute_window_ms    : 86400000,
            entries              : 0x2::table::new<address, Player>(arg0),
            players              : vector[],
            total_entries        : 0,
            matches              : 0x2::table::new<u64, Match>(arg0),
            match_count          : 0,
            predictions          : 0x2::table::new<vector<u8>, Prediction>(arg0),
            prize_pool           : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury             : 0x2::balance::zero<0x2::sui::SUI>(),
            victory_pool         : 0x2::balance::zero<0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::victory_token::VICTORY_TOKEN>(),
            is_open              : true,
            pre_pick_open        : true,
            winners              : vector[],
            payouts              : vector[],
            settled_by           : @0x0,
            settlement_confirmed : false,
            paid                 : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<Tournament>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v3, v0);
    }

    fun is_admin(arg0: &Tournament, arg1: address) : bool {
        arg1 == arg0.admin1 || arg1 == arg0.admin2
    }

    public fun is_open(arg0: &Tournament) : bool {
        arg0.is_open
    }

    public fun is_pre_pick_open(arg0: &Tournament) : bool {
        arg0.pre_pick_open
    }

    public fun is_settled(arg0: &Tournament) : bool {
        arg0.settlement_confirmed
    }

    public fun match_count(arg0: &Tournament) : u64 {
        arg0.match_count
    }

    entry fun override_result(arg0: &mut Tournament, arg1: &AdminCap, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg5)), 13835622980920934407);
        assert!(0x2::table::contains<u64, Match>(&arg0.matches, arg2), 13836185935169585163);
        let v0 = if (arg3 == 1) {
            true
        } else if (arg3 == 2) {
            true
        } else {
            arg3 == 3
        };
        assert!(v0, 13839563647776194589);
        let v1 = 0x2::table::borrow_mut<u64, Match>(&mut arg0.matches, arg2);
        assert!(!v1.finalized, 13836467440211197965);
        assert!(v1.result_submitted_at > 0, 13837030394459848721);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        assert!(v2 < v1.result_submitted_at + arg0.dispute_window_ms, 13837593357298434069);
        v1.outcome = arg3;
        v1.result_submitted_at = v2;
        let v3 = ResultOverridden{
            match_id      : arg2,
            old_outcome   : v1.outcome,
            new_outcome   : arg3,
            overridden_by : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ResultOverridden>(v3);
    }

    public fun players(arg0: &Tournament) : vector<address> {
        arg0.players
    }

    public fun point_value(arg0: u8) : u64 {
        if (arg0 == 1) {
            1
        } else if (arg0 == 2) {
            1
        } else if (arg0 == 3) {
            2
        } else if (arg0 == 4) {
            4
        } else if (arg0 == 5) {
            8
        } else if (arg0 == 6) {
            16
        } else {
            0
        }
    }

    public fun pool_portion(arg0: &Tournament) : u64 {
        arg0.pool_portion
    }

    entry fun predict(arg0: &mut Tournament, arg1: u64, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, Player>(&arg0.entries, 0x2::tx_context::sender(arg4)), 13840126322851840031);
        assert!(0x2::table::contains<u64, Match>(&arg0.matches, arg1), 13836185677471547403);
        let v0 = if (arg2 == 1) {
            true
        } else if (arg2 == 2) {
            true
        } else {
            arg2 == 3
        };
        assert!(v0, 13839563390078156829);
        assert!(0x2::clock::timestamp_ms(arg3) < 0x2::table::borrow<u64, Match>(&arg0.matches, arg1).kickoff_ms, 13836748657490001935);
        let v1 = prediction_key(0x2::tx_context::sender(arg4), arg1);
        assert!(!0x2::table::contains<vector<u8>, Prediction>(&arg0.predictions, v1), 13839281945166086171);
        let v2 = Prediction{outcome: arg2};
        0x2::table::add<vector<u8>, Prediction>(&mut arg0.predictions, v1, v2);
        let v3 = PredictionMade{
            player   : 0x2::tx_context::sender(arg4),
            match_id : arg1,
            outcome  : arg2,
        };
        0x2::event::emit<PredictionMade>(v3);
    }

    fun prediction_key(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        v0
    }

    public fun prize_pool_value(arg0: &Tournament) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    entry fun reset_settlement(arg0: &mut Tournament, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 13835623461957271559);
        assert!(!arg0.settlement_confirmed, 13838156741043814425);
        arg0.winners = vector[];
        arg0.payouts = vector[];
        arg0.settled_by = @0x0;
    }

    entry fun set_admin2(arg0: &mut Tournament, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin1, 13835622104747606023);
        arg0.admin2 = arg2;
        let v0 = Admin2Set{new_admin: arg2};
        0x2::event::emit<Admin2Set>(v0);
    }

    entry fun set_dispute_window(arg0: &mut Tournament, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 13835622220711723015);
        arg0.dispute_window_ms = arg2;
    }

    entry fun set_fee_config(arg0: &mut Tournament, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg4)), 13835622160582180871);
        assert!(arg3 < arg2, 13840970189436616741);
        arg0.entry_fee = arg2;
        arg0.pool_portion = arg3;
        let v0 = FeeConfigUpdated{
            entry_fee    : arg2,
            pool_portion : arg3,
        };
        0x2::event::emit<FeeConfigUpdated>(v0);
    }

    entry fun settle_leaderboard(arg0: &mut Tournament, arg1: &AdminCap, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg4)), 13835623311633416199);
        assert!(0x1::vector::length<address>(&arg0.winners) == 0, 13838156590719959065);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 13840689869805977635);
        arg0.winners = arg2;
        arg0.payouts = arg3;
        arg0.settled_by = 0x2::tx_context::sender(arg4);
        arg0.settlement_confirmed = false;
        let v0 = LeaderboardSettled{
            winner_count : 0x1::vector::length<address>(&arg2),
            settled_by   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<LeaderboardSettled>(v0);
    }

    entry fun submit_result(arg0: &mut Tournament, arg1: &AdminCap, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg5)), 13835622852071915527);
        assert!(0x2::table::contains<u64, Match>(&arg0.matches, arg2), 13836185806320566283);
        let v0 = if (arg3 == 1) {
            true
        } else if (arg3 == 2) {
            true
        } else {
            arg3 == 3
        };
        assert!(v0, 13839563518927175709);
        let v1 = 0x2::table::borrow_mut<u64, Match>(&mut arg0.matches, arg2);
        assert!(!v1.finalized, 13836467311362179085);
        v1.outcome = arg3;
        v1.result_submitted_at = 0x2::clock::timestamp_ms(arg4);
        let v2 = ResultSubmitted{
            match_id         : arg2,
            outcome          : arg3,
            submitted_by     : 0x2::tx_context::sender(arg5),
            dispute_deadline : v1.result_submitted_at + arg0.dispute_window_ms,
        };
        0x2::event::emit<ResultSubmitted>(v2);
    }

    public fun total_entries(arg0: &Tournament) : u64 {
        arg0.total_entries
    }

    public fun treasury_value(arg0: &Tournament) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun victory_pool_value(arg0: &Tournament) : u64 {
        0x2::balance::value<0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::victory_token::VICTORY_TOKEN>(&arg0.victory_pool)
    }

    entry fun withdraw_prize_pool(arg0: &mut Tournament, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 13835623771194916871);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v0), arg2), 0x2::tx_context::sender(arg2));
        let v1 = PrizePoolWithdrawn{
            amount : v0,
            to     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PrizePoolWithdrawn>(v1);
    }

    entry fun withdraw_treasury(arg0: &mut Tournament, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 13835623715360342023);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, v0), arg2), @0x4a820b48b23c118091dd04789c5617dbf2304864e1ca60d9942a6cd53e8a6a7e);
        let v1 = TreasuryWithdrawn{amount: v0};
        0x2::event::emit<TreasuryWithdrawn>(v1);
    }

    // decompiled from Move bytecode v6
}

