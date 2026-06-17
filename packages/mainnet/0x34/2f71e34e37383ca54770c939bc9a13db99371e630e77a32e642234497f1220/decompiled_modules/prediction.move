module 0x342f71e34e37383ca54770c939bc9a13db99371e630e77a32e642234497f1220::prediction {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PredictionMarket has key {
        id: 0x2::object::UID,
        prediction_count: u64,
    }

    struct PredictionRecord has store, key {
        id: 0x2::object::UID,
        predictor: address,
        match_id: 0x1::string::String,
        choice: u8,
        is_resolved: bool,
        was_correct: bool,
    }

    struct MatchResult has store, key {
        id: 0x2::object::UID,
        match_id: 0x1::string::String,
        home_team: 0x1::string::String,
        away_team: 0x1::string::String,
        home_score: u8,
        away_score: u8,
        competition: 0x1::string::String,
        recorded_at: u64,
    }

    struct PredictionPlaced has copy, drop {
        predictor: address,
        match_id: 0x1::string::String,
        choice: u8,
        record_id: 0x2::object::ID,
    }

    struct PredictionResolved has copy, drop {
        record_id: 0x2::object::ID,
        predictor: address,
        match_id: 0x1::string::String,
        was_correct: bool,
    }

    struct MatchResultRecorded has copy, drop {
        match_id: 0x1::string::String,
        home_team: 0x1::string::String,
        away_team: 0x1::string::String,
        home_score: u8,
        away_score: u8,
    }

    fun clone_string(arg0: &0x1::string::String) : 0x1::string::String {
        0x1::string::utf8(*0x1::string::as_bytes(arg0))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PredictionMarket{
            id               : 0x2::object::new(arg0),
            prediction_count : 0,
        };
        0x2::transfer::share_object<PredictionMarket>(v1);
    }

    public fun place_prediction(arg0: &mut PredictionMarket, arg1: 0x1::string::String, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 2, 0);
        let v0 = 0x2::tx_context::sender(arg3);
        arg0.prediction_count = arg0.prediction_count + 1;
        let v1 = PredictionRecord{
            id          : 0x2::object::new(arg3),
            predictor   : v0,
            match_id    : arg1,
            choice      : arg2,
            is_resolved : false,
            was_correct : false,
        };
        0x2::transfer::transfer<PredictionRecord>(v1, v0);
        let v2 = PredictionPlaced{
            predictor : v0,
            match_id  : clone_string(&arg1),
            choice    : arg2,
            record_id : 0x2::object::id<PredictionRecord>(&v1),
        };
        0x2::event::emit<PredictionPlaced>(v2);
    }

    public fun prediction_count(arg0: &PredictionMarket) : u64 {
        arg0.prediction_count
    }

    public fun record_match_result(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u8, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = MatchResult{
            id          : 0x2::object::new(arg7),
            match_id    : arg1,
            home_team   : arg2,
            away_team   : arg3,
            home_score  : arg4,
            away_score  : arg5,
            competition : arg6,
            recorded_at : 0x2::tx_context::epoch_timestamp_ms(arg7),
        };
        0x2::transfer::share_object<MatchResult>(v0);
        let v1 = MatchResultRecorded{
            match_id   : clone_string(&arg1),
            home_team  : clone_string(&arg2),
            away_team  : clone_string(&arg3),
            home_score : arg4,
            away_score : arg5,
        };
        0x2::event::emit<MatchResultRecorded>(v1);
    }

    public fun resolve_prediction(arg0: &AdminCap, arg1: &mut PredictionRecord, arg2: bool) {
        arg1.is_resolved = true;
        arg1.was_correct = arg2;
        let v0 = PredictionResolved{
            record_id   : 0x2::object::id<PredictionRecord>(arg1),
            predictor   : arg1.predictor,
            match_id    : clone_string(&arg1.match_id),
            was_correct : arg2,
        };
        0x2::event::emit<PredictionResolved>(v0);
    }

    // decompiled from Move bytecode v6
}

