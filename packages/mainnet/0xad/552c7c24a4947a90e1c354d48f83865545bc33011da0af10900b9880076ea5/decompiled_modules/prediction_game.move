module 0x2c9496db107257631c4bad0b8f97593a661f82df83b0bd84500bec57d7738beb::prediction_game {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OracleCap has store, key {
        id: 0x2::object::UID,
    }

    struct MatchRegistry has key {
        id: 0x2::object::UID,
        match_count: u64,
        matches: 0x2::table::Table<u64, Match>,
    }

    struct Match has store {
        match_id: u64,
        label: 0x1::string::String,
        kickoff_ms: u64,
        round: u8,
        settled: bool,
    }

    struct Scoreboard has key {
        id: 0x2::object::UID,
        scores: 0x2::table::Table<address, Score>,
    }

    struct Score has copy, drop, store {
        points: u64,
        streak: u64,
        best_streak: u64,
        graded: u64,
        correct: u64,
    }

    struct Prediction has store, key {
        id: 0x2::object::UID,
        owner: address,
        match_id: u64,
        kind: u8,
        a: u32,
        b: u32,
        c: u32,
        d: u32,
        e: u32,
        created_ms: u64,
    }

    struct OutputRecord has store, key {
        id: 0x2::object::UID,
        owner: address,
        kind: u8,
        blob_id: 0x1::string::String,
        content_hash: 0x1::string::String,
        created_ms: u64,
    }

    struct MatchRegistered has copy, drop {
        match_id: u64,
        label: 0x1::string::String,
        kickoff_ms: u64,
        round: u8,
    }

    struct MatchSettled has copy, drop {
        match_id: u64,
        settled_ms: u64,
    }

    struct PredictionSubmitted has copy, drop {
        prediction_id: 0x2::object::ID,
        owner: address,
        match_id: u64,
        kind: u8,
        a: u32,
        b: u32,
        c: u32,
        d: u32,
        e: u32,
        created_ms: u64,
    }

    struct Scored has copy, drop {
        owner: address,
        points: u64,
        correct: bool,
        streak: u64,
        total_points: u64,
        scored_ms: u64,
    }

    struct ScoreAdjusted has copy, drop {
        owner: address,
        points_removed: u64,
        correct_removed: u64,
        graded_removed: u64,
        total_points: u64,
        adjusted_ms: u64,
    }

    struct OutputRecordCreated has copy, drop {
        output_id: 0x2::object::ID,
        owner: address,
        kind: u8,
        blob_id: 0x1::string::String,
        content_hash: 0x1::string::String,
        created_ms: u64,
    }

    public fun adjust_score(arg0: &OracleCap, arg1: &mut Scoreboard, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        assert!(0x2::table::contains<address, Score>(&arg1.scores, arg2), 7);
        let v0 = 0x2::table::borrow_mut<address, Score>(&mut arg1.scores, arg2);
        let v1 = if (v0.points > arg3) {
            v0.points - arg3
        } else {
            0
        };
        v0.points = v1;
        let v2 = if (v0.correct > arg4) {
            v0.correct - arg4
        } else {
            0
        };
        v0.correct = v2;
        let v3 = if (v0.graded > arg5) {
            v0.graded - arg5
        } else {
            0
        };
        v0.graded = v3;
        let v4 = ScoreAdjusted{
            owner           : arg2,
            points_removed  : arg3,
            correct_removed : arg4,
            graded_removed  : arg5,
            total_points    : v0.points,
            adjusted_ms     : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ScoreAdjusted>(v4);
    }

    public fun grant_oracle(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<OracleCap>(v0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = OracleCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OracleCap>(v2, v0);
        let v3 = MatchRegistry{
            id          : 0x2::object::new(arg0),
            match_count : 0,
            matches     : 0x2::table::new<u64, Match>(arg0),
        };
        0x2::transfer::share_object<MatchRegistry>(v3);
        let v4 = Scoreboard{
            id     : 0x2::object::new(arg0),
            scores : 0x2::table::new<address, Score>(arg0),
        };
        0x2::transfer::share_object<Scoreboard>(v4);
    }

    public fun record_scores(arg0: &OracleCap, arg1: &mut Scoreboard, arg2: vector<address>, arg3: vector<u64>, arg4: vector<bool>, arg5: &0x2::clock::Clock) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3) && v0 == 0x1::vector::length<bool>(&arg4), 6);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            let v3 = *0x1::vector::borrow<u64>(&arg3, v1);
            let v4 = *0x1::vector::borrow<bool>(&arg4, v1);
            if (!0x2::table::contains<address, Score>(&arg1.scores, v2)) {
                let v5 = Score{
                    points      : 0,
                    streak      : 0,
                    best_streak : 0,
                    graded      : 0,
                    correct     : 0,
                };
                0x2::table::add<address, Score>(&mut arg1.scores, v2, v5);
            };
            let v6 = 0x2::table::borrow_mut<address, Score>(&mut arg1.scores, v2);
            v6.points = v6.points + v3;
            v6.graded = v6.graded + 1;
            if (v4) {
                v6.correct = v6.correct + 1;
                v6.streak = v6.streak + 1;
                if (v6.streak > v6.best_streak) {
                    v6.best_streak = v6.streak;
                };
            } else {
                v6.streak = 0;
            };
            let v7 = Scored{
                owner        : v2,
                points       : v3,
                correct      : v4,
                streak       : v6.streak,
                total_points : v6.points,
                scored_ms    : 0x2::clock::timestamp_ms(arg5),
            };
            0x2::event::emit<Scored>(v7);
            v1 = v1 + 1;
        };
    }

    public fun register_match(arg0: &AdminCap, arg1: &mut MatchRegistry, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: u8) {
        assert!(!0x2::table::contains<u64, Match>(&arg1.matches, arg2), 5);
        let v0 = Match{
            match_id   : arg2,
            label      : arg3,
            kickoff_ms : arg4,
            round      : arg5,
            settled    : false,
        };
        0x2::table::add<u64, Match>(&mut arg1.matches, arg2, v0);
        arg1.match_count = arg1.match_count + 1;
        let v1 = MatchRegistered{
            match_id   : arg2,
            label      : arg3,
            kickoff_ms : arg4,
            round      : arg5,
        };
        0x2::event::emit<MatchRegistered>(v1);
    }

    public fun score_of(arg0: &Scoreboard, arg1: address) : (u64, u64, u64, u64) {
        if (!0x2::table::contains<address, Score>(&arg0.scores, arg1)) {
            return (0, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, Score>(&arg0.scores, arg1);
        (v0.points, v0.streak, v0.graded, v0.correct)
    }

    public fun settle_match(arg0: &OracleCap, arg1: &mut MatchRegistry, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(0x2::table::contains<u64, Match>(&arg1.matches, arg2), 2);
        let v0 = 0x2::table::borrow_mut<u64, Match>(&mut arg1.matches, arg2);
        assert!(!v0.settled, 3);
        v0.settled = true;
        let v1 = MatchSettled{
            match_id   : arg2,
            settled_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MatchSettled>(v1);
    }

    public fun submit_output_record(arg0: u8, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 4, 4);
        let v0 = OutputRecord{
            id           : 0x2::object::new(arg4),
            owner        : 0x2::tx_context::sender(arg4),
            kind         : arg0,
            blob_id      : arg1,
            content_hash : arg2,
            created_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        let v1 = OutputRecordCreated{
            output_id    : 0x2::object::id<OutputRecord>(&v0),
            owner        : v0.owner,
            kind         : arg0,
            blob_id      : v0.blob_id,
            content_hash : v0.content_hash,
            created_ms   : v0.created_ms,
        };
        0x2::event::emit<OutputRecordCreated>(v1);
        0x2::transfer::public_transfer<OutputRecord>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun submit_prediction(arg0: &MatchRegistry, arg1: u64, arg2: u8, arg3: u32, arg4: u32, arg5: u32, arg6: u32, arg7: u32, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 4, 4);
        if (arg2 != 3) {
            assert!(0x2::table::contains<u64, Match>(&arg0.matches, arg1), 2);
            assert!(0x2::clock::timestamp_ms(arg8) < 0x2::table::borrow<u64, Match>(&arg0.matches, arg1).kickoff_ms, 1);
        };
        let v0 = Prediction{
            id         : 0x2::object::new(arg9),
            owner      : 0x2::tx_context::sender(arg9),
            match_id   : arg1,
            kind       : arg2,
            a          : arg3,
            b          : arg4,
            c          : arg5,
            d          : arg6,
            e          : arg7,
            created_ms : 0x2::clock::timestamp_ms(arg8),
        };
        let v1 = PredictionSubmitted{
            prediction_id : 0x2::object::id<Prediction>(&v0),
            owner         : v0.owner,
            match_id      : arg1,
            kind          : arg2,
            a             : arg3,
            b             : arg4,
            c             : arg5,
            d             : arg6,
            e             : arg7,
            created_ms    : v0.created_ms,
        };
        0x2::event::emit<PredictionSubmitted>(v1);
        0x2::transfer::public_transfer<Prediction>(v0, 0x2::tx_context::sender(arg9));
    }

    // decompiled from Move bytecode v7
}

