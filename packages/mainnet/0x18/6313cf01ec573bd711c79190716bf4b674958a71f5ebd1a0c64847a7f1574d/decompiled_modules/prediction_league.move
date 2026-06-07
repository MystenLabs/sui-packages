module 0x186313cf01ec573bd711c79190716bf4b674958a71f5ebd1a0c64847a7f1574d::prediction_league {
    struct LeagueAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MatchResult has copy, drop, store {
        outcome: u8,
        home_score: u8,
        away_score: u8,
        recorded_at_ms: u64,
    }

    struct ScoutRecord has store {
        commitments: u64,
        settled: u64,
        hits: u64,
        exacts: u64,
        points: u64,
        current_streak: u64,
        best_streak: u64,
        updated_at_ms: u64,
    }

    struct League has key {
        id: 0x2::object::UID,
        admin: 0x2::object::ID,
        total_commitments: u64,
        total_settled: u64,
        matches: 0x2::table::Table<u64, MatchResult>,
        scouts: 0x2::table::Table<address, ScoutRecord>,
        scout_index: vector<address>,
    }

    struct Prediction has store, key {
        id: 0x2::object::UID,
        league: 0x2::object::ID,
        scout: address,
        match_id: u64,
        commit_hash: vector<u8>,
        confidence: u8,
        committed_at_ms: u64,
        settled: bool,
        revealed_outcome: u8,
        revealed_home: u8,
        revealed_away: u8,
        hit: bool,
        exact: bool,
        points_awarded: u64,
    }

    struct PredictionCommitted has copy, drop {
        league: 0x2::object::ID,
        prediction: 0x2::object::ID,
        scout: address,
        match_id: u64,
        confidence: u8,
        committed_at_ms: u64,
    }

    struct ResultRecorded has copy, drop {
        league: 0x2::object::ID,
        match_id: u64,
        outcome: u8,
        home_score: u8,
        away_score: u8,
        recorded_at_ms: u64,
    }

    struct PredictionSettled has copy, drop {
        league: 0x2::object::ID,
        prediction: 0x2::object::ID,
        scout: address,
        match_id: u64,
        hit: bool,
        exact: bool,
        points_awarded: u64,
        total_points: u64,
        settled_at_ms: u64,
    }

    entry fun commit(arg0: &mut League, arg1: u64, arg2: vector<u8>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = commit_prediction(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::transfer<Prediction>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun commit_prediction(arg0: &mut League, arg1: u64, arg2: vector<u8>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Prediction {
        assert!(arg3 <= 100, 0);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        ensure_scout(arg0, v0, v1);
        let v2 = 0x2::table::borrow_mut<address, ScoutRecord>(&mut arg0.scouts, v0);
        v2.commitments = v2.commitments + 1;
        v2.updated_at_ms = v1;
        arg0.total_commitments = arg0.total_commitments + 1;
        let v3 = Prediction{
            id               : 0x2::object::new(arg5),
            league           : 0x2::object::id<League>(arg0),
            scout            : v0,
            match_id         : arg1,
            commit_hash      : arg2,
            confidence       : arg3,
            committed_at_ms  : v1,
            settled          : false,
            revealed_outcome : 0,
            revealed_home    : 0,
            revealed_away    : 0,
            hit              : false,
            exact            : false,
            points_awarded   : 0,
        };
        let v4 = PredictionCommitted{
            league          : 0x2::object::id<League>(arg0),
            prediction      : 0x2::object::id<Prediction>(&v3),
            scout           : v0,
            match_id        : arg1,
            confidence      : arg3,
            committed_at_ms : v1,
        };
        0x2::event::emit<PredictionCommitted>(v4);
        v3
    }

    public fun compute_commit_hash(arg0: u64, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: vector<u8>) : vector<u8> {
        let v0 = u64_to_le_bytes(arg0);
        0x1::vector::push_back<u8>(&mut v0, arg1);
        0x1::vector::push_back<u8>(&mut v0, arg2);
        0x1::vector::push_back<u8>(&mut v0, arg3);
        0x1::vector::push_back<u8>(&mut v0, arg4);
        0x1::vector::append<u8>(&mut v0, arg5);
        0x2::hash::keccak256(&v0)
    }

    fun ensure_scout(arg0: &mut League, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, ScoutRecord>(&arg0.scouts, arg1)) {
            let v0 = ScoutRecord{
                commitments    : 0,
                settled        : 0,
                hits           : 0,
                exacts         : 0,
                points         : 0,
                current_streak : 0,
                best_streak    : 0,
                updated_at_ms  : arg2,
            };
            0x2::table::add<address, ScoutRecord>(&mut arg0.scouts, arg1, v0);
            0x1::vector::push_back<address>(&mut arg0.scout_index, arg1);
        };
    }

    public fun has_scout(arg0: &League, arg1: address) : bool {
        0x2::table::contains<address, ScoutRecord>(&arg0.scouts, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LeagueAdminCap{id: 0x2::object::new(arg0)};
        let v1 = League{
            id                : 0x2::object::new(arg0),
            admin             : 0x2::object::id<LeagueAdminCap>(&v0),
            total_commitments : 0,
            total_settled     : 0,
            matches           : 0x2::table::new<u64, MatchResult>(arg0),
            scouts            : 0x2::table::new<address, ScoutRecord>(arg0),
            scout_index       : vector[],
        };
        0x2::transfer::share_object<League>(v1);
        0x2::transfer::transfer<LeagueAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun match_recorded(arg0: &League, arg1: u64) : bool {
        0x2::table::contains<u64, MatchResult>(&arg0.matches, arg1)
    }

    public fun match_result(arg0: &League, arg1: u64) : (u8, u8, u8) {
        let v0 = 0x2::table::borrow<u64, MatchResult>(&arg0.matches, arg1);
        (v0.outcome, v0.home_score, v0.away_score)
    }

    public fun prediction_hit(arg0: &Prediction) : bool {
        arg0.hit
    }

    public fun prediction_match_id(arg0: &Prediction) : u64 {
        arg0.match_id
    }

    public fun prediction_points(arg0: &Prediction) : u64 {
        arg0.points_awarded
    }

    public fun prediction_settled(arg0: &Prediction) : bool {
        arg0.settled
    }

    public fun record_result(arg0: &LeagueAdminCap, arg1: &mut League, arg2: u64, arg3: u8, arg4: u8, arg5: u8, arg6: &0x2::clock::Clock) {
        assert!(0x2::object::id<LeagueAdminCap>(arg0) == arg1.admin, 3);
        assert!(arg3 <= 2, 2);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = MatchResult{
            outcome        : arg3,
            home_score     : arg4,
            away_score     : arg5,
            recorded_at_ms : v0,
        };
        if (0x2::table::contains<u64, MatchResult>(&arg1.matches, arg2)) {
            *0x2::table::borrow_mut<u64, MatchResult>(&mut arg1.matches, arg2) = v1;
        } else {
            0x2::table::add<u64, MatchResult>(&mut arg1.matches, arg2, v1);
        };
        let v2 = ResultRecorded{
            league         : 0x2::object::id<League>(arg1),
            match_id       : arg2,
            outcome        : arg3,
            home_score     : arg4,
            away_score     : arg5,
            recorded_at_ms : v0,
        };
        0x2::event::emit<ResultRecorded>(v2);
    }

    public fun scout_address_at(arg0: &League, arg1: u64) : address {
        *0x1::vector::borrow<address>(&arg0.scout_index, arg1)
    }

    public fun scout_count(arg0: &League) : u64 {
        0x1::vector::length<address>(&arg0.scout_index)
    }

    public fun scout_stats(arg0: &League, arg1: address) : (u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::table::borrow<address, ScoutRecord>(&arg0.scouts, arg1);
        (v0.commitments, v0.settled, v0.hits, v0.exacts, v0.points, v0.current_streak, v0.best_streak)
    }

    public fun settle_prediction(arg0: &mut League, arg1: &mut Prediction, arg2: u8, arg3: u8, arg4: u8, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg1.league == 0x2::object::id<League>(arg0), 4);
        assert!(arg1.scout == 0x2::tx_context::sender(arg7), 5);
        assert!(!arg1.settled, 6);
        assert!(arg2 <= 2, 2);
        assert!(0x2::table::contains<u64, MatchResult>(&arg0.matches, arg1.match_id), 8);
        assert!(compute_commit_hash(arg1.match_id, arg2, arg3, arg4, arg1.confidence, arg5) == arg1.commit_hash, 7);
        let v0 = *0x2::table::borrow<u64, MatchResult>(&arg0.matches, arg1.match_id);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = arg2 == v0.outcome;
        let v3 = if (v2) {
            if (arg3 == v0.home_score) {
                arg4 == v0.away_score
            } else {
                false
            }
        } else {
            false
        };
        let v4 = 0;
        if (v2) {
            let v5 = 10;
            v4 = v5;
            if (v3) {
                v4 = v5 + 15;
            };
        };
        arg1.settled = true;
        arg1.revealed_outcome = arg2;
        arg1.revealed_home = arg3;
        arg1.revealed_away = arg4;
        arg1.hit = v2;
        arg1.exact = v3;
        arg1.points_awarded = v4;
        let v6 = 0x2::table::borrow_mut<address, ScoutRecord>(&mut arg0.scouts, arg1.scout);
        v6.settled = v6.settled + 1;
        v6.points = v6.points + v4;
        if (v2) {
            v6.hits = v6.hits + 1;
            v6.current_streak = v6.current_streak + 1;
            if (v6.current_streak > v6.best_streak) {
                v6.best_streak = v6.current_streak;
            };
        } else {
            v6.current_streak = 0;
        };
        if (v3) {
            v6.exacts = v6.exacts + 1;
        };
        v6.updated_at_ms = v1;
        arg0.total_settled = arg0.total_settled + 1;
        let v7 = PredictionSettled{
            league         : 0x2::object::id<League>(arg0),
            prediction     : 0x2::object::id<Prediction>(arg1),
            scout          : arg1.scout,
            match_id       : arg1.match_id,
            hit            : v2,
            exact          : v3,
            points_awarded : v4,
            total_points   : v6.points,
            settled_at_ms  : v1,
        };
        0x2::event::emit<PredictionSettled>(v7);
    }

    public fun total_commitments(arg0: &League) : u64 {
        arg0.total_commitments
    }

    public fun total_settled(arg0: &League) : u64 {
        arg0.total_settled
    }

    fun u64_to_le_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

