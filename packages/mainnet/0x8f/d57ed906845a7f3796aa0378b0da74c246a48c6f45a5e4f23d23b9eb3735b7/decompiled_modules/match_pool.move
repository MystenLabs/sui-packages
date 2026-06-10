module 0x8fd57ed906845a7f3796aa0378b0da74c246a48c6f45a5e4f23d23b9eb3735b7::match_pool {
    struct PredictionMade has copy, drop {
        player: address,
        match_id: 0x1::string::String,
        predicted_winner: 0x1::string::String,
        fee: u64,
    }

    struct MatchResultSet has copy, drop {
        match_id: 0x1::string::String,
        winner: 0x1::string::String,
        home_score: u64,
        away_score: u64,
    }

    struct PointsClaimed has copy, drop {
        player: address,
        match_id: 0x1::string::String,
        points: u64,
    }

    struct TopPayoutDistributed has copy, drop {
        first_place: address,
        second_place: address,
        third_place: address,
        first_amount: u64,
        second_amount: u64,
        third_amount: u64,
    }

    struct MatchState has copy, drop, store {
        match_id: 0x1::string::String,
        home_team: 0x1::string::String,
        away_team: 0x1::string::String,
        group: 0x1::string::String,
        date: 0x1::string::String,
        home_score: u64,
        away_score: u64,
        is_settled: bool,
        winner: 0x1::option::Option<0x1::string::String>,
    }

    struct Prediction has copy, drop, store {
        predicted_winner: 0x1::string::String,
        timestamp: u64,
    }

    struct PlayerScore has copy, drop, store {
        points: u64,
        correct_predictions: u64,
    }

    struct MatchPool has key {
        id: 0x2::object::UID,
        admin: address,
        matches: vector<MatchState>,
        predictions: 0x2::table::Table<0x1::string::String, 0x2::table::Table<address, Prediction>>,
        match_players: 0x2::table::Table<0x1::string::String, vector<address>>,
        player_scores: 0x2::table::Table<address, PlayerScore>,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        is_open: bool,
        claimed: 0x2::table::Table<address, 0x2::table::Table<0x1::string::String, bool>>,
        first_payout: u64,
        second_payout: u64,
        third_payout: u64,
    }

    struct MatchAdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_matches(arg0: &mut MatchPool, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &MatchAdminCap, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg7), 102);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == v0, 105);
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == v0, 105);
        assert!(0x1::vector::length<0x1::string::String>(&arg4) == v0, 105);
        assert!(0x1::vector::length<0x1::string::String>(&arg5) == v0, 105);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = MatchState{
                match_id   : *0x1::vector::borrow<0x1::string::String>(&arg1, v1),
                home_team  : *0x1::vector::borrow<0x1::string::String>(&arg2, v1),
                away_team  : *0x1::vector::borrow<0x1::string::String>(&arg3, v1),
                group      : *0x1::vector::borrow<0x1::string::String>(&arg4, v1),
                date       : *0x1::vector::borrow<0x1::string::String>(&arg5, v1),
                home_score : 0,
                away_score : 0,
                is_settled : false,
                winner     : 0x1::option::none<0x1::string::String>(),
            };
            0x1::vector::push_back<MatchState>(&mut arg0.matches, v2);
            v1 = v1 + 1;
        };
    }

    public entry fun claim_match_points(arg0: &mut MatchPool, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = find_match(arg0, arg1);
        assert!(v1 < 0x1::vector::length<MatchState>(&arg0.matches), 103);
        let v2 = 0x1::vector::borrow<MatchState>(&arg0.matches, v1);
        assert!(v2.is_settled, 111);
        let v3 = 0x1::option::borrow<0x1::string::String>(&v2.winner);
        assert!(0x2::table::contains<0x1::string::String, 0x2::table::Table<address, Prediction>>(&arg0.predictions, arg1), 103);
        let v4 = 0x2::table::borrow<0x1::string::String, 0x2::table::Table<address, Prediction>>(&arg0.predictions, arg1);
        assert!(0x2::table::contains<address, Prediction>(v4, v0), 112);
        let v5 = 0x2::table::borrow<address, Prediction>(v4, v0);
        let v6 = *v3 == 0x1::string::utf8(b"Draw");
        let v7 = if (v6) {
            1
        } else {
            assert!(v5.predicted_winner == *v3, 106);
            3
        };
        if (0x2::table::contains<address, 0x2::table::Table<0x1::string::String, bool>>(&arg0.claimed, v0)) {
            assert!(!0x2::table::contains<0x1::string::String, bool>(0x2::table::borrow<address, 0x2::table::Table<0x1::string::String, bool>>(&arg0.claimed, v0), arg1), 107);
        };
        if (!0x2::table::contains<address, PlayerScore>(&arg0.player_scores, v0)) {
            let v8 = PlayerScore{
                points              : 0,
                correct_predictions : 0,
            };
            0x2::table::add<address, PlayerScore>(&mut arg0.player_scores, v0, v8);
        };
        let v9 = 0x2::table::borrow_mut<address, PlayerScore>(&mut arg0.player_scores, v0);
        v9.points = v9.points + v7;
        if (!v6) {
            v9.correct_predictions = v9.correct_predictions + 1;
        };
        if (!0x2::table::contains<address, 0x2::table::Table<0x1::string::String, bool>>(&arg0.claimed, v0)) {
            0x2::table::add<address, 0x2::table::Table<0x1::string::String, bool>>(&mut arg0.claimed, v0, 0x2::table::new<0x1::string::String, bool>(arg3));
        };
        0x2::table::add<0x1::string::String, bool>(0x2::table::borrow_mut<address, 0x2::table::Table<0x1::string::String, bool>>(&mut arg0.claimed, v0), arg1, true);
        let v10 = PointsClaimed{
            player   : v0,
            match_id : arg1,
            points   : v7,
        };
        0x2::event::emit<PointsClaimed>(v10);
    }

    public entry fun distribute_top3(arg0: &mut MatchPool, arg1: address, arg2: address, arg3: address, arg4: &MatchAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg5), 102);
        assert!(arg0.first_payout > 0, 109);
        let v0 = if (arg1 != arg2) {
            if (arg2 != arg3) {
                arg1 != arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 113);
        let v1 = if (arg1 != arg0.admin) {
            if (arg2 != arg0.admin) {
                arg3 != arg0.admin
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 113);
        assert!(0x2::table::contains<address, PlayerScore>(&arg0.player_scores, arg1), 113);
        assert!(0x2::table::contains<address, PlayerScore>(&arg0.player_scores, arg2), 113);
        assert!(0x2::table::contains<address, PlayerScore>(&arg0.player_scores, arg3), 113);
        assert!(0x2::table::borrow<address, PlayerScore>(&arg0.player_scores, arg1).points > 0, 113);
        assert!(0x2::table::borrow<address, PlayerScore>(&arg0.player_scores, arg2).points > 0, 113);
        assert!(0x2::table::borrow<address, PlayerScore>(&arg0.player_scores, arg3).points > 0, 113);
        let v2 = arg0.first_payout;
        let v3 = arg0.second_payout;
        let v4 = arg0.third_payout;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v2), arg5), arg1);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v3), arg5), arg2);
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v4), arg5), arg3);
        };
        arg0.is_open = false;
        let v5 = TopPayoutDistributed{
            first_place   : arg1,
            second_place  : arg2,
            third_place   : arg3,
            first_amount  : v2,
            second_amount : v3,
            third_amount  : v4,
        };
        0x2::event::emit<TopPayoutDistributed>(v5);
    }

    fun find_match(arg0: &MatchPool, arg1: 0x1::string::String) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<MatchState>(&arg0.matches);
        while (v0 < v1) {
            if (0x1::vector::borrow<MatchState>(&arg0.matches, v0).match_id == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_all_players_for_match(arg0: &MatchPool, arg1: 0x1::string::String) : vector<address> {
        if (0x2::table::contains<0x1::string::String, vector<address>>(&arg0.match_players, arg1)) {
            *0x2::table::borrow<0x1::string::String, vector<address>>(&arg0.match_players, arg1)
        } else {
            0x1::vector::empty<address>()
        }
    }

    public fun get_match(arg0: &MatchPool, arg1: 0x1::string::String) : 0x1::option::Option<MatchState> {
        let v0 = find_match(arg0, arg1);
        if (v0 < 0x1::vector::length<MatchState>(&arg0.matches)) {
            0x1::option::some<MatchState>(*0x1::vector::borrow<MatchState>(&arg0.matches, v0))
        } else {
            0x1::option::none<MatchState>()
        }
    }

    public fun get_match_count(arg0: &MatchPool) : u64 {
        0x1::vector::length<MatchState>(&arg0.matches)
    }

    public fun get_player_correct_predictions(arg0: &MatchPool, arg1: address) : u64 {
        if (0x2::table::contains<address, PlayerScore>(&arg0.player_scores, arg1)) {
            0x2::table::borrow<address, PlayerScore>(&arg0.player_scores, arg1).correct_predictions
        } else {
            0
        }
    }

    public fun get_player_score(arg0: &MatchPool, arg1: address) : u64 {
        if (0x2::table::contains<address, PlayerScore>(&arg0.player_scores, arg1)) {
            0x2::table::borrow<address, PlayerScore>(&arg0.player_scores, arg1).points
        } else {
            0
        }
    }

    public fun get_pool_balance(arg0: &MatchPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    public fun get_prediction(arg0: &MatchPool, arg1: 0x1::string::String, arg2: address) : 0x1::option::Option<0x1::string::String> {
        if (!0x2::table::contains<0x1::string::String, 0x2::table::Table<address, Prediction>>(&arg0.predictions, arg1)) {
            return 0x1::option::none<0x1::string::String>()
        };
        let v0 = 0x2::table::borrow<0x1::string::String, 0x2::table::Table<address, Prediction>>(&arg0.predictions, arg1);
        if (0x2::table::contains<address, Prediction>(v0, arg2)) {
            0x1::option::some<0x1::string::String>(0x2::table::borrow<address, Prediction>(v0, arg2).predicted_winner)
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun get_treasury_balance(arg0: &MatchPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun has_claimed_points(arg0: &MatchPool, arg1: address, arg2: 0x1::string::String) : bool {
        if (!0x2::table::contains<address, 0x2::table::Table<0x1::string::String, bool>>(&arg0.claimed, arg1)) {
            return false
        };
        0x2::table::contains<0x1::string::String, bool>(0x2::table::borrow<address, 0x2::table::Table<0x1::string::String, bool>>(&arg0.claimed, arg1), arg2)
    }

    public fun has_predicted(arg0: &MatchPool, arg1: 0x1::string::String, arg2: address) : bool {
        if (!0x2::table::contains<0x1::string::String, 0x2::table::Table<address, Prediction>>(&arg0.predictions, arg1)) {
            return false
        };
        0x2::table::contains<address, Prediction>(0x2::table::borrow<0x1::string::String, 0x2::table::Table<address, Prediction>>(&arg0.predictions, arg1), arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MatchPool{
            id            : 0x2::object::new(arg0),
            admin         : 0x2::tx_context::sender(arg0),
            matches       : 0x1::vector::empty<MatchState>(),
            predictions   : 0x2::table::new<0x1::string::String, 0x2::table::Table<address, Prediction>>(arg0),
            match_players : 0x2::table::new<0x1::string::String, vector<address>>(arg0),
            player_scores : 0x2::table::new<address, PlayerScore>(arg0),
            prize_pool    : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury      : 0x2::balance::zero<0x2::sui::SUI>(),
            is_open       : true,
            claimed       : 0x2::table::new<address, 0x2::table::Table<0x1::string::String, bool>>(arg0),
            first_payout  : 0,
            second_payout : 0,
            third_payout  : 0,
        };
        0x2::transfer::share_object<MatchPool>(v0);
        let v1 = MatchAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MatchAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun predict_winner(arg0: &mut MatchPool, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_open, 110);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 1500000000, 100);
        let v0 = find_match(arg0, arg1);
        assert!(v0 < 0x1::vector::length<MatchState>(&arg0.matches), 103);
        let v1 = 0x1::vector::borrow<MatchState>(&arg0.matches, v0);
        assert!(!v1.is_settled, 104);
        assert!(v1.home_team == arg2 || v1.away_team == arg2, 105);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2, 1000000000), arg5));
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::from_balance<0x2::sui::SUI>(v2, arg5));
        let v3 = 0x2::tx_context::sender(arg5);
        if (!0x2::table::contains<0x1::string::String, 0x2::table::Table<address, Prediction>>(&arg0.predictions, arg1)) {
            0x2::table::add<0x1::string::String, 0x2::table::Table<address, Prediction>>(&mut arg0.predictions, arg1, 0x2::table::new<address, Prediction>(arg5));
            0x2::table::add<0x1::string::String, vector<address>>(&mut arg0.match_players, arg1, 0x1::vector::empty<address>());
        };
        let v4 = 0x2::table::borrow_mut<0x1::string::String, 0x2::table::Table<address, Prediction>>(&mut arg0.predictions, arg1);
        assert!(!0x2::table::contains<address, Prediction>(v4, v3), 101);
        let v5 = Prediction{
            predicted_winner : arg2,
            timestamp        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::table::add<address, Prediction>(v4, v3, v5);
        0x1::vector::push_back<address>(0x2::table::borrow_mut<0x1::string::String, vector<address>>(&mut arg0.match_players, arg1), v3);
        if (!0x2::table::contains<address, PlayerScore>(&arg0.player_scores, v3)) {
            let v6 = PlayerScore{
                points              : 0,
                correct_predictions : 0,
            };
            0x2::table::add<address, PlayerScore>(&mut arg0.player_scores, v3, v6);
        };
        let v7 = PredictionMade{
            player           : v3,
            match_id         : arg1,
            predicted_winner : arg2,
            fee              : 1500000000,
        };
        0x2::event::emit<PredictionMade>(v7);
    }

    public entry fun set_match_result(arg0: &mut MatchPool, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: &MatchAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg5), 102);
        let v0 = find_match(arg0, arg1);
        assert!(v0 < 0x1::vector::length<MatchState>(&arg0.matches), 103);
        let v1 = 0x1::vector::borrow_mut<MatchState>(&mut arg0.matches, v0);
        assert!(!v1.is_settled, 104);
        v1.home_score = arg2;
        v1.away_score = arg3;
        v1.is_settled = true;
        let v2 = if (arg2 > arg3) {
            v1.home_team
        } else if (arg3 > arg2) {
            v1.away_team
        } else {
            0x1::string::utf8(b"Draw")
        };
        v1.winner = 0x1::option::some<0x1::string::String>(v2);
        let v3 = MatchResultSet{
            match_id   : arg1,
            winner     : v2,
            home_score : arg2,
            away_score : arg3,
        };
        0x2::event::emit<MatchResultSet>(v3);
    }

    public entry fun set_payouts(arg0: &mut MatchPool, arg1: u64, arg2: u64, arg3: u64, arg4: &MatchAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg5), 102);
        assert!(arg1 + arg2 + arg3 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool), 100);
        arg0.first_payout = arg1;
        arg0.second_payout = arg2;
        arg0.third_payout = arg3;
    }

    public entry fun withdraw_treasury(arg0: &mut MatchPool, arg1: &MatchAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 102);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

